class Cell {
  
  int i, j, x, y, w, neighborCount;
  boolean revealed, bee;
  
  Cell(int i, int j, int w) {
    this.i = i;
    this.j = j;
    this.x = i * w;
    this.y = j * w + w;
    this.w = w;
    neighborCount = 0;
    revealed = false;
    bee = random(1) < 0.2;
  }
  
  void show() {
    stroke(0);
    noFill();
    
    rect(this.x, this.y, this.w, this.w);
    
    if (revealed)
      if (bee) {
        fill(127);
        ellipse(this.x + this.w * 0.5, this.y + this.w * 0.5, this.w * 0.5, this.w * 0.5);
    } else {
      fill(160);
      rect(this.x, this.y, this.w, this.w);
      
      if (neighborCount != 0) {
        fill(0);
        textSize(30);
        text(this.neighborCount, this.x - 6 + this.w * 0.5, this.y + this.w - 18);
      }
    }
  }
  
  boolean contains(int x, int y) {
    return  x > this.x && x < this.x + this.w && y > this.y && y < this.y + this.w;
  }
  
  void reveal() { 
    if (!bGameOver)
      countRevealed++;
    revealed = true; 
    
    if (this.neighborCount == 0) {
      this.floodFill();
    }
  }
  
  void floodFill() {
    for (int xOff = -1; xOff <= 1; xOff++) {
      for (int yOff = -1; yOff <= 1; yOff++) {
        if (this.i + xOff > - 1 && this.j + yOff > - 1 && this.i + xOff < 10 && this.j + yOff < 10) {
          Cell neighbor = grid[this.i + xOff][this.j + yOff];
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
          Cell neighbor = grid[this.i + xOff][this.j + yOff];
          if (neighbor.bee) {
            neighborCount++;
          }
        }
      } 
    }
  }
}
