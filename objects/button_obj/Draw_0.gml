/// @description Draw self

draw_self()

switch(self.selected){
	case 0:
	draw_sprite_general(attack_button_selected_spr,-1,0,0,
		self.image_xscale*self.sprite_width/3,self.image_yscale*self.sprite_height,
		self.x,self.y,self.image_xscale,self.image_yscale,0,c_white,c_white,c_white,c_white,1)
	break
	
	case 1:
	draw_sprite_general(inventory_button_selected_spr,-1,0,0,
		self.image_xscale*self.sprite_width/3,self.image_yscale*self.sprite_height,
		self.x+self.sprite_width/3,self.y,self.image_xscale,self.image_yscale,0,c_white,c_white,c_white,c_white,1)
	break
	
	case 2:
	draw_sprite_general(run_button_selected_spr,-1,0,0,
		self.image_xscale*self.sprite_width/3,self.image_yscale*self.sprite_height,
		self.x+self.sprite_width*(2/3),self.y,self.image_xscale,self.image_yscale,0,c_white,c_white,c_white,c_white,1)
	break
}