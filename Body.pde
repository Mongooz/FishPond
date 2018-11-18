class Body {
  int bodyLength;
  ArrayList<PVector> nodes;
	PVector size;
	PVector space;
	float heading;
  float offset;
  color colour = color(0,0,0);
	
	Body(float sizeX, float sizeY, int initialLength) {
    offset = 0;
    bodyLength = max(initialLength, 2);
		size = new PVector(sizeX, sizeY);
		nodes = new ArrayList<PVector>();
		space = new PVector(sizeX / float(bodyLength + 1), sizeY / 2.0);
		
    for ( int n = 0; n < bodyLength; n++ ) {
      nodes.add(new PVector(space.x * n, space.y));
    }
	}

	void update(PVector velocity) {
    offset += norm(velocity.mag(), 0, 1 ) * 0.1;
    heading = velocity.heading();
  
    nodes.set(0, new PVector(cos(heading), sin(heading)));
    for (int n = nodes.size()-1; n < bodyLength; n++ ) {
      nodes.add(new PVector(space.x * n, space.y));
    }
		
		float offsetAngle = 0.15 * sin(offset);
    nodes.set(1, new PVector(-space.x * cos(heading + offsetAngle) + nodes.get(0).x, -space.x * sin(heading + offsetAngle) + nodes.get(0).y));

		for ( int n = 2; n < bodyLength; n++ ) {
      PVector diff = PVector.sub(nodes.get(n), nodes.get(n-2));
      PVector pos = new PVector(nodes.get(n-1).x + (diff.x * space.x) / diff.mag(), nodes.get(n-1).y + (diff.y * space.x) / diff.mag());

      nodes.set(n, pos);
		}
	}

  void render() {
    // head
    pushMatrix();
    rotate(heading);
    ellipse(0, 0, 15, 10);
    popMatrix();
    
    // tail
    fill(colour);
    noStroke();
    beginShape(TRIANGLE_STRIP);
    for (int n = 0; n < bodyLength; n++) {
      PVector diff = PVector.sub(nodes.get(max(1, n)), nodes.get(max(0, n-1))); 
      float angle = -atan2(diff.y, diff.x);
      float b = bezierPoint( 2, size.y, size.y * 0.75, 0, n / float(nodes.size() - 1));
      PVector curve = new PVector(sin(angle) * b, cos(angle) * b);
      PVector vertex1 = PVector.sub(nodes.get(n), curve);
      PVector vertex2 = PVector.add(nodes.get(n), curve);
      vertex(vertex1.x, vertex1.y);
      vertex(vertex2.x, vertex2.y);
    }
    endShape();
  }
}
