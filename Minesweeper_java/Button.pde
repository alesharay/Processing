class Button {
  String name;
  
  boolean clicked;
  
  int x;
  int y;
  int w;
  int h;
  
  Button(String name, boolean clicked,
    int x, int y, int w, int h) {
    
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
  
  void showScore() {
    stroke(0);
    fill(200);
    rect(x, y, w, h);
  }
  
  void showTimer() {
    
  }
  
  void mouseOver() {
    if (contains(mouseX, mouseY)) {
      fill(100);      
      rect(x, y, w, h);
    }
  }
  
  void showReset() {
    stroke(0);
    noFill();
    rect(x, y, w, h);
    
    mouseOver();
    image(Globals.happyFace, x + w / 2, y + h / 2, w, h);  
  }
  
  void showDifficulty() {
    
  }
  
  void show() {
    
    switch(name) {
      case "flag":
        showFlag();
        break;
      case "score":
        showScore();
        break;
      case "timer":
        showTimer();
        break;
      case "difficulty":
        showDifficulty();
        break;
      case "reset":
        showReset();
        break;
    } 
  }
}