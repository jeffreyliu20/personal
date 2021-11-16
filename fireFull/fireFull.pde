int DIRT=0;
int FIRE=1;
int BURNT=2;
int TREE=3;
int NONE=99;
Land plots[][];

void setup() {
  frameRate(5);
  size (800,800);
  setupLand(200,200,55);
  drawLands();
}
void draw() {
  drawLands();
  liveFire();
}
void liveFire() {
  for (int r=0; r<plots.length; r++) {
  for (int i=1; i<plots.length; i++) {
    if (i==(plots.length-1)) {
      if (r==0) { 
       plots[r][i].changeState(NONE, plots[r][i-1].state,NONE,plots[r+1][i].state);
    }
    else if (r==(plots.length-1)) { 
      plots[r][i].changeState(plots[r-1][i].state,NONE,plots[r][i-1].state, NONE);
    }
    else {
    plots[r][i].changeState(plots[r+1][i].state,NONE,plots[r-1][i].state,plots[r][i-1].state);
  }
    }
    else {
    if (r==0) { 
       plots[r][i].changeState(NONE, plots[r][i-1].state,plots[r][i+1].state,plots[r+1][i].state);
    }
    else if (r==(plots.length-1)) { 
      plots[r][i].changeState(plots[r-1][i].state,plots[r][i+1].state,plots[r][i-1].state,NONE);
    }
    else {
    plots[r][i].changeState(plots[r+1][i].state,plots[r][i+1].state,plots[r-1][i].state,plots[r][i-1].state);
  }
  }
  }
   for (int i=1; i<plots.length; i++) {
    plots[r][i].updateState();
  }
  plots[r][0].state=BURNT;
}
}

  

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
