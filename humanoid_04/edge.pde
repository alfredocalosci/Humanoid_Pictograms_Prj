class edge {
  circle from, to;
  PVector midLoc;
  float mid;
  circle midC, midC2;
  boolean biggerFrom;

  PVector[] shapeVectors;
  PShape square;

  edge(circle _f, circle _t) {
    from = _f;
    to = _t;
    midLoc = new PVector(0, 0);
    mid = 0;
    midC = new circle(from.Loc.x, from.Loc.y, 10);
    midC2 = new circle(from.Loc.x, from.Loc.y, 10);

    shapeVectors = new PVector[4];
    shapeVectors[0] = new PVector(0, 0);
    shapeVectors[1] = new PVector(0, 0);
    shapeVectors[2] = new PVector(0, 0);
    shapeVectors[3] = new PVector(0, 0);

    square = createShape();
    square.beginShape();
   // square.fill(0, 0, 255);
    //square.noFill();
    square.fill(255);
    square.stroke(0);
    square.strokeWeight(1);
    square.vertex(0, 0);
    square.vertex(60, 0);
    square.vertex(60, 60);
    square.vertex(0, 60);
    square.endShape(CLOSE);

    biggerFrom = true;
    if (from.w < to.w) {
      biggerFrom = false;
    }

    update();
  }

  void display() {
    

    // midPoint
    //fill(0);
    //ellipse(midLoc.x, midLoc.y, 9, 9);

   // noFill();
    //stroke(128, 0, 0);
    //ellipse(midC2.Loc.x, midC2.Loc.y, midC2.w, midC2.w);

    // diff circle
    //stroke(0, 0, 128);
    //ellipse(midC.Loc.x, midC.Loc.y, midC.w, midC.w);
    
    if (renderMode) {
      square.setFill(0);
      shape(square, 0, 0);
    } else {
      square.setFill(255);
    }

    
    
    strokeWeight(1);
    stroke(0);
    line(from.Loc.x, from.Loc.y, to.Loc.x, to.Loc.y);
  }

  void update() {
    // midPoint
    midLoc.x = (from.Loc.x + to.Loc.x)/2;
    midLoc.y = (from.Loc.y + to.Loc.y)/2;

    mid = PVector.dist(from.Loc, to.Loc);

    // dif circle
    float d = abs(from.w - to.w);
    if (d == 0){
      d = 0.001;
    }
    
    midC.w = d;
    midC.r = d/2;

    if (from.w < to.w) {
      midC.Loc = to.Loc;
      biggerFrom = false;
    } else {    
      midC.Loc = from.Loc;
      biggerFrom = true;
    }

    midC2.Loc = midLoc;
    midC2.w = mid;
    midC2.r = mid/2;

    PVector[] tmp_vectors = circleIntersect(midC, midC2);

    if (tmp_vectors != null ) {
      /*
      fill(255, 0, 0);
      stroke(0);
      ellipse(tmp_vectors[0].x, tmp_vectors[0].y, 12, 12);
      ellipse(tmp_vectors[1].x, tmp_vectors[1].y, 12, 12);
      ellipse(tmp_vectors[2].x, tmp_vectors[2].y, 6, 6);
      */

      // calculate vector A > center to intersection 0
      // calculate vector B > center to intersection 1

      PVector A = PVector.sub(tmp_vectors[0], to.Loc );
      PVector B = PVector.sub(tmp_vectors[1], to.Loc );
      float r1 = to.w/2;
      float r2 = from.w/2;

      if (biggerFrom) {
        A = PVector.sub(tmp_vectors[0], from.Loc);
        B = PVector.sub(tmp_vectors[1], from.Loc);
        r1 = from.w/2;
        r2 = to.w/2;
      } 

      float a = A.heading();
      float b = B.heading();

      float x1 = to.Loc.x + (cos(a) * r1);
      float y1 = to.Loc.y + (sin(a) * r1);

      float x2 = to.Loc.x + (cos(b) * r1);
      float y2 = to.Loc.y + (sin(b) * r1);

      float x3 = from.Loc.x + (cos(a) * r2);
      float y3 = from.Loc.y + (sin(a) * r2);

      float x4 = from.Loc.x + (cos(b) * r2);
      float y4 = from.Loc.y + (sin(b) * r2);

      if (biggerFrom) {
        x1 = from.Loc.x + (cos(a) * r1);
        y1 = from.Loc.y + (sin(a) * r1);

        x2 = from.Loc.x + (cos(b) * r1);
        y2 = from.Loc.y + (sin(b) * r1);

        x3 = to.Loc.x + (cos(a) * r2);
        y3 = to.Loc.y + (sin(a) * r2);

        x4 = to.Loc.x + (cos(b) * r2);
        y4 = to.Loc.y + (sin(b) * r2);
      }

/*
      ellipse(x1, y1, 12, 12);
      ellipse(x2, y2, 12, 12);

      ellipse(x3, y3, 12, 12);
      ellipse(x4, y4, 12, 12);
*/
      shapeVectors[0].x = x1;
      shapeVectors[0].y = y1;

      shapeVectors[1].x = x2;
      shapeVectors[1].y = y2;

      shapeVectors[2].x = x4;
      shapeVectors[2].y = y4;

      shapeVectors[3].x = x3;
      shapeVectors[3].y = y3;

      for (int i = 0; i < square.getVertexCount(); i++) {
        PVector v = square.getVertex(i);
        v.x = shapeVectors[i].x;
        v.y = shapeVectors[i].y;
        square.setVertex(i, v);
      }
    } else {

      println("void");
    }
  }
}