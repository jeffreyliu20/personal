void setup() {
  size (900,900);
  background(255);
  squareDiagonal (50);
}
void plus (int x, int y, int len) {
  line((x-len),y,(x+len),y);
  line(x,(y-len),x,(y+len));
}
void squareDiagonal (int len) {
  int x,y;
  x=0;
  y=0;
  while (x<width) {
    fill (255);
    rect (x,y,len,len);
    x+= len;
    y+= len;
  }
}
