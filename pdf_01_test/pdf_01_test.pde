// pdf
import processing.pdf.*;
boolean record;

void setup() {
  size(800,800);
  smooth();
  
  // non stiamo registrando
  record = false;
}

void draw() {
  
  if (record) {
    // Note that #### will be replaced with the frame number. Fancy!
    // inizia a registrare
    beginRecord(PDF, "frame-####.pdf");
  }
  
  // disegna qualcosa qui
  background(200);
  fill(128,0,0);
  noStroke();
  ellipse(400,400,300,300);
  
  // finisce la registrazione
  if (record) {
    endRecord();
    record = false;
  }
}


void keyPressed(){
    // tasto S per registrare
    if (key == 's' || key == 'S') {
      record = true;
    }
}
