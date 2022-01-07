/* ===================
In this lab, you will measure the time each
of the sorts take using 3 different metrics:
1. The physical amount of time the method takes
to run, in milliseconds.
2. The number of comparison operations performed.
3. The number of swaps performed.
For this lab, you will need to add timing
code int the setup() method.
You will also need to update the comparison and
swap counting variables in each respective sort.
===================*/

int ARRSIZE = 200000;

int arr0[];
int arr1[];
int arr2[];

/*
  Theses variables will store the
  time, in milliseconds, each sort
  method took to run.
  They should be updated in setup().
*/
int bubbleTime = 0;
int selectTime = 0;
int insertTime = 0;

/*
  These variables will store the number of
  comparison operations performed in each sort.
  These should be updated in the matching sort
  method.
*/
int bubbleCompCount = 0;
int selectCompCount = 0;
int insertCompCount = 0;

/*
  These variables will store the number of
  swap operations performed in each sort.
  These should be updated in the matching sort
  method.
  Note: Do not modify these in swap(), since both
  bubbleSort and selectionSort use swap().
*/
int bubbleSwapCount = 0;
int selectSwapCount = 0;
/*
  The insertion sort does not perform any swaps.
  Instead, it performs assignment (=) operations
  as it shifts values over.
  How can you equate assignments with swaps?
*/
int insertSwapCount = 0;


void setup() {
  size(400, 400);
  background(0);
  //this will make 1 random array, and then 2 copies of it.
  arr0 = randomArray(ARRSIZE);
  arr1 = new int[ARRSIZE];
  arr2 = new int[ARRSIZE];
  arrayCopy(arr0, arr1);
  arrayCopy(arr0, arr2);
  /*
  //only here to ensure the arrays are identical, leave commented out for large array sizes.
  printArray(arr0);
  printArray(arr1);
  printArray(arr2);
  */

  //sort functions called here.
  
  //use extra variables here to help with timing.
  bubleSort(arr0);
  selectionSort(arr1);
  insertionSort(arr2);
  int t0 = millis();
  bubleSort(arr0);
  int t1 = millis();
  selectSort(arr1);
  int t2 = millis();
  int t3 = millis();
  //set the time variables apprpirately
  bubbleTime = t1-t0;
  selectTime = t2-t1;
  insertTime = t3-t2;

  /* ===================
    At this point, all the counting variables
    should be set. The time values right above,
    and the comparison and swap values inside their
    respective sorts.
    Leave this code, and the rest of setup alone,
    it will create summary strings and print them out.
  =================== */
  String bubbleString = "Bubble Sort\n";
  bubbleString+= "\ttime: " + bubbleTime;
  bubbleString+= "\tcomps: " + bubbleCompCount;
  bubbleString+= "\tswaps: " + bubbleSwapCount;
  String selectString = "Selection Sort\n";
  selectString+= "\ttime: " + selectTime;
  selectString+= "\tcomps: " + selectCompCount;
  selectString+= "\tswaps: " + selectSwapCount;
  String insertString = "Insertion Sort\n";
  insertString+= "\ttime: " + insertTime;
  insertString+= "\tcomps: " + insertCompCount;
  insertString+= "\tswaps: " + insertSwapCount;

  println(bubbleString);
  println(selectString);
  println(insertString);
}//setup


void bubleSort(int[] ray) {
  for (int endPos = ray.length-1; endPos >= 0; endPos--) {
    for (int pos=0; pos < endPos; pos++) {
      bubbleCompCount++;
      if (ray[pos] > ray[endPos]) {
        swap(ray, pos, endPos);
        bubbleSwapCount++;
      }
    }
  }
}//bubleSort

void selectionSort(int[] ray) {

  for (int i=0; i < ray.length; i++) {
    int smallPos = i;
    for (int pos=i+1; pos < ray.length; pos++) {
      selectCompCount++;
        if (ray[smallPos] > ray[pos]) {
          smallPos = pos;
        }//update smallPos
    }//inner loop
    swap(ray, i, smallPos);
    selectSwapCount++;
  }//outer loop
}//selectionSort

void insertionSort(int[] ray) {
  for (int sortEnd = 0; sortEnd < ray.length-1; sortEnd++) {
    int insertVal = ray[sortEnd+1];
    int pos = sortEnd + 1;
    for (; pos > 0; pos--) {
      insertCompCount++;
      if (ray[pos-1] < insertVal) {
        break;
      }
      else {
        ray[pos] = ray[pos - 1];
      }//shift
    }//inner loop
    ray[pos] = insertVal;
    insertSwapCount++;
  }//outer loop
}//insertionSort

void swap(int[] arr, int i0, int i1) {
  int t = arr[i0];
  arr[i0] = arr[i1];
  arr[i1] = t;
}//swap

int[] randomArray(int num) {
  int[] values = new int[num];

  for (int i=0; i<values.length; i++) {
    values[i] = int(random(100, 400));
  }//random value loop
  return values;
}//randomArray

void printArray(int[] ray) {
  String s = "[ ";
  for (int i=0; i < ray.length; i++) {
    s+= ray[i] + " ";
  }
  s+= "]";
  println(s);
}//printArray

void displayArray(int[] arr) {
  int barWidth = width / arr.length;
  int x = 0;
  int y = 0;
  fill(255);
  noStroke();
  for (int i=0; i<arr.length; i++) {
    y = height - arr[i];
    rect(x, y, barWidth, arr[i]);
    x+= barWidth;
  }
}//displayArray
int findMode0(int[] ray) {
  int currentMode = -1;
  int currentModeFreq = -1;
  int val, valFreq;
  for (int i=0; i<ray.length; i++) {
    val = ray[i];
    valFreq = 1;
    for (int j=i+1; j < ray.length; j++) {
      if (ray[j] == val) {
        valFreq++;
      }//frequency count
    }//count individual value
    if ( valFreq > currentModeFreq ) {
      currentMode = val;
      currentModeFreq = valFreq;
    }//update mode
  }//full array frequency count
  return currentMode;
}//findMode0
