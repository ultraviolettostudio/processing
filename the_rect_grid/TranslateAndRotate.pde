void startRotationCluster() {
    //int ranNum = floor(random(7));
    //if (ranNum == 0) translateAndRotate1.setRotatioAndTranslation((int)random(1, 6)*20);
    //if (ranNum == 1) translateAndRotate5.setRotatioAndTranslation((int)random(1, 6)*20);
    //if (ranNum == 2) translateAndRotate9.setRotatioAndTranslation((int)random(1, 6)*20);
    //if (ranNum == 3) translateAndRotate10.setRotatioAndTranslation((int)random(1, 6)*20);
    //if (ranNum == 4) translateAndRotate11.setRotatioAndTranslation((int)random(5, 10)*20);
    //if (ranNum == 5) {
      translateAndRotate1.setRotatioAndTranslation(100);
            translateAndRotate3.setRotatioAndTranslation(100);

      translateAndRotate5.setRotatioAndTranslation(100);
      translateAndRotate9.setRotatioAndTranslation(100);
      translateAndRotate10.setRotatioAndTranslation(100);
      translateAndRotate11.setRotatioAndTranslation(100);
    //}
    //if (ranNum == 6) {
    //  translateAndRotate3.setRotatioAndTranslation((int)random(5, 10)*20);
    //}
  }



class TranslateAndRotateManager {
  PVector pos;
  float angle;
  float scaleAmt;
  TranslateAndRotate TaR;
  int countIndexPos = 0;
  int[][] positions = { {500, 0}, {0, 500}, {-500, 0}, {0, -500}, {500, 500}, {-500, -500}, {500, -500}, {-500, 500} };
  float[] anglesRotGlobal = { radians(90),radians(-90),0 };

  TranslateAndRotateManager(int _scaleAmt) {
    pos = new PVector (0, 0);
    angle = 0;
    TaR = new TranslateAndRotate(pos, angle);
    scaleAmt =_scaleAmt;
  }

  void update() {
    TaR.update();
  }

  void setRotatioAndTranslation(int time) {
    
    if (TaR.getStarted()) {
      return;
    }

    int randomIndex = int(random(anglesRotGlobal.length));
    float  currentAngle = anglesRotGlobal[randomIndex];
    TaR.startTimer(time);
    pos = new PVector(positions[countIndexPos][0] * scaleAmt, positions[countIndexPos][1] * scaleAmt);
    TaR.setRotate(currentAngle, pos );

    countIndexPos++;
    if (countIndexPos >= positions.length) {
      countIndexPos = 0;
    }
  }
}


class TranslateAndRotate {
  PVector pos;
  PVector currPos;
  PVector targetPos;

  float currAngleRot;  //// actual rotation angle
  float oldAngleRot = currAngleRot;  /// rotation stack
  float amtAngleRot = PI;  //// amount of the nexrt rotation

  Timer timer; //// timer of the rotation
  boolean doRotate = false; //// if true perform the rotation
  int timeTimer; //// duration of the rotation in frames

  int easingType;

  TranslateAndRotate(PVector _pos, float _currAngleRot) {
    pos = _pos;
    currPos = _pos;
    targetPos = _pos;

    currAngleRot = _currAngleRot;
    //// make a new timer
    timer = new Timer();
  }

  void update() {
    if (timer.isFinished()) {
      doRotate = false;
      pos = new PVector(currPos.x, currPos.y);
    }

    if (doRotate) {
      int passedTime = timer.passedTime();
      // currAngleRot = constrain(map(passedTime,0,timeTimer,0, PI),0, PI);

      easingType = 4;
      //map2(float value, float start1, float stop1, float start2, float stop2, int type, int when)
      currAngleRot =
        map2(passedTime, 0, timeTimer, 0, amtAngleRot, easingType, 0);


      currPos.x = map2(passedTime, 0, timeTimer, pos.x, targetPos.x, easingType, 0);
      currPos.y = map2(passedTime, 0, timeTimer, pos.y, targetPos.y, easingType, 0);

      // println("curr " + currAngleRot);
      // println("old " + oldAngleRot);
    }
    apply();
  }

  void apply() {
    rotate(oldAngleRot);
    rotate(currAngleRot);
    translate(currPos.x, currPos.y);
  }

  void startTimer(int time) {
    timeTimer = time;
    timer.start(timeTimer);
  }

  void setRotate(float _amtAngleRot, PVector _targetPos) {
    amtAngleRot = _amtAngleRot;
    targetPos = new PVector(_targetPos.x + pos.x, _targetPos.y + pos.y);

    if (doRotate == false) {
      oldAngleRot += currAngleRot;
      currAngleRot = 0;
    }

    doRotate = true;
  }
  boolean getStarted() {
    return timer.getStarted();
  }
}
