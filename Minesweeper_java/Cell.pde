class Cell {
  
  int i, j, x, y, w, neighborCount;
  boolean revealed, bee, flagged;
  
  Cell(int i, int j, int w) {
    this.i = i;
    this.j = j;
    this.x = i * w;
    this.y = j * w + w;
    this.w = w;
    neighborCount = 0;
    revealed = false;
    flagged = false;
    bee = random(1) < 0.2;
  }
  
  void show() {
    stroke(0);
    noFill();
    
    rect(this.x, this.y, this.w, this.w);
    
    if (flagged) {
      addFlag();
    } else if (revealed)
      if (bee) {
        image(Globals.mine, x + w / 2, y + w / 2, w - (w / 2), w - (w / 2));
      } else {
      fill(160);
      rect(this.x, this.y, this.w, this.w);
      
      if (neighborCount != 0) {
        fill(0);
        
        switch(neighborCount) {
          case 1:
            //blue
            fill(#0000FF);
            break;
          case 2:
            //green
            fill(#00FF00);
            break;
          case 3:
            //red
            fill(#FF0000);
            break;
          case 4:
            //purple
            fill(#800080);
            break;
          case 5:
            //maroon
            fill(#800000);
            break;
          case 6:
            //turquoise
            fill(#40E0D0);
            break;
          case 7:
            //black
            fill(0);
            break;
          case 8:
            //gray
            fill(127);
            break;
          
        }
        
        textSize(30);
        text(this.neighborCount, this.x - 6 + this.w * 0.5, this.y + this.w - 18);
      }
    }
  }
  
  void addFlag() {
    image(Globals.flagIcon, x + w / 2, y + w / 2, w - w / 2, w - w / 2);    
  }
  
  boolean contains(int x, int y) {
    return  x > this.x && x < this.x + this.w && y > this.y && y < this.y + this.w;
  }
  
  void reveal() { 
    if (!Globals.bGameOver)
      Globals.countRevealed++;
    revealed = true; 
    
    if (this.neighborCount == 0) {
      this.floodFill();
    }
  }
  
  void floodFill() {
    for (int xOff = -1; xOff <= 1; xOff++) {
      for (int yOff = -1; yOff <= 1; yOff++) {
        if (this.i + xOff > - 1 && this.j + yOff > - 1 && this.i + xOff < 10 && this.j + yOff < 10) {
          Cell neighbor = Globals.grid[this.i + xOff][this.j + yOff];
          if (!neighbor.bee && !neighbor.revealed) {
            neighbor.reveal();
          }
        }
      } 
    }
  }
  
  void countNeighbors() {
    if (bee) {
      this.neighborCount = -1;
      return;
    }
    
    for (int xOff = -1; xOff <= 1; xOff++) {
      for (int yOff = -1; yOff <= 1; yOff++) {
        if (this.i + xOff > - 1 && this.j + yOff > - 1 && this.i + xOff < 10 && this.j + yOff < 10) {
          Cell neighbor = Globals.grid[this.i + xOff][this.j + yOff];
          if (neighbor.bee) {
            neighborCount++;
          }
        }
      } 
    }
  }
  
  void reset() {
    neighborCount = 0;
    revealed = false;
    flagged = false;
    bee = random(1) < 0.2;
    
    stroke(0);
    noFill();
    rect(this.x, this.y, this.w, this.w);
  }
}
