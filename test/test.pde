int speed, radius, y;

void setup() {
  radius=25;
  speed=1;
  y=radius;
  size (900,900);
  fill (0,0,255);
  circle ((width/2), y, (radius*2));
  background(255);
}
void draw() {
  background(255);
  if (y<=(height/2)) {
    fill (0,0,255);
  }
  else {
    fill (0, 255,0); }
   circle((width/2),y,(radius*2));
   y+=speed;
   if (y==(height-radius)) {
     speed=-1;
     y--;
   }
   if (y==(radius-1)) {
     speed=1;
     y++;
   }
}
