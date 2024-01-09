class Modul {

  PVector pos;  /// the position of the modul
  PVector pivot; //// rotation pivot
  float sizeW; /// width
  float sizeH; /// height
  
  float SizeInnerRect;

  float currAngleRot = 0;  //// actual rotation angle
  float oldAngleRot = currAngleRot;  /// rotation stack

  float amtAngleRot = PI;  //// amount of the nexrt rotation
  
  int NUM_PIV = 5; /// num of pivot points
  PVector[] pivots = new PVector[NUM_PIV];

  Timer timer; //// timer of the rotation
  boolean doRotate = false; //// if true perform the rotation
  int timeTimer; //// duration of the rotation in frames
  
  color fillColor;
  Modul() {
  }
  Modul(PVector _pos, int _pivot, float _sizeW, float _sizeH, color _fillColor) {
    pos = _pos;
    sizeW = _sizeW;
    sizeH = _sizeH;
    SizeInnerRect = min(sizeW,sizeH)*0.1;
    
    ///// pivot corner form top left to bottm left clockwise
    pivots[0] = new PVector(0, 0);  /// A
    pivots[1] = new PVector( -sizeW, 0); //// B
    pivots[2] = new PVector( -sizeW, -sizeH); ///// C
    pivots[3] = new PVector( 0, -sizeH); ///// D
    pivots[4] = new PVector( -sizeW * 0.5, -sizeH * 0.5); //// CENTER

    //// current pivot point
    pivot = pivots[_pivot];


    //// make a new timer
    timer = new Timer();
    fillColor = _fillColor;
  }

  void update() {
    if (timer.isFinished()) {
      doRotate = false;
    }

    if (doRotate) {
      int passedTime = timer.passedTime();
      // currAngleRot = constrain(map(passedTime,0,timeTimer,0, PI),0, PI);

      int randomEasingType = 3;  
      //map2(float value, float start1, float stop1, float start2, float stop2, int type, int when)
      currAngleRot =
        map2(passedTime, 0, timeTimer, 0, amtAngleRot, randomEasingType, 0);

      //println("curr " + currAngleRot);
      //println("old " + oldAngleRot);
    }
    show();
  }

  void show() {
    noFill();
    stroke(white);
    strokeWeight(5);

    pushMatrix();
        translate( pos.x, pos.y);


    rotate(oldAngleRot);
    rotate(currAngleRot);
    translate( pivot.x, pivot.y);

    pushMatrix();
    fill(fillColor);
   // noFill();
    noStroke();
    rect(0, 0, sizeW, sizeH);
    rectMode(CENTER);
   // fill(white);
   // rect(sizeW * 0.5 ,  sizeH * 0.5, SizeInnerRect,SizeInnerRect);
    rectMode(CORNER);
    
    //stroke(255,100);
    //text("A", 0, 0);
    //text("B", sizeW, 0);
    //text("C", sizeW, sizeH);
    //text("D", 0, sizeH);
    //line(sizeW * 0.5 - (sizeW * 0.05), sizeH * 0.5, sizeW * 0.5 + (sizeW *0.05), sizeH * 0.5);
    //line(sizeW * 0.5, sizeH * 0.5 - (sizeW * 0.05), sizeW * 0.5, sizeH * 0.5+ (sizeW * 0.05));
      popMatrix();
    popMatrix();
  }

  void startTimer(int time) {
    timeTimer = time;
    timer.start(timeTimer);
  }

  void setRotate(float _amtAngleRot) {
    amtAngleRot = _amtAngleRot;
    if (doRotate == false) {
      oldAngleRot += currAngleRot;
      currAngleRot = 0;
    }
    doRotate = true;
  }
  boolean getStarted() {
    return timer.getStarted();
  }
  void setPivot() {
  }
}
