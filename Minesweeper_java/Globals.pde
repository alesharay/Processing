
static class Globals {
  
  static int WIDTH; 
  static int HEIGHT;
  static int CELLSIZE;
  static int POSX;
  static int POSY;
  static int PADDING_DOWN;
  static int PADDING_UP;
  static int MARGIN_DOWN;
  static int MARGIN_UP;
  static int COLS;
  static int ROWS;
  static int beeCount; 
  static int nonBeeCount;
  static int countRevealed;

  static Cell[][] grid;
  
  static boolean bGameOver;
  static boolean lost;
  
  static Button flag;
  static Button score;
  static Button reset;
  static Button mineCountButton;
  static Button beginner;
  static Button intermediate;
  static Button expert;
  
  static PImage flagIcon;
  static PImage mine;
  static PImage happyFace;
  static PImage sadFace;
}