/// @description Advance lines

if(self.start_line + self.draw_lines>= ds_list_size(self.line_list)) //If out of lines, destroy, otherwise increment the view
	instance_destroy(self)
else
	self.start_line += self.draw_lines