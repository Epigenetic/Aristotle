/// @description Try to cause encounter

if(other.hspeed == 0 || other.vspeed == 0) //can't get encounter while standing still
	return;

if(self.cooldown-- == 0){ //Don't try to cause an encounter every frame
	self.cooldown = .5*room_speed
	if(random(10) >= 2){ //eight in ten
		var inst = instance_create_depth(other.x,other.y,other.depth,encounter_manager_obj)
		inst.file = "Spawn/test.json"
	}
}