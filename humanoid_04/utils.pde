PVector[] circleIntersect( circle cA, circle cB ) { 
  // return Pvector P1, P2 + mediumPoint
  PVector[] vectors = new PVector[3];

  float dx = cA.Loc.x - cB.Loc.x; 
  float dy = cA.Loc.y - cB.Loc.y; 
  float d2 = dx*dx + dy*dy; 
  float d = sqrt( d2 ); 

/*
  println(dx);
  println(dy);
  println(d);
*/

  if ( d>cA.r+cB.r || d<abs(cA.r-cB.r) ) {
    //return; // no solution > breack
    println("no intersection");
    return null;
  } else {
    //float a = (cA.w - cB.w + d2) / (2*d); 
   float a = (pow(cA.r, 2) - pow(cB.r, 2) + d2) / (2*d); 
   float h = sqrt( pow(cA.r, 2) - a*a ); 
   
    float x2 = cA.Loc.x + a*(cB.Loc.x - cA.Loc.x)/d; 
    float y2 = cA.Loc.y + a*(cB.Loc.y - cA.Loc.y)/d; 
  
    float paX = x2 + h*(cB.Loc.y - cA.Loc.y)/d; 
    float paY = y2 - h*(cB.Loc.x - cA.Loc.x)/d; 
    float pbX = x2 - h*(cB.Loc.y - cA.Loc.y)/d; 
    float pbY = y2 + h*(cB.Loc.x - cA.Loc.x)/d; 


    vectors[0] = new PVector(paX, paY);
    vectors[1] = new PVector(pbX, pbY);
    vectors[2] = new PVector(x2, y2);
  }
  return vectors;
} 


void initHumanoid(){
  
  // first set
  circle c1 = new circle(300, 60, 80);
  circle c2 = new circle(300, 170, 120);
  circle c3 = new circle(300, 300, 121);

  // left arm
  circle c4 = new circle(270, 140, 60);
  circle c5 = new circle(200, 310, 40);

  // right arm
  circle c6 = new circle(330, 140, 60);
  circle c7 = new circle(400, 310, 40);

  circle c8 = new circle(270, 300, 60);
  circle c9 = new circle(280, 550, 30);

  circle c10 = new circle(330, 300, 60);

  circle c11 = new circle(320, 550, 30);
  
  
   Circles.add(c1);
  Circles.add(c2);
  Circles.add(c3);
  Circles.add(c4);
  Circles.add(c5);
  Circles.add(c6);
  Circles.add(c7);
  Circles.add(c8);
  Circles.add(c9);
  Circles.add(c10);
  Circles.add(c11);
  
  edge e1 = new edge(c2, c3);
  edge e2 = new edge(c4, c5);
  edge e3 = new edge(c6, c7);
  edge e4 = new edge(c8, c9);
  edge e5 = new edge(c10, c11);
  edge e6 = new edge(c4, c6);

  Edges.add(e1);
  Edges.add(e2);
  Edges.add(e3);
  Edges.add(e4);
  Edges.add(e5);
  Edges.add(e6);
  
  // sizers
  for (int n = 0; n< Circles.size(); n++) {
    circle c = Circles.get(n);
    sizer s = new sizer(c, 0);
    Sizers.add(s);
  }

  sizer s = Sizers.get(2);
  s.a = HALF_PI *-1;
  s.updateLoc();

  s = Sizers.get(3);
  s.a = PI;
  s.updateLoc();

  s = Sizers.get(4);
  s.a = PI;
  s.updateLoc();

  s = Sizers.get(7);
  s.a = PI;
  s.updateLoc();

  s = Sizers.get(8);
  s.a = PI;
  s.updateLoc();
  
}