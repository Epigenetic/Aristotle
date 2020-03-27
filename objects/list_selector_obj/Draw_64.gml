/// @description Draw option selection

if(self.list == noone || self.type == noone)
	return;
	
//draw text box
draw_set_color(c_black)
draw_rectangle(window_get_width()/8,2*window_get_height()/3,7*window_get_width()/8,window_get_height(),false)

draw_set_color(c_white)
draw_set_font(arial_fnt)

//Extract information to print accordingly
switch(self.type){
	case 1://move selection
	draw_text(window_get_width()/8+20,2*window_get_height()/3+20,"Select move:")
	
	//Draw four selected items
	for(var i = 0; i < self.items_shown; i++){
		if(self.list[|i+self.start] == undefined)
			break
		draw_text(window_get_width()/8+40+(window_get_width()/3*(i%2)),2*window_get_height()/3+80+(i>1?80:0),self.list[|i+self.start])
	}
	
	//position cursor accordingly and draw it
	self.x = window_get_width()/8+window_get_width()/3*(self.current % 2)+15
	self.y = 2*window_get_height()/3+80+(self.current>1?80:0)+20
	draw_self()
	break
	
	case 2: //enemy selection
	draw_text(window_get_width()/8+20,2*window_get_height()/3+20,"Select enemy:")
	
	//Draw four selected items
	for(var i = 0; i < self.items_shown; i++){
		if(self.list[|i+self.start] == undefined)
			break
		
		draw_text(window_get_width()/8+40+(window_get_width()/3*(i%2)),2*window_get_height()/3+80+(i>1?80:0),ds_map_find_value(self.list[|i+self.start],"Type"))
	}
	
	//position cursor accordingly and draw it
	self.x = window_get_width()/8+window_get_width()/3*(self.current % 2)+15
	self.y = 2*window_get_height()/3+80+(self.current>1?80:0)+20
	draw_self()
	break
	
	case 3: //inventory selection
	draw_text(window_get_width()/8+20,2*window_get_height()/3+20,"Select item:")
	
	//Draw four selected items
	for(var i = 0; i < self.items_shown; i++){
		if(self.list[|i+self.start] == undefined)
			break
		
		var temp = self.list[|i+self.start]
		draw_text(window_get_width()/8+40+(window_get_width()/3*(i%2)),2*window_get_height()/3+80+(i>1?80:0),temp[0] + " - " + string(temp[1]))
	}
	
	//position cursor accordingly and draw it
	self.x = window_get_width()/8+window_get_width()/3*(self.current % 2)+15
	self.y = 2*window_get_height()/3+80+(self.current>1?80:0)+20
	draw_self()
	break
}