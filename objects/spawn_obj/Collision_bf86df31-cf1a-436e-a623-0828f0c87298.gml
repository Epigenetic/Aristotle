/// @description Try to cause encounter

if(self.cooldown-- == 0){
	self.cooldown = .5*room_speed
	if(random(10) >= 9){ //one in ten
		var inst = instance_create_depth(other.x,other.y,other.depth,encounter_manager_obj)
		inst.file = "Spawn/test.json"
	}
}