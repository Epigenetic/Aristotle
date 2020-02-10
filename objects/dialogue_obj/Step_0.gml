/// @description Load JSON object if not yet loaded

if(self.json == noone){ //Do nothing if we already read in JSON
	
	if(self.file == noone) //Do nothing until given file by creator
		return;
		
	//read in dialogue from json file
	var openFile = file_text_open_read(self.file)
	var data = ""
	while(!file_text_eof(openFile)){
		data += file_text_readln(openFile)
	}
	file_text_close(openFile)
	
	self.json = json_decode(data)
	
	//Split string into chunks for display
	var dialogue = self.json[? "Message"]
	for(var i = 0; i < string_length(dialogue); i+=self.line_length){
		ds_list_add(self.line_list,string_copy(dialogue,i+1,self.line_length))
	}
}