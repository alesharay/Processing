import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Minesweeper_java extends PApplet {

int WIDTH = 600, HEIGHT = 600;
int CELLSIZE = 60;
int COLS = WIDTH / CELLSIZE, ROWS = HEIGHT / CELLSIZE;
int beeCount = 0, nonBeeCount = 0, countRevealed = 0;
boolean bGameOver = false, lost = false;

Cell[][] grid = new Cell[COLS][ROWS];

public void setup() {
  
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
}

public void gameOver() {
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


public void mousePressed() {
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

public void draw() {  
  background(255);
  
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
      println("YOU LOSE!");
    } else {
      text("YOU WIN!", 110, 300);
      println("YOU WIN!");
    }
  }
}
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
    bee = random(1) < 0.2f;
  }
  
  public void show() {
    stroke(0);
    noFill();
    
    rect(this.x, this.y, this.w, this.w);
    
    if (revealed)
      if (bee) {
        fill(127);
        ellipse(this.x + this.w * 0.5f, this.y + this.w * 0.5f, this.w * 0.5f, this.w * 0.5f);
    } else {
      fill(160);
      rect(this.x, this.y, this.w, this.w);
      
      if (neighborCount != 0) {
        fill(0);
        textSize(30);
        text(this.neighborCount, this.x - 6 + this.w * 0.5f, this.y + this.w - 18);
      }
    }
  }
  
  public boolean contains(int x, int y) {
    return  x > this.x && x < this.x + this.w && y > this.y && y < this.y + this.w;
  }
  
  public void reveal() { 
    if (!bGameOver)
      countRevealed++;
    revealed = true; 
    
    if (this.neighborCount == 0) {
      this.floodFill();
    }
  }
  
  public void floodFill() {
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
  
  public void countNeighbors() {
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
  public void settings() {  size(601, 661); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Minesweeper_java" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
