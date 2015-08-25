/* Normal Original Design
 * Author: Brian Tom
 * Date: 8/21/2015
 * Description: 
 */

void setup() {
  size(640, 480);
  frameRate(5);
}

void draw() {
  background(127);
  ball();
}

float x = (float) (Math.random()*width);
float y = -10;

void ball(x, y) {
  noStroke();
  fill(0);
  ellipse(x, y, 20, 20);
  y++;
}
