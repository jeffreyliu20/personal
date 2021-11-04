int ballcount;
Ball balls[];
Brick br;
void setup(){
  size (500,500);
  frameRate(60);
  ballcount=10;
  balls = new Ball[ballcount];
  for (int i = 0; i<balls.length; i++) {
    balls[i] = new Ball();
  }
  br = new Brick();
}
void draw(){
  background (0);
  for (int i = 0; i<balls.length; i++) {
    balls[i].display();
  }
  br.display(); 
  if (this.detect(balls[i])) {
    b0.c = color(255, 255, 0);
    b1.c = color(255, 255, 0);
  }
  else if (br.detect(b0) == true) {
    br.c = color(0, 255, 0);
    b0.c = color(255, 0, 0);
  }
  else if (br.detect(b1) == true) {
    br.c = color(0, 255, 0);
    b1.c = color(255, 0, 0);
  }
  else {
    br.c = color(255);
    b0.c = color(255);
    b1.c = color(255);
  }
}
