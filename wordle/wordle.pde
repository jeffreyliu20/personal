String target = "hello";
int[] state;
int GREY=0;
int YELLOW=1;
int GREEN=2;
int attempts;

void setup() {
  size(335, 600);
  background(30);
  frameRate(60);
  //font1 = createFont("Helvetica-Bold", 32);
  //println(selectWord());
  //println(correct("hello"));
  compare("hello","hello");

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
  for (int i=0; i<=words.length;i++) {
  if (answer.equals(words[i])) {
    return true;
  }
  else {
  return false;
  }
  }
  return false;
  }

void compare (String targetWord, String submission) {
  String[] targetChars = targetWord.split("");
  String[] answerChars = submission.split("");
  for (int i=0; i <=5; i++) {
    for (int r=0; r <=5; r++) {
    if (answerChars[i].equals(targetChars[r])) {
      state[i]=YELLOW;
    }
    }
    if (targetChars[i].equals(answerChars[i])){
    state[i]=GREEN;
    }
    else {
      state[i]=GREY;
    }
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

//void keyPressed() {
