/// @description Unfreeze player and clean up list

var inst = instance_find(player_obj,0)
inst.input_enabled = true
ds_list_destroy(self.line_list)