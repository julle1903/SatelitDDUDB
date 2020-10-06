import shapes3d.*;
import shapes3d.contour.*;
import shapes3d.org.apache.commons.math.*;
import shapes3d.org.apache.commons.math.geometry.*;
import shapes3d.path.*;
import shapes3d.utils.*;

Ellipsoid shape;

void setup() {
  size(300, 300, P3D);
  shape = new Ellipsoid(100, 100, 100,24,12);
  shape.texture(this, "earth.jpg").drawMode(S3D.TEXTURE);       
}

void draw() {
  background(0);
  pushMatrix();
  translate(width/2, height/2);
  shape.rotateBy(0, 0.005, 0.005);
  shape.draw(getGraphics());
  popMatrix();
}
