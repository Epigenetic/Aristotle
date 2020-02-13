/// @description Send selection to manager

if(!self.active)
	return;
	
var inst = instance_find(encounter_manager_obj,0)
inst.selection = self.selected
//self.active = false