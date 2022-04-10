int WIDTH = 600, HEIGHT = 600;
int CELLSIZE = 60;
int COLS = WIDTH / CELLSIZE, ROWS = HEIGHT / CELLSIZE;
int beeCount = 0, nonBeeCount = 0, countRevealed = 0;
boolean bGameOver = false, lost = false;

Cell[][] grid = new Cell[COLS][ROWS];

Button flag;
Button score;
PImage flagIcon;
PImage mine;

void setup() {
  size(601, 661);
  
  imageMode(CENTER);
  flagIcon = loadImage("icons/flag (1).png");
  mine = loadImage("icons/mine.png");
  
  for (int i = 0; i < COLS; i++) {
    for (int j = 0; j < ROWS; j++) {
      grid[i][j] = new Cell(i, j, CELLSIZE, mine, flagIcon);
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
  flag = new Button("flag", false, 30, 10, 50, 30, flagIcon);
  score = new Button("score", false, WIDTH - 110, 10, 80, 30);
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
  if (flag.contains(mouseX, mouseY)) {
    flag.clicked = !flag.clicked;
  }
  
  if (flag.clicked) {
    for (int i = 0; i < COLS; i++) {
      for (int j = 0; j < ROWS; j++) {
        Cell cell = grid[i][j];
        if (cell.contains(mouseX, mouseY)) {
          cell.flagged = !cell.flagged;
        }
      }
    }
  } else {
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
}

void draw() {  
  background(225);
  flag.show();
  score.show();
  
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
      println("YOULOSE!");
    } else{
      text("YOU WIN!", 110, 300);
      println("YOU WIN!");
    }
  }
}