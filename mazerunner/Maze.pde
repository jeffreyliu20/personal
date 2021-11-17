class Maze {

  int rows;
  int cols;
  int grid[][];

  Maze(String file) {
    String[] lines = loadStrings(file);
    rows = lines[0].length();
    cols = lines.length;
        

  }//constructor

  void display() {
 grid = new int [rows][cols];
    for (int r=0;r<rows;r++) {
      for (int c=0;c<cols;c++) {
        
        
  }//display
}
