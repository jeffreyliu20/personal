Paddle p0;
void setup() {
  fullScreen();
  background(0);
  p0=new Paddle(width/15,10);
  p0.display();
}
void draw() {
  background(0);
  p0.move();
  p0.display();
}
