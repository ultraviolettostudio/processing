import processing.javafx.*;

import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;
int nChan = 14;
PrevizLine[] pLines;


void setupOSC() {

  oscP5 = new OscP5(this, 1337);
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);



///// implemented this, because https://forum.processing.org/one/topic/oscp5-major-problems-with-error-handling.html
  TestListener t = new TestListener();
  oscP5.addListener(t);


 
}



class TestListener implements OscEventListener {

  public void oscEvent(OscMessage theOscMessage) {
    String addressPattern = theOscMessage.addrPattern();
    if (theOscMessage.checkTypetag("i") ) {
      int  valueI = theOscMessage.get(0).intValue();
      checkIntMessage(addressPattern, valueI);
      // println("\ncustom OscEventListener Test\nreceived an osc message\nvalue at index 0 (int expected) : "+valueI);
    }

    if (theOscMessage.checkTypetag("f") ) {
      float  valueF = theOscMessage.get(0).floatValue();
      checkFloatMessage(addressPattern, valueF);
    }
  }

  public void checkFloatMessage(String addressPattern, float valueF ) {
     switch (addressPattern) {
    case "/Ableton/ch1":
      if (DEBUG) pLines[0].update(valueF);
      break;
    case "/Ableton/ch2":
      if (DEBUG) pLines[1].update(valueF);
      break;
    case "/Ableton/ch3":
      if (DEBUG) pLines[2].update(valueF);
      break;
    case "/Ableton/ch4":
      if (DEBUG) pLines[3].update(valueF);
      break;
    case "/Ableton/ch5":
      if (DEBUG) pLines[4].update(valueF);
      break;
    case "/Ableton/ch6":
      if (DEBUG) pLines[5].update(valueF);
      break;
    case "/Ableton/ch7":
      if (DEBUG) pLines[6].update(valueF);
      break;
    case "/Ableton/ch8":
      if (DEBUG) pLines[7].update(valueF);
      break;
    case "/Ableton/ch9":
      if (DEBUG) pLines[8].update(valueF);
      break;
    case "/Ableton/ch10":
      if (DEBUG) pLines[9].update(valueF);
      break;
    case "/Ableton/ch11":
      if (DEBUG) pLines[10].update(valueF);
      break;
    case "/Ableton/ch12":
      if (DEBUG) pLines[11].update(valueF);
      break;
    case "/Ableton/chFX":
      if (DEBUG) pLines[12].update(valueF);
      break;
    case "/Ableton/chDEL":
      if (DEBUG) pLines[13].update(valueF);
      break;
    default:
      break;
    }
  }

  public void checkIntMessage(String addressPattern, int valueI ) {

    switch (addressPattern) {
    case "/Ableton/ch1":
      if (DEBUG) pLines[0].updateI(valueI);
      ms1.activateRotationModul((int)random( ms1.getModulsLenght()));

      break;
    case "/Ableton/ch2":
      if (DEBUG) pLines[1].updateI(valueI);
      break;
    case "/Ableton/ch3":
      if (DEBUG) pLines[2].updateI(valueI);
      ms3.activateRotationModul((int)random( ms3.getModulsLenght()));

      break;
    case "/Ableton/ch4":
      if (DEBUG) pLines[3].updateI(valueI);
      startRotationCluster();
      break;
    case "/Ableton/ch5":
      if (DEBUG) pLines[4].updateI(valueI);
      ms5.activateRotationModul((int)random( ms5.getModulsLenght()));

      break;
    case "/Ableton/ch6":
      if (DEBUG) pLines[5].updateI(valueI);

      break;
    case "/Ableton/ch7":
      if (DEBUG) pLines[6].updateI(valueI);

      break;
    case "/Ableton/ch8":
      if (DEBUG) pLines[7].updateI(valueI);

      break;
    case "/Ableton/ch9":
      if (DEBUG) pLines[8].updateI(valueI);
      ms9.activateRotationModul((int)random( ms9.getModulsLenght()));

      break;
    case "/Ableton/ch10":
      if (DEBUG) pLines[9].updateI(valueI);
      ms10.activateRotationModul((int)random( ms10.getModulsLenght()));
      //activateRandomRotationModul();
      break;
    case "/Ableton/ch11":
      if (DEBUG) pLines[10].updateI(valueI);
      ms11.activateRotationModul((int)random( ms11.getModulsLenght()));
      break;
    case "/Ableton/ch12":
      if (DEBUG) pLines[11].updateI(valueI);

      break;
    case "/Ableton/chFX":
      if (DEBUG) pLines[12].updateI(valueI);
      break;
    case "/Ableton/chDEL":
      if (DEBUG) pLines[13].updateI(valueI);
      break;
    default:
      break;
    }
  }

  public void oscStatus(OscStatus theStatus) {
    println("osc status : "+theStatus.id());
  }
}
