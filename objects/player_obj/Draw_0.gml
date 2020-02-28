/// @description Draw self

switch(self.facing){ //Set the correct sprite
	case "N":
	self.sprite_index = asset_get_index(self.sprite_set + "_up_spr")
	break
	
	case "S":
	self.sprite_index = asset_get_index(self.sprite_set + "_down_spr")
	break
	
	case "E":
	self.sprite_index = asset_get_index(self.sprite_set + "_right_spr")
	break
	
	case "W":
	self.sprite_index = asset_get_index(self.sprite_set + "_left_spr")
	break
}
show_debug_message(self.sprite_set)
draw_self()
