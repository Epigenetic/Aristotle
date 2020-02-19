/// @description Move cursor up

if(self.current <= 1){
	if(self.list[|self.start-1] != undefined){
		self.start -= 4
		self.current += 2
	}
}else{
		self.current -= 2
}