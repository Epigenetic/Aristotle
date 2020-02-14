/// @description Initialize variables

self.file = noone //File to load
self.json = noone //JSON
self.return_to = room //Room to return to after encoutner
self.enemies = 0 //number of enemies left

var player = instance_find(player_obj,0) //Copy in player information
self.player_status = player.status
self.player_sprite = player.sprite_set

self.turn = 0 // turn 0 = player, 1-3 = enemies
self.selection = noone //Player's selection of move

self.delete = false //whether to delete instance on next frame (need to give a frame to go from battle room to where it started)

room_goto(combat_rm)