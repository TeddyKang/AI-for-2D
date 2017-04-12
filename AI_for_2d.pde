import game2dai.entities.*;
import game2dai.entityshapes.ps.*;
import game2dai.maths.*;
import game2dai.*;
import game2dai.entityshapes.*;
import game2dai.fsm.*;
import game2dai.steering.*;
import game2dai.utils.*;
import game2dai.graph.*;

World world;
StopWatch sw;
MovingEntity mover0;

public void setup() {
  fullScreen();
  world = new World(width, height);
  sw = new StopWatch();
  // Create the mover
  mover0 = new MovingEntity(
      new Vector2D(width/2, height/2), // position
      15,                              // collision radius
     new Vector2D(100, 150),            // velocity
      500,                              // maximum speed
      new Vector2D(1, 1),              // heading
      10,                               // mass
      3,                             // turning rate
      200                          // max force
  ); 
  // What does this mover look like
  ArrowPic view = new ArrowPic(this);
  
  
  // Show collision and movement hints
  //view.showHints(Hints.HINT_COLLISION | Hints.HINT_HEADING | Hints.HINT_VELOCITY);
  // Add the renderer to our MovingEntity
  mover0.renderer(view);
  // Constrain movement
  Domain d = new Domain(60, 60, width, height);
  
  int a = SBF.REBOUND;
  mover0.worldDomain(d, a);
  // Finally we want to add this to our game domain  
  world.add(mover0);
  sw.reset();
}

public void draw() {
  double elapsedTime = sw.getElapsedTime();
  world.update(elapsedTime);
  background(200, 255, 200);
  // Make the movers constraint area visible
  Domain d = mover0.worldDomain();
  fill(255, 200, 200);
  noStroke();
  rect((float)d.width, (float)d.height, (float)d.width, (float)d.height);
  background(0);
  world.draw(elapsedTime);
}