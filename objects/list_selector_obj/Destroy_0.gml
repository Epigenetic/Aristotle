/// @description Clean up

if(self.type == 2){
	for(var i = 0; i < ds_list_size(self.list); i++)
		ds_list_replace(self.list,i,noone)
	ds_list_destroy(self.list)	
}