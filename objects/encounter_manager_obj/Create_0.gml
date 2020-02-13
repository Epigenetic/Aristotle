/// @description Initialize variables

self.file = noone
self.json = noone
self.return_to = room
self.enemies = 0 //number of enemies left

var player = instance_find(player_obj,0)
self.player_status = player.status
self.player_sprite = player.sprite_set

self.turn = 0 // turn 0 = player, 1-3 = enemies
self.selection = noone

room_goto(combat_rm)