/// @description Load JSON object if not yet loaded

if(self.text == noone) //Do nothing until given text by creator
	return;

if(ds_list_empty(self.line_list)){
	//Split string into chunks for display
	for(var i = 0; i < string_length(self.text); i+=self.line_length){
		ds_list_add(self.line_list,string_copy(self.text,i+1,self.line_length))
	}
}