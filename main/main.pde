import shapes3d.*;
import shapes3d.contour.*;
import shapes3d.org.apache.commons.math.*;
import shapes3d.org.apache.commons.math.geometry.*;
import shapes3d.path.*;
import shapes3d.utils.*;

float scl = 3;
int r = 200;

Ellipsoid shape;

void setup() {
  size(800, 800, P3D);
  shape = new Ellipsoid(width/scl, height/scl, width/scl, 24, 12);
  shape.texture(this, "earth.jpg").drawMode(S3D.TEXTURE);    
  request();
}

void draw() {
  background(0);
  pushMatrix();
  translate(width/2, height/2);
  shape.rotateBy(0.0, 0.005, 0.0025);
  shape.draw(getGraphics());
  popMatrix();

}
