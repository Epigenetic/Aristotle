/// @description Create player

if room == test_rm{
	var inst = instance_create_depth(448,320,self.depth,player_obj)
	inst.moves = ds_list_create()
	ds_list_add(inst.moves,"Slash","Punch","Stab","Spit","Cuss")
	inst.inventory = ds_list_create()
	var arr;
	arr[0] = "Potion"
	arr[1] = 2
	var arr1;
	arr1[0] = "Poison"
	arr1[1] = 1
	ds_list_add(inst.inventory,arr,arr1)
	
	for(var i = 0; i < ds_list_size(global.village_list);i++){
		 var pos = json_load("Villagers/",ds_list_find_value(global.village_list,i)+".json")
		 instance_create_depth(pos[?"startingx"],pos[?"startingy"],self.depth,asset_get_index(ds_list_find_value(global.village_list,i)+"_obj"))
		 ds_map_destroy(pos)
	}
	
	instance_destroy(self)
}