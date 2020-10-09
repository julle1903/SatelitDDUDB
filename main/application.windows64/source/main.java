import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import http.requests.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class main extends PApplet {

float angle;

float r = 200;

int requestIntervalInSeconds = 300;

PImage earth;
PShape globe;

public void setup() {
  
  background(255);
  request();
  earth = loadImage("earth.jpg");
  noStroke();
  globe = createShape(SPHERE, r);
  globe.setTexture(earth);
}

int cRequest = 0;

public void draw() {

  int requestTime = millis();

  if (requestTime-cRequest >= 1000*(requestIntervalInSeconds-1)) {
    cRequest = millis();
    request();
  }
  
  PVector location = new PVector();
  location.set(getPosition(PApplet.parseInt((requestTime-cRequest)/1000)));
  int timestamp = getTime(PApplet.parseInt((requestTime-cRequest)/1000));
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

  translate(width*0.5f, height*0.5f);
  rotateY(angle);
  angle += 0.005f;

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


String kei = "87A87V-5RGY6Q-VFFMP6-4KGX";
String url = "https://www.n2yo.com/rest/v1/satellite/positions/25544/41.702/-76.014/0/300/&apiKey=";

int i = 0;

int id;
String name;

GetRequest get = new GetRequest(url+kei);

PVector[] locationList;
int[] timestampList;

public PVector getPosition(int number) {
  return locationList[number];
}

public int getTime(int number) {
  return timestampList[number];
}

public void request() {
  get.send();
  JSONObject json = parseJSONObject(get.getContent());
  if (json == null) {
    println("JSONObject could not be parsed");
  } else {
    JSONObject info = json.getJSONObject("info");
    id = info.getInt("satid");
    name = info.getString("satname");
    JSONArray list = json.getJSONArray("positions");
    locationList = new PVector[list.size()];
    timestampList = new int[list.size()];
    for (int i = 0; i < list.size(); i++) {
      JSONObject object = list.getJSONObject(i);
      locationList[i] = new PVector(object.getFloat("satlatitude"), object.getFloat("satlongitude"), object.getFloat("sataltitude"));
      timestampList[i] = object.getInt("timestamp");
    } 
    JSONObject object = list.getJSONObject(0);
    float l = object.getFloat("dec");
  }
}
  public void settings() {  size(1000, 1000, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
