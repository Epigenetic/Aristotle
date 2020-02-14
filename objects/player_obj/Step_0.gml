/// @description Cetntralized input handling

if(self.input_enabled){ //Move palyer and change direction facing if input enabled
	if(keyboard_check(vk_left)){
		self.facing = "W"
		self.hspeed = -2
	}else if(keyboard_check(vk_right)){
		self.facing = "E"
		self.hspeed = 2
	}
	
	if(keyboard_check(vk_down)){
		self.facing = "S"
		self.vspeed = 2
	}else if(keyboard_check(vk_up)){
		self.facing = "N"
		self.vspeed = -2
	}
	
	if(keyboard_check_released(vk_left) || keyboard_check_released(vk_right))
		self.hspeed = 0
	
	if(keyboard_check_released(vk_up) || keyboard_check_released(vk_down))
		self.vspeed = 0
}else{
	self.hspeed = 0
	self.vspeed = 0
}