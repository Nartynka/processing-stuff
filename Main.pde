Chain chain = new Chain();

void setup()
{
  size(1280, 720);
  //background( 75, 75, 150);
  background(255);
   
 chain.segments[0].mass = 0;
 chain.segments[0].col = color(255, 255, 255);
}

float x;
float y;
float easing = 0.05;

void draw()
{
  background(150);
  
  Segment lastSegment = chain.segments[chain.numSegments-1];
  PVector mouse = new PVector(mouseX, mouseY);
  
  PVector diff = PVector.sub(mouse, lastSegment.pos);

  PVector dir = diff.normalize();
  PVector target = PVector.mult(dir, 24);
  lastSegment.pos.add(target);
  
  chain.ResolveConstrains();
  chain.Draw();
  stroke(255);
  strokeWeight(4);
  line(lastSegment.pos.x, lastSegment.pos.y,lastSegment.pos.x + target.x,lastSegment.pos.y + target.y);

  noStroke();
  fill(100, 100, 100);
  circle(width/2, height/2, 5);
}
