void setup() {
  size(601, 661);
  
  imageMode(CENTER);
  Globals.flagIcon = loadImage("icons/flag (1).png");
  Globals.mine = loadImage("icons/mine.png");
  Globals.happyFace = loadImage("icons/happy.png");
  Globals.sadFace = loadImage("icons/sad.png");
  
  for (int i = 0; i < Globals.COLS; i++) {
    for (int j = 0; j < Globals.ROWS; j++) {
      Globals.grid[i][j] = new Cell(i, j, Globals.CELLSIZE);
    } 
  }
  
  for (int i = 0; i < Globals.COLS; i++) {
    for (int j = 0; j < Globals.ROWS; j++) {
      Globals.grid[i][j].countNeighbors();
      if (Globals.grid[i][j].bee) { 
        Globals.beeCount++;
      }
    } 
  }
  
  Globals.nonBeeCount = Globals.COLS * Globals.ROWS - Globals.beeCount;
  
  Globals.flag = new Button("flag", false, 40, 10, 40, 40);
  Globals.score = new Button("score", false, Globals.WIDTH - 120, 10, 80, 40);
  Globals.reset = new Button("reset", false, Globals.WIDTH / 2 - 20, 10, 40, 40);
}

void gameOver() {
  Globals.bGameOver = true;
  for (Cell[] cells : Globals.grid) {
    for (Cell cell : cells) {
      if (Globals.countRevealed != Globals.nonBeeCount)
        Globals.lost = true;
      
      if (cell.bee && Globals.lost) {
        cell.reveal();
      } 
    }
  }
}

void reset() {
  Globals.beeCount = Globals.nonBeeCount = Globals.countRevealed = 0;
  Globals.bGameOver = false;
  Globals.lost = false;
  for (int i = 0; i < Globals.COLS; i++) {
    for (int j = 0; j < Globals.ROWS; j++) {
      Globals.grid[i][j].reset();
    }
  }
  
  for (int i = 0; i < Globals.COLS; i++) {
    for (int j = 0; j < Globals.ROWS; j++) {
      Globals.grid[i][j].countNeighbors();
      if (Globals.grid[i][j].bee) { 
        Globals.beeCount++;
      }
    }
  }
  
  Globals.nonBeeCount = Globals.COLS * Globals.ROWS - Globals.beeCount;
}


void mousePressed() {
  if (Globals.reset.contains(mouseX, mouseY)) {
    reset();
  }
  
  if (Globals.flag.contains(mouseX, mouseY)) {
    Globals.flag.clicked = !Globals.flag.clicked;
  }
  
  if (Globals.flag.clicked) {
    for (int i = 0; i < Globals.COLS; i++) {
      for (int j = 0; j < Globals.ROWS; j++) {
        Cell cell = Globals.grid[i][j];
        if (cell.contains(mouseX, mouseY)) {
          cell.flagged = !cell.flagged;
        }
      }
    }
  } else {
    if (!Globals.bGameOver) {
      for (int i = 0; i < Globals.COLS; i++) {
        for (int j = 0; j < Globals.ROWS; j++) {
          Cell cell = Globals.grid[i][j];
          if (cell.contains(mouseX, mouseY)) {
            if (!Globals.flag.clicked && !cell.flagged) {
              cell.reveal();
              
              if (Globals.grid[i][j].bee || Globals.countRevealed == Globals.nonBeeCount) {
                gameOver();
              }
            }
          }
        } 
      }
    }
  }
}

void gameOverText() {
  fill(0);
  textSize(75);
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

void draw() {  
  background(225);
  Globals.flag.show();
  Globals.score.show();
  Globals.reset.show();
  
  for (int i = 0; i < Globals.COLS; i++) {
    for (int j = 0; j < Globals.ROWS; j++) {
      Cell cell = Globals.grid[i][j];
      cell.show();
    } 
  }
  
  println("countRevealed: " + Globals.countRevealed);
  println("nonBeeCount: " + Globals.nonBeeCount);
  
  gameOverText();
}