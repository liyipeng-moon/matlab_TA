function pixs=deg2pix(degree,inch,pwidth,vdist) 

screenWidth = inch*2.54/sqrt(1+9/16); 
pix=screenWidth/pwidth; 
pixs = round(2*tan((degree/2)*pi/180) * vdist / pix); 