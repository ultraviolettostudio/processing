void setupPrevizLines(){
 pLines = new PrevizLine[nChan];
  for (int i = 0; i < nChan; i++) {
    PrevizLine  l = new PrevizLine(
      new PVector((i*50) + 30, height * 0.8),
      0,
      1,
      i+1
      );
    pLines[i] = l;
  }
}

class PrevizLine {

  PVector pos;
  float min, max;
  float currValue;
  float offSet;
  int ch;
  float minVal = 0, maxVal = 0;
  int bang =0;

  PrevizLine(PVector _pos, float _min, float _max, int _ch) {
    pos = new PVector(_pos.x, _pos.y);
    min = _min;
    max= _max;
    ch = _ch;
  }
  void update(float _currValue) {
    currValue = _currValue;
    minVal = min (currValue, minVal);
    maxVal = max (currValue, maxVal);
    offSet = map(currValue, min, max, 0, height * 0.5);
  }
  void updateI(int _currValue) {
    bang = _currValue;
  }
  void show() {
    noStroke();
    fill(255);
    rect(pos.x, pos.y, 30, -offSet);
    push();
    translate(pos.x, pos.y -120);
    rotate(HALF_PI);
    fill(255, 0, 0);
    text("val "+currValue, 0, 0);
    pop();
    text("ch "+ch, pos.x, pos.y +30);
    text("min "+minVal, pos.x, pos.y +40);
    text("max "+maxVal, pos.x, pos.y -height * 0.5 + (ch%2)*15);
    fill(bang* 255 );
    rect(pos.x, pos.y +45, 5, 5);
    fill(255 );
    text("bang "+bang, pos.x+8, pos.y +50);
  }
}
