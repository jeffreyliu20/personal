PImage img;

void setup() {
  size(1200, 900);
  img = loadImage("shiba.jpg");

  img.loadPixels();//load the pixels
  //for (int p=0; p < img.pixels.length; p++) {
  //  color pc = img.pixels[p];
  //  float r = (red(pc) + 25) % 256;
  //  float g = (green(pc) + 50) % 256;
  //  float b = (blue(pc) + 100) % 256;
  //  color newpc = color(r, g, b);
  //  img[pixels] = newpc;
  //}
  img.updatePixels();

  image(img, 0, 0);
}
void draw() {
  image(img,0,0);
}
void colorQuad(PImage img) {
  for (int row=0;row<img.height;row++) {
    for (int col=0;col<img.width;col++) {
      int p = row*img.width + col;
      color c=img.pixels[p];
      if (row<img.height/2 && col<img.width/2) {
        color newC=color(red(c),green(c),0);
      img.pixels[p]=newC;}
      if (row>img.height/2 && col<img.width/2) {
        color newC=color(red(c),0,blue(c));
      img.pixels[p]=newC;}
      if (row<img.height/2 && col>img.width/2) {
        color newC=color(0,green(c),blue(c));
      img.pixels[p]=newC;}
    }
  }
}
void keyPressed() {
  if (key=='r') {
    img=loadImage("shiba.jpg");
  }
  if (key=='q') {
    colorQuad(img);
    img.updatePixels();
  }
}
