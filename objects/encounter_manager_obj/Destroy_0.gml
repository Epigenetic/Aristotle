/// @description Clean up

var inst = instance_find(player_obj,0)
inst.status = self.player_status //Update player health
inst.hspeed = 0 //Make sure player doesn't start moving when we move back
inst.vspeed = 0

ds_map_destroy(self.json)