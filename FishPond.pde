private Fish fish;
private Fish other;
ArrayList<Food> foods;
PVector offset;

void setup() {
  size(1024, 768, P2D);
  fish = new Fish();
  other = new Fish();
  foods = new ArrayList<Food>();
  offset = new PVector(0, 0);
}

void draw() {
  if (fish.location.x > width - offset.x - 50) {
    offset.x -= width / 2;
  }
  if (fish.location.y > height - offset.y - 50) {
    offset.y -= width / 2;
  }
  if (fish.location.x < 50 - offset.x) {
    offset.x += width / 2;
  }
  if (fish.location.y < 50 - offset.y) {
    offset.y += width / 2;
  }
  
  translate(offset.x, offset.y);
  update();
  fish.render();
  other.render();
}

void update() {
  background(235, 244, 250);
  fish.update();
  
  updateOther();

  for (int i=0; i<foods.size(); i++) {
    if (foods.get(i).isEaten) {
      foods.remove(i);
    }
  }
  
  if (foods.size() + random(1000) < 10) {
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
  PVector location = new PVector(random(50-offset.x, width-50-offset.x), random(50-offset.y,height-50-offset.y));
  color colour = color(random(255),random(255),random(255));
  
  foods.add(new Food(location, colour));
}

void updateOther() {
  other.findFood(foods);
  other.update();
}

boolean checkCollisions(Food food) {
  if (PVector.sub(food.location, fish.location).mag() < 10) {
    fish.eat(food);
    return true;
  }
  
  if (PVector.sub(food.location, other.location).mag() < 10) {
    other.eat(food);
    return true;
  }

  return false;
}

void mousePressed() {
  fish.heading = new PVector(mouseX-offset.x, mouseY-offset.y);
}
  
