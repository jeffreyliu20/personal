class Grid {
  int x;
  int y;
  int cstate;
  int rx;
  int ry;
  char letter;
  Grid(int sx, int sy, int rw, int rh, int ste, char ch) {
    x=sx;
    y=sy;
    cstate=ste;
    rx=rw;
    ry=rh;
    letter=ch;
  }
  Grid(int sx, int sy, int rw, int rh, int ste) {
    x=sx;
    y=sy;
    cstate=ste;
    rx=rw;
    ry=rh;
  }
  void display() {
    if (cstate==GREY) {
      fill (210);
    }
    else if (cstate==YELLOW) {
      fill (#F0C21D);
    }
    else if (cstate==GREEN) {
      fill (#2AED00);
    }
    rect(x,y,rx,ry);
    textAlign(CENTER);
    textSize(64);
    fill(255);
    text(letter,x+(rx/2),y+(ry*2/3));
}
}
