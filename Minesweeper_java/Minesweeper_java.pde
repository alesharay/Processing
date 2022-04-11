import controlP5.*;

public void settings() {
  reset();
  size(Globals.WIDTH, Globals.HEIGHT + Globals.CELLSIZE);
}

void setup() {
  imageMode(CENTER);
  textAlign(CENTER);
  
  Globals.flagIcon = loadImage("icons/flag (1).png");
  Globals.mine = loadImage("icons/mine.png");
  Globals.happyFace = loadImage("icons/happy.png");
  Globals.sadFace = loadImage("icons/sad.png");
}

void draw() {  
  background(225);
  // frameRate(1);
  Globals.beginner.show();
  Globals.intermediate.show();
  Globals.expert.show();
  Globals.flag.show();
  Globals.score.show();
  Globals.mineCountButton.show();
  Globals.reset.show();

  for (int i = 0; i < Globals.COLS; i++) {
    for (int j = 0; j < Globals.ROWS; j++) {
      Globals.grid[i][j].show();
    } 
  }

  println("countRevealed: " + Globals.countRevealed);
  println("nonBeeCount: " + Globals.nonBeeCount);
  
  gameOverText();
}

void reset() {
  // boolean difficultySelected = (Globals.beginner != null && Globals.beginner.clicked) || (Globals.intermediate != null && Globals.intermediate.clicked) || (Globals.expert != null && Globals.expert.clicked);
  // println("difficulty: " + (!difficultySelected ? "not selected" : Globals.beginner.clicked ? Globals.beginner.name : Globals.intermediate.clicked ? Globals.intermediate.name : Globals.expert.name));

  // println("Globals.expert != null && Globals.expert.clicked: " + (Globals.expert != null && Globals.expert.clicked));
  // println("Globals.intermediate != null && Globals.intermediate.clicked: " + (Globals.intermediate != null && Globals.intermediate.clicked));
  // println("Globals.beginner != null && Globals.beginner.clicked: " + (Globals.beginner != null && Globals.beginner.clicked));

  if(Globals.expert != null && Globals.expert.clicked) {
    setDifficulty("expert"); 
  } else if(Globals.intermediate != null && Globals.intermediate.clicked) {
    setDifficulty("intermediate");
  } else if ((Globals.beginner != null && Globals.beginner.clicked) || 
            (Globals.expert == null && Globals.intermediate == null && Globals.beginner == null)) {
    setDifficulty("beginner");
  }

  Globals.COLS = Globals.WIDTH / Globals.CELLSIZE; 
  Globals.ROWS = Globals.HEIGHT / Globals.CELLSIZE;
  Globals.grid = new Cell[Globals.COLS][Globals.ROWS];

  for (int i = 0; i < Globals.COLS; i++) {
    for (int j = 0; j < Globals.ROWS; j++) {
      Globals.grid[i][j] = new Cell(i, j, Globals.CELLSIZE);
    } 
  }

  Globals.beeCount = Globals.nonBeeCount = Globals.countRevealed = 0;
  Globals.bGameOver = Globals.lost = false;

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
  // Globals.POSY = Globals.HEIGHT / Globals.CELLSIZE;
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
  
  Globals.beginner = new Button("beginner", false, 
                                Globals.WIDTH / 2 + Globals.CELLSIZE,
                                Globals.MARGIN_DOWN,
                                Globals.PADDING_DOWN,
                                Globals.MARGIN_DOWN + Globals.PADDING_DOWN);


  Globals.intermediate = new Button("intermediate", false,
                                    Globals.WIDTH / 2 + Globals.CELLSIZE + (Globals.PADDING_DOWN),
                                    Globals.MARGIN_DOWN, 
                                    Globals.PADDING_DOWN,
                                    Globals.MARGIN_DOWN + Globals.PADDING_DOWN);

  Globals.expert = new Button("expert", false,
                              Globals.WIDTH / 2 + Globals.CELLSIZE + (Globals.PADDING_DOWN * 2),
                              Globals.MARGIN_DOWN,
                              Globals.PADDING_DOWN,
                              Globals.MARGIN_DOWN + Globals.PADDING_DOWN);
  
  Globals.score = new Button("score", false,
                            Globals.WIDTH - (Globals.PADDING_UP - Globals.MARGIN_DOWN * 2),
                            Globals.MARGIN_DOWN,
                            Globals.CELLSIZE + (Globals.MARGIN_DOWN * 2),
                            (Globals.CELLSIZE / 4 ) + (Globals.CELLSIZE / 2));
}

void setDifficulty(String name) {
  switch(name) {
    case "intermediate":
      Globals.WIDTH = 800; Globals.HEIGHT = 800; Globals.CELLSIZE = 50;
      break;
    case "expert":
      Globals.WIDTH = 1500; Globals.HEIGHT = 800; Globals.CELLSIZE = 50;
      break;
    case "beginner":
    default:
      Globals.WIDTH = 450; Globals.HEIGHT = 450; Globals.CELLSIZE = 50;
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

void mousePressed() {
  if (Globals.beginner.contains(mouseX, mouseY)) {
    if(!Globals.beginner.clicked) {
      Globals.beginner.clicked = true;
      Globals.intermediate.clicked = false;
      Globals.expert.clicked = false;
      reset();
    }
  }

  if (Globals.intermediate.contains(mouseX, mouseY)) {
    if(!Globals.intermediate.clicked) {
      Globals.beginner.clicked = false;
      Globals.intermediate.clicked = true;
      Globals.expert.clicked = false;
      reset();
    }
  }

  if (Globals.expert.contains(mouseX, mouseY)) {
    if(!Globals.expert.clicked) {
      Globals.beginner.clicked = false;
      Globals.intermediate.clicked = false;
      Globals.expert.clicked = true;
      reset();
    }
  }

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
      text("YOU LOSE!", Globals.WIDTH / 2, Globals.HEIGHT / 2);
      println("YOULOSE!");
    } else{
      text("YOU WIN!", Globals.WIDTH / 2, Globals.HEIGHT / 2);
      println("YOU WIN!");
    }
  }
}