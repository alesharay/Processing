class Button {
  String name;
  
  boolean clicked;
  
  int x;
  int y;
  int w;
  int h;
  
  PImage flag;
  
  Button(String name, boolean clicked,
    int x, int y, int w, int h) {
    
    this.name = name;
    this.clicked = clicked;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  Button(String name, boolean clicked,
    int x, int y, int w, int h, 
    PImage flag) {
    
    this(name, clicked, x, y, w, h);
    this.flag = flag;
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
    
    image(flag, x + w / 2, y + h / 2, w, h);    
  }
  
  void showScore() {
    stroke(0);
    fill(200);
    rect(x, y, w, h);
  }
  
  void showTimer() {
    
  }
  
  
  void reset() {
    
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
        reset();
        break;
    } 
    
  }
}