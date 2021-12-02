class Paddle {
  int px, py, pwidth, pheight,c;
  Paddle() {
    pwidth=10;
    pheight=15;
    px=(width/2)-pwidth/2;
    py=(height/4)*3;
    c=255;
  }
  Paddle(int pwide, int ptall) {
    this();
    pwidth=pwide;
    pheight=ptall;
  }
  void display() {
    fill(c);
    rect(px,py,pwidth,pheight);
  }
  void move() {
    px=mouseX-(pwidth/2);
    if (px<=0) {
      px=1;
    }
    if (px>=(width-pwidth)) {
      px=(width-pwidth)-1;
    }
  //  if ((px<=(width-pwidth)) && (px>=(pwidth/2))) {
  //  px=mouseX-(pwidth/2);
  //}
  }
}
