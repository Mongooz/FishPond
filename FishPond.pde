private Fish fish;
ArrayList<Food> foods;

void setup() {
  size(1024, 768, P2D);
  fish = new Fish();
  foods = new ArrayList<Food>();
}

void draw() {
  update();
  fish.render();
}

void update() {
  background(235, 244, 250);
  fish.update();

  for (int i=0; i<foods.size(); i++) {
    if (foods.get(i).isEaten) {
      foods.remove(i);
    }
  }
  
  if (foods.size() + random(1000) < 3) {
    spawnFood();
  }
  
  for (int i=0; i<foods.size(); i++) {
    Food food = foods.get(i);
    if (checkCollisions(food) == false) {
      food.render();
    } else {
      food.isEaten = true;
    }
  }
}

void spawnFood() {
  PVector location = new PVector(random(50, width-50), random(50,height-50));
  color colour = color(random(255),random(255),random(255));
  
  foods.add(new Food(location, colour));
}

boolean checkCollisions(Food food) {
  if (PVector.sub(food.location, fish.location).mag() < 10) {
    fish.eat(food);
    return true;
  }
  
  return false;
}

void mousePressed() {
  fish.heading = new PVector(mouseX, mouseY);
}
  
