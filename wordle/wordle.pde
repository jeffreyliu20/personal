String target = "MONTH";
String tmp = " ";
int[] state = {2, 2, 1, 1, 0};
String[] storage;
int loc;
int GREY=0;
int YELLOW=1;
int GREEN=2;
int attempts;
int running=0;
Grid game[][];

import java.util.Arrays;

void setup() {
  state=new int[5];
  size(335, 600);
  background(30);
  frameRate(1);
  storage=new String[5];
  //selectWord();
  println(verify("hello"));
  println(compare1("hello", "hello"));
  setupGrid(6, 5);
  drawGrid(6, 5);
}

void draw() {
  drawGrid(6, 5);
  keyReleased();
}
void setupGrid (int numRows, int numCols) {
  game=new Grid[numRows][numCols];
  for (int rowy=0; rowy<=numRows-1; rowy++) {
    for (int rowx=0; rowx<=numCols-1; rowx++) {
      game[rowy][rowx]=new Grid(rowx*width/5, rowy*height/6, width/5, height/6, GREY, ' ');
    }
  }
}
void drawGrid(int numRows, int numCols) {
  for (int rowy=0; rowy<numRows; rowy++) {
    for (int rowx=0; rowx<numCols; rowx++) {
      game[rowy][rowx].display();
    }
  }
}
void updateTile(int l, char let) {
  game[attempts][l].cstate=GREY;
  game[attempts][l].letter=let;
  game[attempts][l].display();
  storage[l]=str(let);
}
void updateAns(int l) {
  game[attempts][l].cstate=state[l];
  //game[attempts][l].letter=let;
  game[attempts][l].display();
  //storage[l]=str(let);
}

String selectWord () {
  String[] wordList = loadStrings("words_reasonable.csv");
  String[] words = split(wordList[0], ',');
  int targetNum = int(random(words.length));
  target = (words[targetNum]);
  return target;
}

boolean verify (String answer) {
  String[] wordList = loadStrings("words.csv");
  String[] words = split(wordList[0], ',');
  for (int i=0; i<words.length; i++) {
    if (answer.equals(words[i])) {
      return true;
    }
  }
  return false;

  //return false;
}

boolean compare1 (String targetWord, String submission) {
  submission=submission.toLowerCase();
  String[] targetChars = targetWord.split("");
  String[] answerChars = submission.split("");
  println(answerChars[0]);
  println(targetChars[0]);
  for (int i=0; i <5; i++) {
    for (int r=0; r <5; r++) {
      if (answerChars[i].equals(targetChars[r])) {
        println(answerChars[i]);
        return false;
      }
    }
    if (targetChars[i].equals(answerChars[i])) {
      return true;
    }
  }
  return false;
}

void compare (String targetWord, String submission) {
  submission=submission.toLowerCase();
  String[] targetChars = targetWord.split("");
  String[] answerChars = submission.split("");
  println("target characters: " + Arrays.toString(targetChars));
  println("answer characters: " + Arrays.toString(answerChars));
  for (int i=0; i <5; i++) {
    if (answerChars[i].equals(targetChars[i])) {
      println("ISGREEN"+i);
      state[i]=GREEN;
    } else {
      for (int r=0; r <5; r++) {
        //println("target");
        if (targetChars[i].equals(answerChars[r])) {
          //println("ytho");
          //println(answerChars[i]);
          state[i]=YELLOW;
        }
      }

      if (state[i]!=YELLOW) {
        //println("BRUHWHY"+i);
        state[i]=GREY;
      }
    }
    println("state: " + Arrays.toString(state));
    //if (targetChars[i].equals(answerChars[i])){
    //  println(answerChars[i]);
    //  println(targetChars[i]);
    //state[i]=GREEN;
    //}
  }
}

boolean correct (String ans) {
  if (ans.equals(target)) {
    for (int r=0; r <=5; r++) {
      state[r]=GREEN;
    }
    return true;
  }
  return false;
}

String createAns() {
  String tmp = " ";
  tmp=join(storage, '*');
  tmp=tmp.replaceAll("[^a-zA-Z]", "");
  tmp=tmp.toLowerCase();
  return tmp;
}
void keyReleased() {
  if (((key>=65)&&(key<=90))&&(loc<5)) {
    updateTile (loc, key);
  }
  if (((key>=97)&&(key<=122))&&(loc<5)) {
    updateTile (loc, char(key-32));
    key=1;
    loc+=1;
  }
  if (((key==8) || (key==127))&&(loc<=5)) {
    updateTile (loc-1, char(32));
    key=1;
    loc-=1;
  }
  if ((key==ENTER)&&(loc==5)) {
    tmp=createAns();
    if (verify(tmp)) {
      loc=0;
      for (int i=0; i<5; i++) {
        compare(tmp, target);
        //print(state[0]);
        updateAns (i);
      }
      attempts+=1;
      loc=0;
      key=1;
    }
  }
}
