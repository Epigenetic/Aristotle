/// @description Draw text box

if(self.json != noone){ //Do nothing if haven't read in JSON yet
	
	//draw text box
	draw_set_color(c_black)
	draw_rectangle(window_get_width()/5,2*window_get_height()/3,4*window_get_width()/5,window_get_height(),false)
	
	//draw text
	draw_set_color(c_white)
	draw_set_font(arial_fnt)
	for(var i = 0; i < self.draw_lines; i ++){
		draw_text(window_get_width()/5+20,2*window_get_height()/3+60*i+40,self.line_list[|i+self.start_line])
		if(i+1+self.start_line>= ds_list_size(self.line_list)) //handle numlines % draw_lines != 0
			break;
	}
}