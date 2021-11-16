class Land {
  int x;
  int y;
  int size;
  int state;
  int nextState;
  Land(int sx, int sy, int sze, int ste) {
    x=sx;
    y=sy;
    size=sze;
    state=ste;
  }
  void display() {
    if (state==DIRT) {
      fill (0);
    }
    else if (state==BURNT) {
      fill (#67352B);
    }
    else if (state==FIRE) {
      fill (#FF0000);
    }
    else if (state==TREE) {
      fill (#00FF00);
    }
    rect(x,y,size,size);
}
  void changeState(int neighborStateN,int neighborStateE, int neighborStateW, int neighborStateS) {
    if (state==FIRE) {
      nextState=BURNT;
    }
    else if ((state == TREE) && ( (neighborStateN == FIRE) || (neighborStateE == FIRE) || (neighborStateW == FIRE) || (neighborStateS == FIRE))) {
      nextState=FIRE;
    }
    else {
      nextState=state;
    }
  }
  void updateState() {
    state=nextState;
  }
}
