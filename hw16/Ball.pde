class Ball {
  int cx;
  int cy;
  int xVel;
  int yVel;
  int radius;
  color c;
  Ball() {
    c = 255;
    radius = int(random(10, 26));
    cx = int(random(radius, width-radius));
    cy = int(random(radius, height-radius));
    xVel = int(random(-5, 5));
    if (xVel == 0) { 
      xVel = 5;
    }
    yVel = int(random(-5, 5));
    if (yVel == 0) { 
      yVel = 5;
    }
  } 
  Ball(color f) {
    this();
    c = f;
  }
  void display() {
    fill(c);
    circle(this.cx, this.cy, this.radius*2);
  }
  void move() {
    if (cx <= radius || cx >= (width-radius)) {
      xVel *= -1;
    }
    if ( cy <= radius ||
      cy >= (height-radius)) {
      yVel *= -1;
    }
    cx+= xVel;
    cy+= yVel;
  }
  boolean detect(Ball other) {
    if (dist(cx, cy, other.cx, other.cy) <= (radius + other.radius)) {
      return true;
    }
    return false;
  }
}
