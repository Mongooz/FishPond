class Food {
  color colour;
  PVector location;
  boolean isEaten = false;
  
  Food(PVector _location, color _colour) {
    colour = _colour;
    location = _location;
  }
  
  void render() {
    pushMatrix();
    fill(colour);
    translate(location.x, location.y);
    rect(-5, -5, 10, 10);
    popMatrix();
  }
}
