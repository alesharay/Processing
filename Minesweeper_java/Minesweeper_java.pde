import controlP5.*;

void setup() {
  surface.setResizable(true);
  reset();

  imageMode(CENTER);
  textAlign(CENTER);
  
  Globals.flagIcon = loadImage("icons/flag (1).png");
  Globals.mine = loadImage("icons/mine.png");
  Globals.happyFace = loadImage("icons/happy.png");
  Globals.sadFace = loadImage("icons/sad.png");
}

void draw() {  
  background(225);

  Globals.beginner.show();
  Globals.intermediate.show();
  Globals.expert.show();
  Globals.flag.show();
  Globals.timer.show();
  Globals.mineCountButton.show();
  Globals.reset.show();

  for (int i = 0; i < Globals.COLS; i++) {
    for (int j = 0; j < Globals.ROWS; j++) {
      Globals.grid[i][j].show();
    } 
  }
  
  gameOverText();
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

  if (Globals.expert.contains(mouseX, mouseY)) {
    if(!Globals.expert.clicked) {
      setDifficultyClick(false, false, true);
    }
  }

  if (Globals.beginner.contains(mouseX, mouseY)) {
    if(!Globals.beginner.clicked) {
      setDifficultyClick(true, false, false);
    }
  }

  if (Globals.intermediate.contains(mouseX, mouseY)) {
    if(!Globals.intermediate.clicked) {
      setDifficultyClick(false, true, false);
    }
  }
}

void setDifficultyClick(boolean b, boolean i, boolean e) {
      Globals.beginner.clicked = b;
      Globals.intermediate.clicked = i;
      Globals.expert.clicked = e;
      reset();
}

void setDifficulty(String name) {
  switch(name) {
    case "beginner":
      Globals.WIDTH = 450; Globals.HEIGHT = 450; Globals.CELLSIZE = 50;
      break;
    case "intermediate":
      Globals.WIDTH = 550; Globals.HEIGHT = 550; Globals.CELLSIZE = 50;
      break;
    case "expert":
      Globals.WIDTH = 650; Globals.HEIGHT = 650; Globals.CELLSIZE = 50;
      break;
  }
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

void gameOverText() {
  fill(0);
  textSize(75);
  if (Globals.bGameOver) {
    if (Globals.lost) {
      text("YOU LOSE!", Globals.WIDTH / 2, Globals.HEIGHT / 2);
    } else{
      text("YOU WIN!", Globals.WIDTH / 2, Globals.HEIGHT / 2);
    }
  }
}

void reset() {

  if ((Globals.expert == null && Globals.intermediate == null && Globals.beginner == null) ||
      (Globals.beginner != null && Globals.beginner.clicked)) {
    setDifficulty("beginner");
  } else if(Globals.intermediate != null && Globals.intermediate.clicked) {
    setDifficulty("intermediate");
  } else if(Globals.expert != null && Globals.expert.clicked) {
    setDifficulty("expert"); 
  }

  surface.setSize(Globals.WIDTH, (Globals.HEIGHT + Globals.CELLSIZE));

  Globals.COLS = Globals.WIDTH / Globals.CELLSIZE; 
  Globals.ROWS = Globals.HEIGHT / Globals.CELLSIZE;
  Globals.grid = new Cell[Globals.COLS][Globals.ROWS];

  for (int i = 0; i < Globals.COLS; i++) {
    for (int j = 0; j < Globals.ROWS; j++) {
      Globals.grid[i][j] = new Cell(i, j, Globals.CELLSIZE);
    } 
  }

  Globals.beeCount = Globals.nonBeeCount = Globals.countRevealed = Globals.gameTimer = 0;
  Globals.bGameOver = Globals.lost = Globals.gameStarted = false;

  for (int i = 0; i < Globals.COLS; i++) {
    for (int j = 0; j < Globals.ROWS; j++) {
      Globals.grid[i][j].countNeighbors();
      if (Globals.grid[i][j].bee) { 
        Globals.beeCount++;
      }
    }
  }

  Globals.nonBeeCount = Globals.COLS * Globals.ROWS - Globals.beeCount;

  Globals.POSX = Globals.WIDTH / Globals.CELLSIZE;
  Globals.PADDING_DOWN = Globals.CELLSIZE / 2;
  Globals.PADDING_UP = Globals.CELLSIZE * 2;
  Globals.MARGIN_DOWN = Globals.CELLSIZE / 5;
  Globals.MARGIN_UP = Globals.CELLSIZE + (Globals.MARGIN_DOWN * 2);

  Globals.flag = new Button("flag", false,
                            Globals.POSX,
                            Globals.MARGIN_DOWN,
                            Globals.MARGIN_DOWN + Globals.PADDING_DOWN,
                            Globals.MARGIN_DOWN + Globals.PADDING_DOWN);

  Globals.mineCountButton = new Button("mineCountButton", false, 
                                      Globals.POSX + Globals.MARGIN_UP,
                                      Globals.MARGIN_DOWN,
                                      Globals.MARGIN_DOWN + Globals.PADDING_DOWN,
                                      Globals.MARGIN_DOWN + Globals.PADDING_DOWN);

  Globals.reset = new Button("reset", false, 
                            Globals.WIDTH / 2 - (Globals.MARGIN_DOWN * 2),
                            Globals.MARGIN_DOWN,
                            Globals.MARGIN_DOWN + Globals.PADDING_DOWN,
                            Globals.MARGIN_DOWN + Globals.PADDING_DOWN);

  boolean expertClicked = Globals.expert != null ? Globals.expert.clicked : false;
  Globals.expert = new Button("expert", expertClicked,
                              (Globals.WIDTH / 2) + Globals.CELLSIZE + (Globals.PADDING_DOWN * 2),
                              Globals.MARGIN_DOWN,
                              Globals.PADDING_DOWN,
                              Globals.MARGIN_DOWN + Globals.PADDING_DOWN);

  boolean beginnerClicked = Globals.beginner != null ? Globals.beginner.clicked : false;
  Globals.beginner = new Button("beginner", beginnerClicked, 
                                (Globals.WIDTH / 2) + Globals.CELLSIZE,
                                Globals.MARGIN_DOWN,
                                Globals.PADDING_DOWN,
                                Globals.MARGIN_DOWN + Globals.PADDING_DOWN);

  boolean intermediateClicked = Globals.intermediate != null ? Globals.intermediate.clicked : false;
  Globals.intermediate = new Button("intermediate", intermediateClicked,
                                    (Globals.WIDTH / 2) + Globals.CELLSIZE + Globals.PADDING_DOWN,
                                    Globals.MARGIN_DOWN, 
                                    Globals.PADDING_DOWN,
                                    Globals.MARGIN_DOWN + Globals.PADDING_DOWN);

  Globals.timer = new Button("timer", false,
                            Globals.WIDTH - (Globals.PADDING_UP - Globals.MARGIN_DOWN * 2),
                            Globals.MARGIN_DOWN,
                            Globals.CELLSIZE + (Globals.MARGIN_DOWN * 2),
                            Globals.MARGIN_DOWN + Globals.PADDING_DOWN);
}