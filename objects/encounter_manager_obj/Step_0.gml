/// @description Encounter loop

if(room != combat_rm && !instance_exists(death_manager_obj)){
	self.delete = true
}

if(self.delete){
	instance_destroy(self)
	return;
}

if(room != combat_rm)
	return;

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

//If player has died
if(self.player_status <= 0){
	//IF there is noone to reincarnate as, game over
	if(ds_list_size(global.village_list) == 0){
		instance_destroy(self)
		room_goto(game_over_rm)
	}else{
		//Pick a random new npc to play as
		var i = irandom(ds_list_size(global.village_list)-1)
		self.player_sprite = ds_list_find_value(global.village_list,i)
		ds_list_delete(global.village_list,i)
		
		//Modify information to reflect new player
		var pos = json_load("Villagers/",self.player_sprite + ".json")
		self.player_x = pos[?"startingx"]
		self.player_y = pos[?"startingy"]
		self.player_status = pos[?"health"]
		ds_map_destroy(pos)
		
		//Go back
		room_goto(reincarnation_rm)
	}
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
		if(instance_number(list_selector_obj) == 0 && self.enemy_selection == noone){
			var inst = instance_create_depth(button_obj.x,button_obj.y,self.depth,list_selector_obj)
			inst.list = self.encounter
			inst.type = 2
		}

		//Wait for enemy selection
		if(self.enemy_selection == noone)
			return;
			
		// If information on damage has not been shown yet
		if(!self.text_shown){
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
			var damage = move[?"Damage"] + irandom_range(-1*move[?"Variance"],move[?"Variance"])
			enemy[?"Health"] -= damage
			if(enemy[?"Health"] <= 0)
				self.enemies--
		}
		
		//If no text box made make it
		if(instance_number(list_selector_obj) == 0 && self.subselection == noone){
			with instance_create_depth(self.x,self.y,self.depth,dialogue_text_obj){
				text = "Used " + other.subselection + " and dealt " + string(damage) + " damage"
			}
			self.text_shown = true
		}
		
		//Wait for text box to finish
		if(instance_number(dialogue_text_obj) > 0)
			return;
		
		break
		
		case 1: //inventory
		if(instance_number(dialogue_text_obj) == 0 && self.subselection == noone){
			var inst = instance_create_depth(button_obj.x,button_obj.y,self.depth,list_selector_obj)
			inst.list = self.player_inventory
			inst.type = 3
		}
		
		//Wait for inventory selection
		if(self.subselection == noone)
			return;
			
		var display_text = ""
		var choice = self.player_inventory[|self.subselection]
		var item = json_load("Items/",choice[0] + ".json")
		
		if(item[?"Type"] == "Player"){ //Effect to player
			
			if(item[?"Stat"] == "Health"){ //Effects health
				self.player_status += item[?"Effect"]
				display_text = "You healed for " + string(item[?"Effect"]) + " points."
			}else{ //TODO: Other stats
				show_debug_message("Undhandled stat in player use item: " + item[?"Stat"])
			}
		}else if(item[?"Type"] == "Enemy"){ //Effect to enemy
			
			//Create list selector to pick enemy to hit unless there is only one enemy
			if(instance_number(list_selector_obj) == 0 && self.enemy_selection == noone){
				var inst = instance_create_depth(button_obj.x,button_obj.y,self.depth,list_selector_obj)
				inst.list = self.encounter
				inst.type = 2
			}
			
			//Wait for enemy selection
			if(self.enemy_selection == noone)
				return;
				
			//Effect Correct enemy
			if(!self.text_shown){
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
			
				if(item[?"Stat"] == "Health"){//Effects health
					enemy[?"Health"] += item[?"Effect"]
					if(enemy[?"Health"] <= 0)
						self.enemies--
					display_text = enemy[?"Type"] + " dealt " + string(enemy[?"Stat"]) + " damage."
				}else{//TODO: Other stats
					show_debug_message("Unhandled stat in enemy use item: " + item[?"Stat"])
				}
			}
			
			
		}else{ //No effect
			display_text = "It had no effect"
		}
		
		choice[1]--
		if(choice[1] == 0){
			ds_list_delete(self.player_inventory,self.subselection)
		}
		
		if(display_text == ""){
			show_debug_message("Empty")
		}
		//If no text box made make it
		if(instance_number(list_selector_obj) == 0 && !self.text_shown){
			with instance_create_depth(self.x,self.y,self.depth,dialogue_text_obj){
				text = display_text
			}
			self.text_shown = true
		}
		show_debug_message(instance_number(dialogue_text_obj))
		//Wait for text box to finish
		if(instance_number(dialogue_text_obj) > 0)
			return;
			
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
	self.text_shown = false
	self.turn++
}else{
	
	if(!self.text_shown){
		//The enemy making a move
		var enemy = self.encounter[|self.turn-1]

		var moves = json_load("Moveset/", enemy[?"Moveset"])
		var selection = irandom(ds_list_size(moves[?"Attacks"])-1) // Which move to use
		var attacks =moves[?"Attacks"] 
		var move = attacks[|selection] //The move being used
		var damage = move[?"Damage"] + irandom_range(-1*move[?"Variance"],move[?"Variance"]) //Deal the damage
		self.player_status -= damage
	}
	
	if(instance_number(dialogue_text_obj) == 0 && !self.text_shown){
		with instance_create_depth(self.x,self.y,self.depth,dialogue_text_obj){
			text = enemy[?"Type"] + " used " + move[?"Name"] + " and dealt " + string(damage) + " damage"
		}
		self.text_shown = true
		ds_map_destroy(moves) //Clean up
	}
	
	if(instance_number(dialogue_text_obj) > 0)
		return;
	
	//Find who goes next
	var i = 1
	while(self.turn+i < ds_list_size(self.encounter) && ds_map_find_value(self.encounter[|self.turn+i-1],"Health") <= 0 && self.turn+i <= 3){
		i++
	}
	
	//determine turn, if it is 4 wrap around to 0, if it is beyond the number of enemies, wrap aroudn to 0, otherwise increment it by i
	self.turn = self.turn+i == 4 || self.turn+i >= ds_list_size(self.encounter)+1? 0: self.turn+i
	
	if(self.turn == 0)
		button_obj.active = true
	self.text_shown=false
}