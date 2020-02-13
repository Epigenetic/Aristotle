/// @description Load JSON object if not yet loaded and pick encounter

if(self.delete)
	instance_destroy(self)

if(self.json == noone){ //Do nothing if we already read in JSON
	
	if(self.file == noone) //Do nothing until given file by creator
		return;
		
	//read in dialogue from json file
	var openFile = file_text_open_read(self.file)
	var data = ""
	while(!file_text_eof(openFile)){
		data += file_text_readln(openFile)
	}
	file_text_close(openFile)
	
	self.json = json_decode(data)
	
	var chance = random(1) //Which to pick
	var total = 0 //Total of probabilities
	var i = 0 //Which encounter to use
	var l = self.json[?"default"]
	while(total + ds_map_find_value(l[|i],"Chance") < chance && i < ds_list_size(l)){
		total += ds_map_find_value(l[|i],"Chance")
		i++
	}
	var selection = l[|i]
	self.encounter = selection[?"Enemies"]
	self.enemies = ds_list_size(self.encounter)
}

if(self.enemies == 0){ //encounter over
	room_goto(self.return_to) //Go back to where we started
	self.delete = true
}

if(self.turn == 0){ //player's turn	
	if(self.selection == noone)
		return;
	
	switch(self.selection){
		case 0: //attack
		var enemy = self.encounter[|0]
		enemy[?"Health"] -= random(5)
		if(enemy[?"Health"] <= 0)
			self.enemies--
		break
		
		case 1: //inventory
		
		break
		
		case 2: // run
		
		break
	}
	self.selection = noone
	self.turn++
}else{
	var enemy = self.encounter[|self.turn-1]
	var openFile = file_text_open_read("Moveset/" + enemy[?"Moveset"])
	var data = ""
	while(!file_text_eof(openFile)){
		data += file_text_readln(openFile)
	}
	file_text_close(openFile)
	
	var moves = json_decode(data)
	var selection = irandom(ds_list_size(moves[?"Attacks"])-1)
	var attacks =moves[?"Attacks"]
	var move = attacks[|selection]
	self.player_status -= move[?"Damage"] + irandom_range(-1*move[?"Variance"],move[?"Variance"])
	
	var i = 1
	while(self.turn+i < ds_list_size(self.encounter) && ds_map_find_value(self.encounter[|self.turn+i-1],"Health") <= 0 && self.turn+i <= 3){
		i++
	}
	self.turn = self.turn+i == 4 || self.turn+i >= ds_list_size(self.encounter)? 0: self.turn+i
	
	ds_map_destroy(moves)
}