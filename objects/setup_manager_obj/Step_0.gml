/// @description Create player

if room == test_rm{
	instance_create_depth(448,320,self.depth,player_obj)
	instance_destroy(self)
}