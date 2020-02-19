/// @description Move cursor up

if(self.current >= 2){
	if(self.list[|self.start+4] != undefined){
		self.start += 4
		self.current -= 2
	}
}else{
	if(self.list[|self.start+self.current+2] != undefined)
		self.current += 2
}