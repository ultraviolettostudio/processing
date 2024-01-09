class ModulSystem {
  ArrayList<Modul> moduls = new ArrayList<Modul>();
  //// modulSIze
  float sizeW;
  float sizeH;
  /// final compositionSize

  int compositionSizeW ;
  int compositionSizeH ;
  int timeRotation;
  ModulSystem(){
  }
  ModulSystem( int _sizeW, int _sizeH, int _compositionSizeW, int _compositionSizeH, int pivotIndex, color fillColor, int _timeRotation) {
    ////////////////////////
    sizeW = _sizeW;
    sizeH = _sizeH;
    compositionSizeW = _compositionSizeW;
    compositionSizeH = _compositionSizeH;
    for ( int y = - compositionSizeH; y < compositionSizeH; y += sizeH) {
      for ( int x = -compositionSizeW; x < compositionSizeW; x += sizeW) {
        PVector pos = new PVector (x, y);

        //   int ranW = int(sizeW + (((int)random(4)) * sizeW));
        //int ranH = int(sizeH + (((int)random(4)) * sizeH));
     

        Modul  m = new Modul(
          pos, /// position
          pivotIndex, /// pivot index
          sizeW, /// width
          sizeH, //// height
          fillColor
          );
        moduls.add(m);
      }
    }
    
    timeRotation = _timeRotation;
  }
  
  void show() {
    for ( Modul m : moduls) {
       pushMatrix();
      translate(-m.pivot.x,-m.pivot.y);
      m.update();
      popMatrix();
    }
  }
  
  
  int getModulsLenght() {
    return moduls.size();
  }


  void randomRotate1() {
    int ranI = floor(random(moduls.size()));
    Modul m = moduls.get(ranI);
    m.startTimer(300);
    m.setRotate(HALF_PI );
  }
  void randomRotate2() {
    int ranI = floor(random(moduls.size()));
    Modul m = moduls.get(ranI);
    m.startTimer(60);
    m.setRotate(  (HALF_PI + PI)* -1);
  }
  void activateRandomRotationModul() {
  
    int randomIndex = int(random(angles.length));
    float  currentAngle = angles[randomIndex];

    int ranI = floor(random(moduls.size()));
    Modul m = moduls.get(ranI);
    m.startTimer((int)random(30, 50));

    m.setRotate(currentAngle );
  }


  void activateRotationModul(int index) {
    if (index < 0 || index >=moduls.size()) {
      return;
    }

    for ( Modul m : moduls) {
      if (m.getStarted()) {
        return;
      }
    }
    
    int randomIndex = int(random(angles.length));
    float  currentAngle = angles[randomIndex];


    Modul m = moduls.get(index);
    if (m.getStarted() == false) {
      m.startTimer(timeRotation);
      m.setRotate(currentAngle );
    }
  }
}
