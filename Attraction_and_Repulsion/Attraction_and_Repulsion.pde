/*
 Hold down key to add particles.
 
 Particles will be automatically removed  if the amount exceeds the limit.
 
 Hold the mouse to repel and release the mouse to attract.
 */

//------------------------ INITIALIZE VARIABLES ------------------------

ArrayList<Particle> p = new ArrayList<Particle>(); //initialize arraylist of particles named "p"
int maxParticles = 2000;                           //max amount of particles

//------------------------ SETUP ---------------------------------------

void setup() {
  size(displayWidth, displayHeight);
  smooth();
  noStroke();
  background(0);
}

//------------------------ DRAW ----------------------------------------

void draw() {

  //draw trails to the end of each particle, can be edited by changing the second value in fill()
  fill(0, 20);
  rect(0, 0, width, height);

  //add particles every frame when a key is pressed
  if (keyPressed) {
    p.add(new Particle(new PVector(random(0, width), random(0, height)), 2, 10));
  }

  for (int i=0; i<p.size (); i++) {
    Particle j = p.get(i);
    j.run(mouseX, mouseY);
  }

  //remove particles if the amount exceeds the maximum amount
  if (p.size() >= maxParticles) {
    p.remove(0);
  }

  //print amount of particles displayed
  println(p.size());
}

