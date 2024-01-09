import processing.javafx.*;

boolean DEBUG = false;

float[] angles = { radians(90), radians(-90) };


//float[] angles = { 0, radians(45), radians(90), radians(135), radians(180), radians(225), radians(270), radians(315),
//    radians(-45), radians(-90), radians(-135), radians(-180), radians(-225), radians(-270), radians(-315)
//  };


TranslateAndRotateManager translateAndRotate1 = new TranslateAndRotateManager(1);

TranslateAndRotateManager translateAndRotate3 = new TranslateAndRotateManager(5);

TranslateAndRotateManager translateAndRotate5 = new TranslateAndRotateManager(1);
TranslateAndRotateManager translateAndRotate9 = new TranslateAndRotateManager(1);
TranslateAndRotateManager translateAndRotate10 = new TranslateAndRotateManager(1);
TranslateAndRotateManager translateAndRotate11 = new TranslateAndRotateManager(5);


float generalScale = 1;
int FPS = 60;



ModulSystem ms1, ms3, ms10, ms5, ms11, ms9;

color white =0xFFFFFFFF;
color magenta =0xFFff006e;
color orange = 0x90fb5607;
color purple = 0xA08338ec;
color yellow = 0xFFffbe0b;
color blue = 0x803a86ff;

color grey = 0xFF505050;





boolean released = true;


PGraphics src, clone1, clone2, clone3;
boolean doGlitch = false;

void setup() {
   size(1000, 1000, P3D);
  //fullScreen(P3D);
  // colorMode(HSB, 360, 100, 100);
  setupPrevizLines();
  ///////////////// OSC
  setupOSC();

  //rectMode(CENTER);
  frameRate(FPS);
  //ortho();

  // white =0xFFFFFFFF;
  //magenta =0xFFFFFFFF;
  //orange = 0xFFFFFFFF;
  //purple = 0xFFFFFFFF;
  //yellow = 0xFFFFFFFF;
  //blue = 0xFFFFFFFF;
  // blendMode(EXCLUSION);

//  noCursor();


  //// w modul, h modul, w composition, h composition, pivot index, fill color, timeRotation

  ms1 = new ModulSystem(50, 50, 400, 400, 0, yellow, 8);
  ms3 = new ModulSystem(1800, 50, 1800, 1800, 3, grey, 4);

  ms10 = new ModulSystem(100, 500, 1000, 1000, 0, orange, 8);

  ms11 = new ModulSystem(800, 3200*2, 1600, 3200, 4, purple, 50);

  ms9 = new ModulSystem(900, 900, 1350, 1350, 2, magenta, 8);

  ms5 = new ModulSystem(6400+3200, 300, 3200+1600, 600, 4, blue, 40);




  src = createGraphics(width, height, P3D);
  clone1= createGraphics(width, height, P3D);
  clone2= createGraphics(width, height, P3D);
  clone3= createGraphics(width, height, P3D);
}


void draw() {
  background(0);
  text(frameRate, 10, 10);

  //stroke(255, 100);
  //line(0, 0, width, 0);
  //line(width, 0, width, height);
  //line(width, height, 0, height);
  //line(0, 0, 0, height);
  //line(width * 0.5, 0, width * 0.5, height);
  //line(0, height * 0.5, width, height * 0.5);

  pushMatrix();
  translate(width/2, height/2);
  //generalScale=map2(sin(frameCount * 0.0001),-1,1,0.1,1.3,3,0);
  //scale(generalScale);

  scale(0.2);

  pushMatrix();
  translateAndRotate3.update();
  ms3.show();
  popMatrix();

  pushMatrix();
  translateAndRotate11.update();

  ms11.show();
  popMatrix();

  pushMatrix();
  translateAndRotate9.update();

  ms9.show();
  popMatrix();

  pushMatrix();
  translateAndRotate10.update();

  ms10.show();
  popMatrix();

  pushMatrix();
  translateAndRotate5.update();

  ms5.show();
  popMatrix();

  pushMatrix();
  translateAndRotate1.update();
  ms1.show();
  popMatrix();


  popMatrix();


  if (keyPressed && released) {
    released = false;
    if (key == 'r' || key == 'R') {
      translateAndRotate1.setRotatioAndTranslation(100);
      translateAndRotate5.setRotatioAndTranslation(150);
      translateAndRotate9.setRotatioAndTranslation(200);
      translateAndRotate10.setRotatioAndTranslation(250);
      translateAndRotate11.setRotatioAndTranslation(300);
    }
    if (key == 'g' || key == 'G') {
      doGlitch = !doGlitch;
    }
    if (key == 't' || key == 'T') {
    }
  }

  if (DEBUG) {
    stroke(255);
    for (int i = 0; i < nChan; i++) {
      pLines[i].show();
    }
  }


  if (doGlitch) {
    loadPixels();
      clone1.beginDraw();
      clone1.loadPixels();

      int startIndex = (int) random(pixels.length);
  int endIndex = (int) random(startIndex, pixels.length);
  int count = 0;
  
  for ( int i = startIndex; i< endIndex; i++) {
    clone1.pixels[count] = pixels[i];
    count++;
  }
  
    clone1.updatePixels();

  clone1.endDraw();
  
    image(clone1, 0, 0);
  }
}


//float[] angles = { 0, radians(45), radians(90), radians(135), radians(180), radians(225), radians(270), radians(315) };






void keyReleased() {
  released = true;
}
