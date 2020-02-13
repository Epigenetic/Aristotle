/// @description Clean up

room_goto(self.return_to) //Go back to where we started

var inst = instance_find(player_obj,0)
inst.status = self.player_status

ds_list_destroy(self.enemies)
ds_map_destroy(self.json)