/// @description Select item

switch(self.type){
	case 1://move selection
	encounter_manager_obj.subselection = self.list[|self.start+self.current]
	break
	
	case 2: //enemy selection
	encounter_manager_obj.enemy_selection = self.start+self.current
	break
	
	case 3:
	
	break
}

instance_destroy(self)