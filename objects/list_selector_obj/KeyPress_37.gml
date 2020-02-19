/// @description Move cursor left

if(self.current == 0){
	if(self.list[|self.start+self.current+1] != undefined)
		self.current = 1
}else if (self.current == 2){
	if(self.list[|self.start+self.current+1] != undefined)
		self.current = 3
}else
	self.current--