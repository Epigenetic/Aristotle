/// @description Check for dialogue

if(distance_to_object(player_obj) < 30 && keyboard_check_pressed(vk_space) 
  && !instance_exists(dialogue_obj) && self.cooldown == 0){
	var inst = instance_create_depth(x,y,depth,dialogue_obj)
	inst.file = "Dialogue/test.json"
	self.cooldown = 1*room_speed
}

if(!instance_exists(dialogue_obj) && self.cooldown > 0){
	self.cooldown--
}