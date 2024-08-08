Chain chain = new Chain();

void setup()
{
  size(1280, 720);
  //background( 75, 75, 150);
  background(255);
   
  chain.segments[0].mass = 0;
}

void draw()
{
  background(150);
  chain.segments[chain.numSegments-1].pos.x = mouseX;
  chain.segments[chain.numSegments-1].pos.y = mouseY;
  

  //PVector size = new PVector(width/2, height/2);

  chain.ResolveConstrains();
  chain.Draw();

  noStroke();
  fill(100, 100, 100);
  circle(width/2, height/2, 5);
}


void mousePressed()
{
}
