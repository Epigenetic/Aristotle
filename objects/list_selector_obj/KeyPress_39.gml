/// @description Move cursor right

if(self.current == 1)
	self.current = 0
else if (self.current == 3)
	self.current = 1
else
	if(self.list[|self.start+self.current+1] != undefined)
		self.current++