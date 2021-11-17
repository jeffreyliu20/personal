int SPACE = 0;
int WALL = 1;
int START = 2;
int FINISH = 3;

Maze m;

void setup() {
  size(400, 400);
  m = new Maze("maze_simple.txt");
  m.display();
}
