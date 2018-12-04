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
    
    float tailSizeW = 50;
    float tailSizeH = tailSizeW * 0.1;
    
    body = new Body(tailSizeW, tailSizeH, 20);
  }
  
  void render() {
    pushMatrix();
    translate(location.x, location.y);
    body.render();
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
    location.add(velocity);
    body.update(velocity);
  }
  
  void eat(Food food) {
    body.colour = color((red(body.colour) + red(food.colour)) / 2, (green(body.colour) + green(food.colour)) / 2,(blue(body.colour) + blue(food.colour)) / 2);
    
    body.bodyLength++;
    maxSpeed *= 0.9;
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
