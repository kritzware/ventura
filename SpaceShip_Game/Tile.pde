class Tile {
  
  float x, y;
  float dx, dy;
  color c;
  
  Tile(float _x, float _y, float _dx, float _dy, color _c) {
    
    x = _x;
    y = _y;
    dx = _dx;
    dy = _dy;
    c = _c;
    
  }
  
  void draw() {
    rectMode(CENTER);
    fill(c);
    rect(x, y, dx, dy, 3);
    if(mouseX >= x - dx && mouseX <= x + dx && mouseY >= y - dy && mouseY <= y + dy) {
      cursor(CROSS);
    }
  }
}