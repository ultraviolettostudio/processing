// Example 10-5: Object-oriented timer

class Timer {

  int savedTime; // When Timer started
  int totalTime; // How long Timer should last
  int passedTime;
  boolean started = false;

  Timer() {
  }
  Timer(int tempTotalTime) {
    totalTime = tempTotalTime;
  }

  // Starting the timer
  void start() {
    // When the timer starts it stores the current time in milliseconds.
    savedTime = frameCount;
    started = true;
  }

  void start(int tempTotalTime) {
    totalTime = tempTotalTime;
    // When the timer starts it stores the current time in milliseconds.
    savedTime = frameCount;
    started = true;
  }
  void update() {
    passedTime = frameCount - savedTime;
  }
  // The function isFinished() returns true if 5,000 ms have passed.
  // The work of the timer is farmed out to this method.
  boolean isFinished() {
    // Check how much time has passed
    passedTime = frameCount - savedTime;
    if (passedTime > totalTime) {
      started = false;
      return true;
    } else {
      return false;
    }
  }

  int passedTime() {
    // println(frameCount - savedTime);
    return  frameCount - savedTime;
  }

  boolean getStarted() {
    return started;
  }
}
