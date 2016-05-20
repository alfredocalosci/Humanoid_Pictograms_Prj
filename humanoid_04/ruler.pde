class ruler {

  float ya, yb, yc;
  float h, m;
  float ratio = 0.61;

  int w1, w2, w3;

  ruler(float _a, float _b) {
    ya = _a;
    yb = _b;

    h = abs(ya-yb);
    m = h *ratio;
    yc = yb - m;

    w1=1;
    w2=1;
    w3=1;
  }

  void display() {
    stroke(200, 0, 0, 128);
    strokeWeight(w1);
    line(0, ya, width, ya);
    strokeWeight(w2);
    line(0, yb, width, yb);
    strokeWeight(w3);
    line(0, yc, width, yc);
  }

  void mouseMoved() {
  }

  void update(int N) {

    if (N == 1) {
      // a
      h = abs(ya-yb);
      m = h *ratio;
      yc = yb - m;
    }

    if (N == 2) {
      // b
      h = abs(ya-yb);
      m = h *ratio;
      yc = yb - m;
    }

    if (N == 3) {
      // c
      m = abs(yb-yc);
      h = m * (1/ratio);
      ya = yb - h;
    }
  }
}