/// @description Clean up

var inst = instance_create_depth(self.player_x,self.player_y,self.depth,player_obj)
inst.status = self.player_status //Update player health

ds_map_destroy(self.json)