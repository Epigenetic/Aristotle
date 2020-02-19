/// @description Create player

if room == test_rm{
	var inst = instance_create_depth(448,320,self.depth,player_obj)
	inst.moves = ds_list_create()
	ds_list_add(inst.moves,"Slash","Punch","Stab","Spit","Cuss")
	instance_destroy(self)
}