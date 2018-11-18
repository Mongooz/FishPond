class Fish
{  
  private Body body;
  private PVector heading;
  private PVector location;
  private PVector velocity;
  private float maxSpeed = 3;
  float size = 0.75;

  Fish() {
    heading = new PVector(100, 100);
    location = new PVector(100, 100);
    velocity = new PVector(0, 0);
    
    float tailSizeW = 50;
    float tailSizeH = tailSizeW * 0.1;
    
    body = new Body( tailSizeW, tailSizeH, 20 );
  }
  
  void render() {
    pushMatrix();
    translate(location.x, location.y);
    body.render();
    popMatrix();
  }

  void update() {
    PVector acceleration =heading == null ? new PVector() : 
    PVector.sub(heading,location).normalize();
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    
    location.add(velocity);
    body.update(velocity);
  }
  
  void eat(color food) {
    body.colour = color((red(body.colour) + red(food)) / 2, (green(body.colour) + green(food)) / 2,(blue(body.colour) + blue(food)) / 2);
  }
}
