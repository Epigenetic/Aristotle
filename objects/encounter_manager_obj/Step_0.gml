/// @description Load JSON object if not yet loaded and pick encounter

if(self.delete){
	instance_destroy(self)
	return;
}

if(self.json == noone){ //Do nothing if we already read in JSON
	
	if(self.file == noone) //Do nothing until given file by creator
		return;
	
	self.json = json_load("",self.file)
	
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

//Handle player and enemy turns
if(self.turn == 0){ //player's turn	
	if(self.selection == noone)
		return;
	button_obj.active = false

	switch(self.selection){
		case 0: //attack
		//Create list selector to find which attack to use
		if(instance_number(list_selector_obj) == 0 && self.subselection == noone){
			var inst = instance_create_depth(button_obj.x,button_obj.y,self.depth,list_selector_obj)
			inst.list = self.player_moves
			inst.type = 1
		}
		
		//wait for selection to be made
		if(self.subselection == noone)
			return;

		//Create list selector to pick enemy to hit unless there is only one enemy
		if(instance_number(list_selector_obj) == 0){
			var inst = instance_create_depth(button_obj.x,button_obj.y,self.depth,list_selector_obj)
			inst.list = self.encounter
			inst.type = 2
		}

		if(self.enemy_selection == noone)
			return;
		
		var move = json_load("PlayerMoves/",self.subselection+".json")
		
		var skip = 0
		var enemy
		for(var i = 0; i < ds_list_size(self.encounter); i++){
			if(ds_map_find_value(self.encounter[|i],"Health") == 0)
				skip++
			
			if(i-skip == self.enemy_selection){
				enemy = self.encounter[|i]
				break
			}
		}
		enemy[?"Health"] -= move[?"Damage"] + irandom_range(-1*move[?"Variance"],move[?"Variance"])
		if(enemy[?"Health"] <= 0)
			self.enemies--
		
		break
		
		case 1: //inventory
		
		break
		
		case 2: // run TODO: Chance of running rather than guarantee
		room_goto(self.return_to)
		self.delete = true
		return;
		break
	}
	//Clear state for next player move
	self.selection = noone
	self.subselection = noone
	self.enemy_selection = noone
	self.turn++
}else{
	//The enemy making a move
	var enemy = self.encounter[|self.turn-1]

	var moves = json_load("Moveset/", enemy[?"Moveset"])
	var selection = irandom(ds_list_size(moves[?"Attacks"])-1) // Which move to use
	var attacks =moves[?"Attacks"] 
	var move = attacks[|selection] //The move being used
	self.player_status -= move[?"Damage"] + irandom_range(-1*move[?"Variance"],move[?"Variance"]) //Deal the damage
	
	//Find who goes next
	var i = 1
	while(self.turn+i < ds_list_size(self.encounter) && ds_map_find_value(self.encounter[|self.turn+i-1],"Health") <= 0 && self.turn+i <= 3){
		i++
	}
	self.turn = self.turn+i == 4 || self.turn+i >= ds_list_size(self.encounter)? 0: self.turn+i
	
	ds_map_destroy(moves) //Clean up
	
	if(self.turn == 0)
		button_obj.active = true
}