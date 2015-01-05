//--------------------------OBJECT----------------------------------------------

class Particle {

  PVector loc, vel, acc;  //location, velocity, and acceleration vectors
  int sz;                 //size of particle
  float mass;             //mass variable
  int velocityLimit = 5;  //the maximum velocity a particle can travel at
  float d;                //distance variable between particle and the target co-ordinates (tbd later)
  color c;                //color variable

  //CONSTRUCTOR
  Particle(PVector temploc, int tempsz, float tempmass) {
    loc = temploc.get();      //when calling loc, return current location of the selected particle
    vel = new PVector(0, 0);  //set vel and acc vectors to 0 as default
    acc = new PVector(0, 0);
    sz = tempsz;
    mass = tempmass;
    colorMode(HSB, 360, 100, 100, 100);
  }


  //method to render the particle
  void display() {
    ellipseMode(CENTER);
    c = color(frameCount%360, 100, 100, 100);  //define the color variable
    fill(c);                                   //fill the ellipse with the color variable
    ellipse(loc.x, loc.y, sz, sz);
  }

  //math for attraction and repulsion forces
  //tx and ty are the co-ordinates attraction/repulsion will be applied to
  void forces(float tx, float ty) {

    PVector targetLoc = new PVector(tx, ty);    //creating new PVector for attractive/repulsive x and y values
    acc = PVector.sub(loc, targetLoc);          //calculate the direction vector between a particle and targetLoc and set that as the acceleration vector
    acc.setMag(.1);                             //set the magnitude of the acceleration vector

    //if the mouse is pressed, turn on repulsion
    if (mousePressed) {
      acc.mult(1);
    }
    //else switch the direction the particle travels in (attraction)
    else {
      acc.mult(-1);
    }
  }


  //method to move the location of the particle and keep its velocity within a set limit
  void move() {
    vel.add(acc);              //change velocity by acceleration
    vel.limit(velocityLimit);  //limit the velocity
    loc.add(vel);              //change location by velocity
    acc.mult(0);
  }

  //method to bounce particles off canvas edges
  void bounds() {
    if (loc.y > height || loc.y < 0) {
      vel.y *= -1;
    }
    if (loc.x > width || loc.x < 0) {
      vel.x *= -1;
    }
  }

  //main method that combines all previous methods, and takes two arguments
  //tx and ty are inherited from forces(), and set the attractive/repulsive co-ords
  void run(float tx, float ty) {
    forces(tx, ty);
    display();
    bounds();
    move();
  }
}

