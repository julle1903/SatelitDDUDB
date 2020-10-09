float angle;

float r = 200;

int requestIntervalInSeconds = 300;

PImage earth;
PShape globe;

void setup() {
  size(1000, 1000, P3D);
  background(255);
  request();
  earth = loadImage("earth.jpg");
  noStroke();
  globe = createShape(SPHERE, r);
  globe.setTexture(earth);
}

int cRequest = 0;

void draw() {

  int requestTime = millis();

  if (requestTime-cRequest >= 1000*(requestIntervalInSeconds-1)) {
    cRequest = millis();
    request();
  }
  
  PVector location = new PVector();
  location.set(getPosition(int((requestTime-cRequest)/1000)));
  int timestamp = getTime(int((requestTime-cRequest)/1000));
  println(location);
  println(timestamp);  
  
  background(51);

  fill(0);
  stroke(0);
  textSize(30);
  String textName = "Name: " + name;
  String textTime = "Timestamp: " + timestamp; 
  text(textName, 20, 30);
  text(textTime, 20, 60);

  translate(width*0.5, height*0.5);
  rotateY(angle);
  angle += 0.005;

  lights();
  fill(200);
  noStroke();
  //sphere(r);
  shape(globe);

  float theta = radians(location.x);
  float phi = radians(location.y) + PI;

  float x = location.z * cos(phi);
  float y = -location.z * sin(theta);
  float z = -location.z * cos(theta) * sin(phi);

  PVector pos = new PVector(x, y, z);

  PVector xaxis = new PVector(1, 0, 0);
  float angleb = PVector.angleBetween(xaxis, pos);
  PVector raxis = xaxis.cross(pos);

  pushMatrix();
  translate(x, y, z);
  rotate(angleb, raxis.x, raxis.y, raxis.z);
  fill(60);
  stroke(0);
  sphere(5);
  popMatrix();

  
} 
