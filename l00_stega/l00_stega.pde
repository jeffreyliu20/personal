/* ===================
  The goal of this lab is to write a setganography
  encoding/decoding program.
  This program should encode a scret message within the blue
  value of randomly selected pixels.
  Pixels that contain part of the message will have a red
  value of 255.
  Any pixels that naturally have a red value of 255 will
  change to have a red value of 254.
  To test your decoding function, secret.png has been
  provided. When successfully decoded, you should get
  "hi everybody!"
  Once you know decoding is working, then work on encode,
  and use decode to test your work, then modify the
  keyPressed method to load a normal image.
 =================== */
PImage art;

void setup() {
  size(256, 256);
  art = loadImage("secret.png");
  art.loadPixels();

  image(art, 0, 0);
}

void draw() {
  image(art, 0, 0);
}

void keyPressed() {
  if (key == 'r') {
    art = loadImage("secret.png");
  }
  if (key == 'e') {
    art = encode(art, "hi everybody!");
    image(art, 0, 0);
    saveFrame("data/secret.png");
  }
  if (key == 'd') {
    println(decode(art));
  }
}//keyPressed

/* ===================
  This function will take an image with a secret message encoded
  via encode, and return the secret message as a String.
  You can concatenate chars with Strings by using +=
  on a String variable. (e.g. message+= 'a')
 =================== */
String decode(PImage img) {
  String message = "";
  for (int i = 0; i <img.pixels.length; i++) {
    color c=img.pixels[i];
    int r = int(red(c));
    if (r==255) {
      int g = int(blue(c));
      message += char(g);
    }
  }
  return message;
}


/* ===================
  This function will return an array of randomly chosen integers used
  to help encode our secret message.
  The returned array should contain numSecret random values in the range
  [0, numPixels].
  The random values should be in strcictly increasing order.
 =================== */
int[] getSecretPixels(int numSecrets, int numPixels) {
  int[] secretPixels = new int[ numSecrets ];
  for (int i=0; i<=secretPixels.length-1;i++) {
    secretPixels[i]=int(random(0,numPixels+1));
  secretPixels=sort(secretPixels);
  return secretPixels;
}
}


/* ===================
  This function will return a new PImage that encodes secret in the
  blue value of randomly chosen pixels.
  Pixels that contain encoded chars should have a red value of 255,
  a green value the same as the original image, and a blue value of
  the next charater in message.
  Any pixels in the original image with a red value of 255 should
  become pixels with the same green and blue values, and a red value
  of 254.
  The indices of the encoded pixels will be randomly generated
  by getSecretPixels
  secret.charAt(i) will return the character of secret at index i.
 =================== */
PImage encode(PImage img, String secret) {
  PImage tmp = new PImage(img.width, img.height);
  tmp.loadPixels();

  int[] secretPixels = getSecretPixels(secret.length(), img.pixels.length);

  return tmp;
}//encode
