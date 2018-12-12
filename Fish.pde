class Fish
{  
  private Body body;
  private PVector heading;
  private PVector location;
  private PVector velocity;
  private float maxSpeed = 3;
  float size = 0.75;

  Fish() {
    heading = null;
    location = new PVector(100, 100);
    velocity = new PVector(0, 0);
    
    body = new Body(50, 3, 20);
  }
  
  void render() {
    pushMatrix();
    translate(location.x, location.y);
    body.render();
    
    if (body.size.y < 3 && body.size.y > 0.6) {
      if (floor(frameCount / 30) % 2 == 0) {
        pushMatrix();
        rotate(body.heading + (PI / 2));
        strokeWeight(3);
        stroke(255, 0, 0);
        line(-20, -20, -10, -10);
        line(0, -25, 0, -10);
        line(20, -20, 10, -10);
        popMatrix();
      }
    }
    
    popMatrix();
  }

  void update() {
    PVector acceleration = heading == null ? new PVector(0, 0) : PVector.sub(heading, location);
    if (acceleration.mag() < 10) {
      heading = null;
      acceleration = new PVector(velocity.x * -0.1, velocity.y * -0.1);
    }

    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    
    body.size.y -= velocity.mag() * 0.001;
    if (body.size.y < 0.5) {
      body.size.y = 0.5;
    }
    
    if (body.size.y == 0.5)
    {
      velocity = new PVector(0,0);
    }
    
    location.add(velocity);
    body.update(velocity);
  }
  
  void eat(Food food) {
    body.colour = color((red(body.colour) + red(food.colour)) / 2, (green(body.colour) + green(food.colour)) / 2,(blue(body.colour) + blue(food.colour)) / 2);
    
    body.bodyLength++;
    maxSpeed = red(body.colour) / 64;
  }

  void findFood(ArrayList<Food> foods) {
    float closestDistance = 1000;

    for (int i=0; i<foods.size(); i++) {
      Food food = foods.get(i);
      float mag = PVector.sub(food.location, location).mag();
      if (mag < closestDistance) {
        heading = food.location;
        closestDistance = mag;
      }
    }
    
    if (heading == null && closestDistance > 500) {
      heading = new PVector(random(width), random(height));
    }
  }
}
