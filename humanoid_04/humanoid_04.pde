// pdf
import processing.pdf.*;
boolean record;

ArrayList <circle> Circles;
ArrayList <edge> Edges;
ArrayList <sizer> Sizers;
ArrayList <ruler> Rulers;
boolean renderMode;

float g1, g2;

void setup() {
  size(900, 600);
  renderMode = false;
  record = false;
  frameRate(24);

  Circles = new ArrayList();
  Edges = new ArrayList();
  Sizers = new ArrayList();
  Rulers = new ArrayList();

  initHumanoid();
  g1= 12;
  g2 = 4;

  ruler r1 = new ruler(20, 564);
  Rulers.add(r1);
}

void draw() {
  background(255);

  if (record) {
    // Note that #### will be replaced with the frame number. Fancy!
    // inizia a registrare
    beginRecord(PDF, "frame-####.pdf");
  }

  noFill();
  strokeWeight(1);

  if (!record) {

    stroke(200, 128);
    float q = height/ (g1*g2);

    for (int n = 0; n< (g1*g2); n++) {
      line(0, n*q, width, n*q);
      line(n*q, 0, n*q, height);
    }

    stroke(200);
    q = height / g1;
    for (int n = 0; n< g1; n++) {
      line(0, n*q, width, n*q);
      line(n*q, 0, n*q, height);
    }

    for (int n = 0; n< Rulers.size(); n++) {
      ruler r = Rulers.get(n);
      r.display();
    }

    noStroke();
    rect(0, 0, 600, 600);
    fill(200);
    rect(600, 0, 900, 600);
  }

  for (int n = 0; n< Edges.size(); n++) {
    edge e = Edges.get(n);
    //e.update();
    e.display();
  }

  for (int n = 0; n< Circles.size(); n++) {
    circle c = Circles.get(n);
    c.display();
  }

  for (int n = 0; n< Sizers.size(); n++) {
    sizer s = Sizers.get(n);
    s.display();
  }

  // finisce la registrazione
  if (record) {
    endRecord();
    record = false;
  }
}

void mousePressed() {
  PVector Loc = new PVector(mouseX, mouseY);

  for (int n = 0; n< Sizers.size(); n++) {
    sizer s = Sizers.get(n);
    float d = s.Loc.dist(Loc);

    if (d < 7) {
      s.active = true;
      s.mLoc = PVector.sub(Loc, s.Loc);
    } else {
      s.active = false;
    }
  }

  // loop circles
  // pick the closest
  int closest = -1;
  float minD = 1000;

  for (int n = 0; n< Circles.size(); n++) {
    circle c = Circles.get(n);
    float d = c.Loc.dist(Loc);

    if (d < c.w/2 -6) {
      if (d < minD) {
        minD = d;
        closest = n;
      }
    } 

    c.active = false;
  }

  if (closest >= 0) {
    circle c = Circles.get(closest);
    c.active = true;
    c.mLoc = PVector.sub(Loc, c.Loc);
  }
}

void mouseMoved() {
  PVector Loc = new PVector(mouseX, mouseY);

  // loop relers
  if (mouseX < 64) {
    for (int n = 0; n< Rulers.size(); n++) {
      ruler r = Rulers.get(n);

      if (abs(mouseY- r.ya) < 5) {
        r.w1 = 3;
      } else {
        r.w1 = 1;
      }

      if (abs(mouseY- r.yb) < 5) {
        r.w2 = 3;
      } else {
        r.w2 = 1;
      }  

      if (abs(mouseY- r.yc) < 5) {
        r.w3 = 3;
      } else {
        r.w3 = 1;
      }
    }
  }

  // loop sizers
  for (int n = 0; n< Sizers.size(); n++) {
    sizer s = Sizers.get(n);
    float d = s.c.Loc.dist(Loc);

    if (d < (s.c.w/2 + 12)) {
      s.over = true;
      //c.mLoc = PVector.sub(Loc, c.Loc);
    } else {
      s.over = false;
    }
  }
}

void mouseDragged() {
  PVector Loc = new PVector(mouseX, mouseY);

  for (int n = 0; n< Rulers.size(); n++) {
    ruler r = Rulers.get(n);

    if (r.w1 > 1) {
      r.ya = mouseY;
      r.update(1);
    }

    if (r.w2 > 1) {
      r.yb = mouseY;
      r.update(2);
    }

    if (r.w3 > 1) {
      r.yc = mouseY;
      r.update(3);
    }
  }

  for (int n = 0; n< Sizers.size(); n++) {
    sizer s = Sizers.get(n);

    if (s.active) {
      s.Loc = Loc.sub(s.mLoc);
      float d = s.c.Loc.dist(s.Loc)*2;
      s.c.w = d;
      PVector A = PVector.sub(s.Loc, s.c.Loc);
      s.a = A.heading();
    }
  }

  // loop circles
  for (int n = 0; n< Circles.size(); n++) {
    circle c = Circles.get(n);
    if (c.active) {
      c.Loc = Loc.sub(c.mLoc);
    }
  }

  // update edges
  for (int n = 0; n< Edges.size(); n++) {
    edge e = Edges.get(n);
    e.update();
  }

  // update sizers
  for (int n = 0; n< Sizers.size(); n++) {
    sizer s = Sizers.get(n);
    s.update();
  }
}

void keyPressed() {
  if (key == 'r') {
    // toggle renderMode
    renderMode = !renderMode;
    println("renderMode:" + renderMode);
  }

  if (key == 's' || key == 'S') {
    println("saving pdf:");
    record = true;
  }
}