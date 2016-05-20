class sizer {
  circle c;
  boolean over, active;
  float a;

  PVector Loc, mLoc;

  sizer(circle _c, float _a) {
    c = _c;
    a = _a;
    over = false;
    active = false;

    Loc = new PVector(0, 0);
    mLoc = new PVector(0, 0);
    update();
  }

  void display() {

    stroke(128);
    strokeWeight(3);
    fill(255);

    if (active) {
      fill(200, 0, 0);
    }

    if (over) {
      stroke(0);
      ellipse(Loc.x, Loc.y, 12, 12);
    }
  }

  void update() {
    if (!active) {
      updateLoc();
    }
  }
  
  void updateLoc() {
    if (!active) {
      Loc.x = c.Loc.x + (cos(a)* c.w/2);
      Loc.y = c.Loc.y + (sin(a)* c.w/2);
    }
  }
}