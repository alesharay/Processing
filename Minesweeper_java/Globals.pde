
static class Globals {
  static int WIDTH = 500, HEIGHT = 500;
  static int CELLSIZE = 50;
  static int PADDING_DOWN = CELLSIZE / 2;
  static int PADDING_UP = CELLSIZE * 2;
  static int MARGIN_DOWN = WIDTH / CELLSIZE;
  static int MARGIN_UP = CELLSIZE + (MARGIN_DOWN * 2);
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