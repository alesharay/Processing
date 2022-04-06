int WIDTH = 600, HEIGHT = 600;
int CELLSIZE = 60;
int COLS = WIDTH / CELLSIZE, ROWS = HEIGHT / CELLSIZE;
int beeCount = 0, nonBeeCount = 0, countRevealed = 0;
boolean bGameOver = false, lost = false;

Cell[][] grid = new Cell[COLS][ROWS];

void setup() {
  size(601, 661);
  for (int i = 0; i < COLS; i++) {
    for (int j = 0; j < ROWS; j++) {
      grid[i][j] = new Cell(i, j, CELLSIZE);
    } 
  }
  for (int i = 0; i < COLS; i++) {
    for (int j = 0; j < ROWS; j++) {
      grid[i][j].countNeighbors();
      if (grid[i][j].bee) { 
        beeCount++;
      }
    } 
  }
  
  nonBeeCount = COLS * ROWS - beeCount;
}

void gameOver() {
  bGameOver = true;
  for (Cell[] cells : grid) {
    for (Cell cell : cells) {
      if (countRevealed != nonBeeCount)
        lost = true;
      
      if (cell.bee && lost) {
        cell.reveal();
      } 
    }
  }
}


void mousePressed() {
  if (!bGameOver) {
    for (int i = 0; i < COLS; i++) {
      for (int j = 0; j < ROWS; j++) {
        Cell cell = grid[i][j];
        if (cell.contains(mouseX, mouseY)) {
          cell.reveal();
          
          if (grid[i][j].bee || countRevealed == nonBeeCount) {
            gameOver();
          }
        }
      } 
    }
  }
}

void draw() {  
  background(255);
  
  for (int i = 0; i < COLS; i++) {
    for (int j = 0; j < ROWS; j++) {
      Cell cell = grid[i][j];
      cell.show();
    } 
  }
  
  println("countRevealed: " + countRevealed);
  println("nonBeeCount: " + nonBeeCount);
  
  textSize(75);
  fill(0);
  if (bGameOver) {
    if (lost) {
      text("YOU LOSE!", 110, 300);
      println("YOU LOSE!");
    } else {
      text("YOU WIN!", 110, 300);
      println("YOU WIN!");
    }
  }
}
