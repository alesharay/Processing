class Button {
  String name;
  boolean clicked;
  int x, y, w, h;
  
  Button(String name, boolean clicked, int x, int y, int w, int h) {
    this.name = name;
    this.clicked = clicked;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  boolean contains(int x, int y) {
    return  x > this.x && x < this.x + this.w && y > this.y && y < this.y + this.w;
  }
  
  void showFlag() {
    stroke(0);
    
    if (clicked) {
      fill(130);      
    } else {
      noFill();
    }
    rect(x, y, w, h);
    
    mouseOver();
    image(Globals.flagIcon, x + w / 2, y + h / 2, w, h);    
  }
  
  void showMineCount() {
    stroke(0);
    fill(200);      
    rect(x, y, w, h);
    
    fill(#FF0033);
    textSize(Globals.PADDING_DOWN);
    text(Globals.beeCount, x + w / 2, y + w / 2 + Globals.MARGIN_DOWN);
  }
  
  void showGameTimer() {
    stroke(0);
    fill(200);
    rect(x, y, w, h); 

    if(Globals.gameStarted && !Globals.bGameOver) {
      if(frameCount % 60 == 0) { 
        Globals.gameTimer++;
      }    
    }

    fill(#FF0033);
    textSize(Globals.PADDING_DOWN);
    text(Globals.gameTimer, x + w / 2, y + h / 2 + Globals.MARGIN_DOWN);
  }
  
  void showReset() {
    stroke(0);
    noFill();
    rect(x, y, w, h);
    
    mouseOver();
    if (Globals.lost) {
      image(Globals.sadFace, x + w / 2, y + h / 2, w, h);  
    } else {
      image(Globals.happyFace, x + 1.5 + w / 2, y + h / 2, w, h);  
    }
  }
  
  void showDifficulty() {
    String label = (name == "beginner" ? "B" : name == "intermediate" ? "I" : "E");

    stroke(0);
    
    if (clicked) {
      fill(130);   
    } else {
      noFill();
    }
    rect(x, y, w, h);
    
    mouseOver();

    fill(#FF0033);
    textSize(w / 2);
    text(label, x + w / 2, y + w / 2 + Globals.MARGIN_DOWN);
  }
  
  void mouseOver() {
    if (contains(mouseX, mouseY)) {
      fill(100);      
      rect(x, y, w, h);
    }
  }

  void show() {
    switch(name) {
      case "flag":
        showFlag();
        break;
      case "timer":
        showGameTimer();
        break;
      case "beginner":
      case "intermediate":
      case "expert":
        showDifficulty();
        break;
      case "reset":
        showReset();
        break;
      case "mineCountButton":
        showMineCount();
        break;
    } 
  }
}