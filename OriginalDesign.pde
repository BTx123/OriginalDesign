/* Normal Original Design
 * Author: Brian Tom
 * Date: 8/26/2015
 * Description: https://processing.org/examples/bouncybubbles.html
 */

// TODO: Fix bug - ball stuck on edge of screen when spawning too close to edge

int maxBalls = 50;  // max number of balls on screen
int numBalls = 0;   // number of balls currently on screen

Ball[] ballArray;   // array of Balls

void setup() {
    size(640, 480);
    ballArray = new Ball[maxBalls];
}

void draw() {
    background(255);
    dots(1, 127, 10);
    for (int i = 0; i < numBalls; i++) {
        ballArray[i].display();  // draw ellipse
        ballArray[i].update();   // update position & direction
    }
}

// Draw background dots
void dots(int pointSize, int grayScale, int interval) {
    strokeWeight(pointSize);
    stroke(grayScale);
    for (int i = interval/2; i < width; i += interval) {
        for (int j = interval/2; j < height; j += interval) {
            point(i, j);
        }
    }
}

// Ball class
class Ball {
    float ballX;
    float ballY;
    float ballDiameter;
    float ballSpeed;

    // Takes initializing variables for diameter and speed
    Ball(int tempDiameter, int tempSpeed) {
        ballDiameter = tempDiameter;
        ballSpeed = tempSpeed;
        // ballX = (float) (Math.random() * (0.9*width) + 10);
        // ballY = (float) (Math.random() * (0.9*height) + 10);

        // ball spawns at mouse position
        ballX = mouseX;
        ballY = mouseY;
    }
    
    color ballColor = color((int) (Math.random()*255), (int) (Math.random()*255), (int) (Math.random()*255));
    
    // Draw ellipse
    void display() {
        noStroke();
        fill(ballColor);
        ellipse(ballX, ballY, ballDiameter, ballDiameter);
    }
    
    // Update position and direction
    void update() {
        // change balls y pos
        ballY += ballSpeed;
        // bounce off bottom of screen
        if (ballY > height - ballDiameter/2)
            ballSpeed *= -1;
        // bounce off top of screen
        else if (ballY < ballDiameter/2)
            ballSpeed *= -1;
    }
}

// Increase number of balls on click
void mouseClicked() {
    int randomDiameter = (int) (Math.random()*41) + 10;
    if (numBalls < maxBalls && mouseY > randomDiameter/2.0 && mouseY < height - randomDiameter/2.0) {
        ballArray[numBalls] = new Ball(randomDiameter, 10);
        numBalls++;
    }
}

int value = 1;

// Play animation when SPACE key is not pressed
void keyTyped() {
  println(value);
    if (key == ' ' && value == 1) {
        noLoop();
        value = -1;
    } else if (key == ' ' && value == -1) {
        loop();
        value = 1;
    }
}
