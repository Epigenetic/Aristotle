/// @description Clean list if necessary

if(!self.initialized && self.list != noone && self.type != noone){
	if(self.type == 2){
		var temp = ds_list_create()
		ds_list_copy(temp,self.list)
		self.list=  temp
		var i = 0
		var offset = 0
		while(self.list[|i-offset] != noone){
			show_debug_message(self.list[|i-offset])
			if(ds_map_find_value(self.list[|i-offset],"Health") == 0){
				ds_list_delete(self.list,i-offset)
				offset++
			}
			i++
		}
	}
	
	self.initialized = true
}