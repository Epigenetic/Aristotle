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
	case 1:
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
	
	case 2:
	
	break
	
	case 3:
	
	break
}