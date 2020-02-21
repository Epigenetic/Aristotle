/// @description Unfreeze player and clean up list

if(instance_number(player_obj) > 0)
	player_obj.input_enabled = true

ds_list_destroy(self.line_list)