/// @description Move cursor down

if(self.current >= 2){
	if(self.list[|self.start+4] != undefined){ //make sure their are items after this
		self.start += 4
		self.current -= 2
	}
}else{
	if(self.list[|self.start+self.current+2] != undefined)//don't move into blank spot
		self.current += 2
}