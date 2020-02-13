/// @description Load JSON object if not yet loaded and pick encounter

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
	
	var chance = random(1) //Which to pick
	var total = 0 //Total of probabilities
	var i = 0 //Which encounter to use
	var l = self.json[?"default"]
	while(total + ds_map_find_value(l[|i],"Chance") < chance && i < ds_list_size(l)){
		total += ds_map_find_value(l[|i],"Chance")
		i++
	}
	var selection = l[|i]
	self.encounter = selection[?"Enemies"]
}

