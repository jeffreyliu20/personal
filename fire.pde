int DIRT=0;
int FIRE=1;
int BURNT=2;
int TREE=3;
Land plots[][];

void setup() {
  frameRate(3);
  size (500,300);
  setupLand(50,50,90);
  drawLands();
}
void draw() {
  drawLands();
  //liveFire();
}

//void liveFire() {
//  for (int i=1; i<plots.length; i++) {
//    plots[i].changeState(plots[i-1].state);
//  }
//   for (int i=1; i<plots.length; i++) {
//    plots[i].updateState();
//  }
//  plots[0].state=BURNT;
//}

  

void setupLand(int numRows, int numPlots, float fertility) {
  int plotSize=width/numPlots;
  plots=new Land[numRows][numPlots];
  for (int r=0; r<plots.length; r++) {
  for (int i=0; i<plots.length; i++) {
    if (i==0) {
    plots[r][i]=new Land(i*plotSize,r*plotSize,plotSize, FIRE);
    }
    else {
    if ((int(random(100))<=fertility)) {
    plots[r][i]=new Land(i*plotSize,r*plotSize,plotSize, TREE);
    }
    else {
    plots[r][i]=new Land(i*plotSize,r*plotSize,plotSize, DIRT);
    }
    }
  }
  }
}
void drawLands() {
  for (int r=0; r<plots.length; r++) {
  for (int i=0; i<plots.length; i++) {
    plots[r][i].display();
  }
}
}
