/// @description Initialize variables and freeze player
show_debug_message("birth")
self.file = noone //file to open
self.json = noone //JSON data
self.start_line = 0//line to start printing on
self.line_list = ds_list_create()//list of lines to print
self.line_length = 20//characters per line
self.draw_lines = 3//lines displayed at once

//freeze player
var inst = instance_find(player_obj,0)
inst.input_enabled = false