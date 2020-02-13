/// @description Clean up

var inst = instance_find(player_obj,0)
inst.status = self.player_status
inst.hspeed = 0
inst.vspeed = 0

ds_map_destroy(self.json)