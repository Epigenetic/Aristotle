/// @description Clean up

var inst = instance_create_depth(self.player_x,self.player_y,self.depth,player_obj)
inst.status = self.player_status //Update player health
inst.moves = self.player_moves // Pass moves list back

//Reload all the villagers
for(var i = 0; i < ds_list_size(global.village_list);i++){
	 var pos = json_load("Villagers/",ds_list_find_value(global.village_list,i)+".json")
	 instance_create_depth(pos[?"startingx"],pos[?"startingy"],self.depth,asset_get_index(ds_list_find_value(global.village_list,i)+"_obj"))
	 ds_map_destroy(pos)
}

ds_map_destroy(self.json)