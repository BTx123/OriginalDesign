/* Normal Original Design
 * Author: Brian Tom
 * Date: 8/26/2015
 * Description: Simulates bouncing balls (without physics)
 */

int maxBalls = 100;  // max number of balls on screen
int numBalls = 0;    // number of balls currently on screen

Ball[] ballArray;    // array of Balls

void setup()
{
    size(640, 480);
    ballArray = new Ball[maxBalls];
}

void draw()
{
    background(255);
    dots(1, 127, 10);
    for (int i = 0; i < numBalls; i++) {
        ballArray[i].display();  // draw ellipse
        ballArray[i].update();   // update position & direction
    }
}

// Draw background dots
void dots(int pointSize, int grayScale, int interval)
{
    strokeWeight(pointSize);
    stroke(grayScale);
    for (int y = interval/2; y < height; y += interval) {
        for (int x = interval/2; x < width; x += interval) {
            point(x, y);
        }
    }
}

// Ball class
class Ball
{
    // Ball position, size, speed
    float ballX;
    float ballY;
    float ballDiameter;
    float ballSpeed;
    // Takes initializing variables for diameter and speed
    Ball(int tempDiameter, int tempSpeed)
    {
        ballDiameter = tempDiameter;
        ballSpeed = tempSpeed;
        // ballX = (float) (Math.random() * (0.9*width) + 10);
        // ballY = (float) (Math.random() * (0.9*height) + 10);

        // ball spawns at mouse position
        ballX = mouseX;
        ballY = mouseY;
    }
    // Draw ellipse
    color ballColor = color((int) (Math.random()*255), (int) (Math.random()*255), (int) (Math.random()*255));
    void display()
    {
        noStroke();
        fill(ballColor);
        ellipse(ballX, ballY, ballDiameter, ballDiameter);
    }
    // Determines spawn direction (up or down)
    double randDir = Math.random();
    // Update position and direction
    void update()
    {
        // change balls' y pos
        if (randDir < 0.5)     // 50% to spawn down
            ballY += ballSpeed;
        else                     // 50% to spawn down
            ballY -= ballSpeed;
        // bounce off bottom of screen
        if (ballY > height - ballDiameter/2)
            ballSpeed *= -1;
        // bounce off top of screen
        else if (ballY < ballDiameter/2)
            ballSpeed *= -1;
    }
}

// Increase number of balls on click
void mouseClicked()
{
    int randDiameter = (int) (Math.random()*41) + 10;
    int randSpeed = (int) (Math.random()*11) + 5;
    // prevent balls from spawning too close to edge and getting stuck
    if (numBalls < maxBalls && mouseY > randDiameter/2.0 && mouseY < height - randDiameter/2.0)
    {
        ballArray[numBalls] = new Ball(randDiameter, randSpeed);
        numBalls++;
    }
    redraw();
}

// Pause/Play animation with SPACEBAR key
int value = 1;
void keyTyped()
{
    if (key == ' ' && value == 1)
    {
        noLoop();
        value = -1;
    }
    else if (key == ' ' && value == -1)
    {
        loop();
        value = 1;
    }
}
