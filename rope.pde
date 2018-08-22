float sizeOf = 20;
PVector gravity = new PVector(0, 2);
Thing[] things;
PVector center;
int amount = 4;
PVector mouse, mousePrev;

boolean dragging = false;
Thing dragged;

void setup() {
  size(800,800);
  noStroke();
  center = new PVector(width/2, height/2);
  things = new Thing[amount];
  things[0] = new Thing (center.x, 50) ;
  for (int i = 1; i < things.length; i ++) {
    things[i] = new Thing(center.x + 10, i*30 + 50);
    things[i].connect(things[i-1]);
    if (i > 1) {
      println(i);
      things[i-1].connect(things[i]);
    }
  }
}

void draw() {
  mousePrev = mouse;
  mouse = new PVector(mouseX,mouseY);
  
  background(0); //<>//
  things[0].update();
  for (int i = 1; i < things.length; i ++) {
    Thing t = things[i];
    if (i == things.length -1) {
    t.a.add(gravity);
    }
    t.update();
  }
  
  if (dragging) {
    dragged.p = mouse;
    dragged.v = new PVector();
    dragged.a = new PVector();
  }
}

void mousePressed() {
  for (Thing t: things) {
    if (t.on(mouse)) {
      dragging = true;
      dragged = t;
    }
  }
}

void mouseReleased() {
  if (dragging) {
    dragged.v = PVector.sub(mouse, mousePrev);
  }
  dragging = false;
}
