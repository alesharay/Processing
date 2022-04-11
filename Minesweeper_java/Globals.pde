
static class Globals {
  static int WIDTH = 600, HEIGHT = 600;
  static int CELLSIZE = 60;
  static int COLS = WIDTH / CELLSIZE, ROWS = HEIGHT / CELLSIZE;
  static int beeCount = 0, nonBeeCount = 0, countRevealed = 0;
  static Cell[][] grid = new Cell[COLS][ROWS];
  
  static boolean bGameOver = false, lost = false;
  
  static Button flag;
  static Button score;
  static Button reset;
  static Button mineCountButton;
  
  static PImage flagIcon;
  static PImage mine;
  static PImage happyFace;
  static PImage sadFace;
  
  static ControlP5 cp5;
  
  static DropdownList droplist;
}