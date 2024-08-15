class Segment
{
  PVector pos; // center
  PVector prevPos;
  float mass = 1;
  float len = 50;
  color col;
};

class ElasticDistance
{
  int idx_a = -1;
  int idx_b = -1;

  float distance;
  //  float stiffness = 0.1f;
  float compliance = 0.003f;
};

class Chain
{
  int numSegments = 5;
  Segment[] segments;

  int numConstrains = numSegments - 1;
  ElasticDistance[] constrains;

  PVector[] points;
  
  Chain()
  {
    segments = new Segment[numSegments];
    constrains = new ElasticDistance[numConstrains];

    PVector origin = new PVector(1280/2, 720/2);
    for (int i = 0; i < numSegments; ++i)
    {
      Segment s = new Segment();
      s.col = color(50, 50, 100);
      s.pos = origin;
      origin = PVector.add(origin, new PVector(s.len, 0.f));
      segments[i] = s;
    }

    for (int i = 0; i < numConstrains; ++i)
    {
      ElasticDistance c = new ElasticDistance();

      c.idx_a = i;
      c.idx_b = i + 1;

      PVector diff = PVector.sub(segments[i+1].pos, segments[i].pos);
      c.distance = diff.mag();

      constrains[i] = c;
    }
  }

  void Draw()
  {
    strokeWeight(10);
    for (int i = 0; i < numSegments-1; ++i)
    {
      Segment s1 = segments[i];
      Segment s2 = segments[i+1];

      stroke(50, 50, 100, 100);
      line(s1.pos.x, s1.pos.y, s2.pos.x, s2.pos.y);
    }

    for (Segment s : segments)
    {
      stroke(s.col);
      circle(s.pos.x, s.pos.y, 10);
    }
  }

  void ResolveConstrains()
  {
    for (ElasticDistance c : constrains)
    {
      Segment s1 = segments[c.idx_a];
      Segment s2 = segments[c.idx_b];
        
     // s1.pos = ConstrainDistance(s1.pos, s2.pos, c.distance);

      PVector diff = PVector.sub(s2.pos, s1.pos);
     
      // distance, length of the difference
      float distance = diff.mag();
      
      if(distance > s1.len + s2.len)
        distance = s1.len + s2.len;
      
      float displacement = c.distance - distance;

      // direction in which we will move the particles
      PVector dir = diff.normalize();

      float alpha = c.compliance / 0.016;
      //float alpha = 0;
      s1.pos = PVector.add(s1.pos, PVector.mult(PVector.mult(dir, -displacement), (s1.mass / (s1.mass + s2.mass + alpha))));
      s2.pos = PVector.add(s2.pos, PVector.mult(PVector.mult(dir, displacement), (s2.mass / (s1.mass + s2.mass + alpha))));
    }
  };

  PVector ConstrainDistance(PVector point, PVector anchor, float distance)
  {
    PVector diff = PVector.sub(point, anchor);
    PVector dir = diff.normalize();
    PVector v = dir.mult(distance);
    return PVector.add(v, anchor);
  }
};
