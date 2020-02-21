/// @description Initialize variables and freeze player

self.text = noone
self.start_line = 0//line to start printing on
self.line_list = ds_list_create()//list of lines to print
self.line_length = 20//characters per line
self.draw_lines = 3//lines displayed at once

//freeze player
if(instance_number(player_obj)>0)
	player_obj.input_enabled = false