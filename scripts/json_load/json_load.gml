var path,file
path = argument0
file = argument1

var openFile = file_text_open_read(path + file)
var data = ""
while(!file_text_eof(openFile)){
	data += file_text_readln(openFile)
}
file_text_close(openFile)

return json_decode(data)