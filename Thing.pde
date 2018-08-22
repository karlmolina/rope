class Thing {
  PVector p = new PVector(), v = new PVector(), a = new PVector();
  ArrayList<Thing> connected = new ArrayList();

  Thing(float x, float y) {
    p.x = x;
    p.y = y;
  }

  void update() {
    if (isConnected() ) {
      tension();
      println(a.mag());
    }

    v.add(a);
    p.add(v);
    ellipse(p.x, p.y, sizeOf, sizeOf);
    stroke(100);
    line(p.x, p.y, p.x+a.x, p.y+a.y);
    noStroke();
    a = new PVector();
  }

  void connect(Thing t) {
    connected.add(t);
  }

  void tension() {
    for (int i = 0; i < connected.size(); i++) {
      Thing c = connected.get(i);
      PVector tension = PVector.sub(c.p, p); //<>// //<>//
      PVector velSub = PVector.sub(c.v, v);
      v.add(tension.mult(0.02));//.add(PVector.sub(connected.v, v).mult(.5)));
      v.add(velSub.mult(0.1));
    }
  }

  boolean isConnected() {
    return connected != null;
  }

  boolean on(PVector p) {
    return PVector.dist(p, this.p) < sizeOf;
  }
}
