int WIDTH = 600, HEIGHT = 600;
int CELLSIZE = 60;
int COLS = WIDTH / CELLSIZE, ROWS = HEIGHT / CELLSIZE;
int beeCount = 0, nonBeeCount = 0, countRevealed = 0;

Cell[][] grid = new Cell[COLS][ROWS];

void setup() {
  size(601, 661);
  
  imageMode(CENTER);
  Globals.flagIcon = loadImage("icons/flag (1).png");
  Globals.mine = loadImage("icons/mine.png");
  Globals.happyFace = loadImage("icons/happy.png");
  Globals.sadFace = loadImage("icons/sad.png");
  
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
  
  Globals.flag = new Button("flag", false, 40, 10, 40, 40);
  Globals.score = new Button("score", false, WIDTH - 120, 10, 80, 40);
  Globals.reset = new Button("reset", false, WIDTH / 2 - 20, 10, 40, 40);
}

void gameOver() {
  Globals.bGameOver = true;
  for (Cell[] cells : grid) {
    for (Cell cell : cells) {
      if (countRevealed != nonBeeCount)
        Globals.lost = true;
      
      if (cell.bee && Globals.lost) {
        cell.reveal();
      } 
    }
  }
}


void mousePressed() {
  if (Globals.flag.contains(mouseX, mouseY)) {
    Globals.flag.clicked = !Globals.flag.clicked;
  }
  
  if (Globals.flag.clicked) {
    for (int i = 0; i < COLS; i++) {
      for (int j = 0; j < ROWS; j++) {
        Cell cell = grid[i][j];
        if (cell.contains(mouseX, mouseY)) {
          cell.flagged = !cell.flagged;
        }
      }
    }
  } else {
    if (!Globals.bGameOver) {
      for (int i = 0; i < COLS; i++) {
        for (int j = 0; j < ROWS; j++) {
          Cell cell = grid[i][j];
          if (cell.contains(mouseX, mouseY)) {
            if (!Globals.flag.clicked && !cell.flagged) {
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
}

void draw() {  
  background(225);
  Globals.flag.show();
  Globals.score.show();
  Globals.reset.show();
  
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
  if (Globals.bGameOver) {
    if (Globals.lost) {
      text("YOU LOSE!", 110, 300);
      println("YOULOSE!");
    } else{
      text("YOU WIN!", 110, 300);
      println("YOU WIN!");
    }
  }
}