/// @description Draw battle (supports 1 player and up to 3 enemies)

//Draw enemies
for (var i = 0; i < ds_list_size(self.encounter);i++){
	if(ds_map_find_value(self.encounter[|i],"Health") <= 0)
		continue
	switch(ds_map_find_value(self.encounter[|i],"Type")){
		case "Test":
		draw_sprite(test_enemy_battle_spr,-1,room_width/6,(i+1)*room_height/5)
		break
		
		default:
		show_debug_message(ds_map_find_value(self.encounter[|i],"Type"))
	}
}

//Draw player
draw_sprite(asset_get_index(self.player_sprite + "_battle_spr"),-1,5*room_width/6,room_height/2)
draw_set_color(c_black)
draw_text(5*room_width/6,room_height/2-40,string(self.player_status))