class circle {
  PVector Loc, mLoc;
  float w, r;
  boolean active;

  circle(float _x, float _y, float _w) {
    Loc = new PVector(_x, _y);
    mLoc = new PVector(0, 0);
    // x = _x;
    // y = _y;
    w = _w;
    r = w/2;
    active = false;
  }

  void display() {
    stroke(0);

    if (renderMode) {
      fill(0);
      strokeWeight(1);
    } else {
      noFill();
      strokeWeight(1);

      if (active) {
        strokeWeight(3);
        
      }
    }

    ellipse(Loc.x, Loc.y, w, w);
  }
}