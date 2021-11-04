class Brick {
  int cx, cy, brickh, brickw, c;
  Brick() {
    brickh=int(random(25, 100));
    brickw=int(random(25, 100));
    cx=int(random(0, width-brickw));
    cy=int(random(0, height-brickh));
    c=int(random(0, 255));
  }
  void display() {
    fill(c);
    rect(this.cx, this.cy, this.brickw, this.brickh);
  }
  boolean detect(Ball b) {
     if ((dist(b.cx, b.cy, cx, cy) <= b.radius) || (dist(b.cx, b.cy, cx + brickw, cy) <= b.radius)) {
      return true;
    }
    if ((dist(b.cx, b.cy, cx, cy + brickh) <= b.radius) || (dist(b.cx, b.cy, cx + brickw, cy + brickh) <= b.radius)) {
      return true;
    }
    if ((b.cx >= cx) && (b.cx <= cx + brickw) && (b.cy >= cy - b.radius) && (b.cy <= cy + brickh + b.radius)) {
      return true;
    }    
    if ((b.cx >= cx - b.radius) && (b.cx <= cx + brickw + b.radius) && (b.cy >= cy) && (b.cy <= cy + brickh)) {
      return true;
    }
    return false;
  }
}
