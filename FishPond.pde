private Fish fish;
  
void setup() {
  size(1024, 768, P2D);
  fish = new Fish();
}

void draw() {
  background(235, 244, 250);
  fish.update();
  fish.render();
}

void mousePressed() {
  fish.heading = new PVector(mouseX, mouseY);
  
  fish.eat(color(random(255),random(255),random(255)));
}
  
