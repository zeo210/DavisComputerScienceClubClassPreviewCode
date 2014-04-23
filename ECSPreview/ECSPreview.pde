//By:Romer Ibo
//Presenation slides
//  -Winter 2014 class preview
//

import seltar.motion.*;

int pos ;
boolean notPressed;
int courseCount;

//make motions below cleaner for next time
Motion l1Top;
Motion l1Mid;
Motion l1Bot;
Motion r1Top;
Motion r1Mid;
Motion r1Bot;
Motion l2Top;
Motion l2Mid;
Motion l2Bot;
Motion r2Top;
Motion r2Mid;
Motion r2Bot;

ArrayList<Course> courses;

void setup()
{
  //size(displayWidth, displayHeight);
  size(800,600);
  if (frame != null) {
    frame.setResizable(true);
  }
  pos = 0;
  notPressed = true;
  
  //appologies again
  l1Top = new Motion(2*width,0);
  l1Mid = new Motion(2*width,3*height/4);
  l1Bot = new Motion(2*width,height);
  r1Top = new Motion(2*width,0);
  r1Mid = new Motion(2*width,3*height/4);
  r1Bot = new Motion(2*width,height);
  l2Top = new Motion(2*width,0);
  l2Mid = new Motion(2*width,3*height/4);
  l2Bot = new Motion(2*width,height);
  r2Top = new Motion(2*width,0);
  r2Mid = new Motion(2*width,3*height/4);
  r2Bot = new Motion(2*width,height);
  
  smooth();

  //courses
  courses = new ArrayList<Course>();
  
  courseCount = 0;
  
  courses.add(new Course("WELCOME!",
                         "Spring 2014 Classes Preview",
                         "W 6-8pm",
                         1200+800+(courseCount++),
                         "Kemper 1065",
                         "The Davis Computer Science Club",
                         "Check-in! daviscdclub.org/here"));
  
  Table selectedCourses = loadTable("classes.csv","header");
  
  for(TableRow classRow : selectedCourses.rows())
    courses.add(new Course(classRow.getString("COURSE"),
                           classRow.getString("TITLE"),
                           classRow.getString("TIME"),
                           (courseCount++)*100,
                           classRow.getString("ROOM"),
                           classRow.getString("INSTRUCTOR"),
                           classRow.getString("PREREQS")));
}

void draw()
{
  //background(0);
  enviornment();
  
  for(int i = courses.size() - 1; i >= 0; i--){
    Course currCourse = courses.get(i);
    if (i < pos) currCourse.display(-int(1.15*width));
    else if (i > pos) currCourse.display(int(1.15*width));
    else currCourse.display(0);
  }
}

void keyPressed(){
  if (notPressed){
    notPressed = false;
    if (key == CODED) {
      if (keyCode == RIGHT){
        if (pos < courses.size() - 1) pos++;
      } else if (keyCode == LEFT) {
        if (pos > 0) pos--;
      }
    }
  }
}

void keyReleased(){
  notPressed = true;
}

void enviornment(){
  setGradient(0, 0, width, height, color(240), color(125));
  
  l1Top.followTo(8+(14*pos/courseCount),0);
  
  if (pos == 0){
    l1Top.followTo(22*width/30,0);
    l1Mid.followTo(26*width/30,3*height/4);
    l1Bot.followTo(17*width/30,height);
    r1Top.followTo(24*width/30,0);
    r1Mid.followTo(28*width/30,3*height/4);
    r1Bot.followTo(20*width/30,height);
  }
  else{
    l1Top.followTo(8*width/30,0);
    l1Mid.followTo(5*width/30,6*height/16);
    l1Bot.followTo(17*width/30,height);
    r1Top.followTo(9*width/30,0);
    r1Mid.followTo(6*width/30,13*height/32);
    r1Bot.followTo(20*width/30,height);
  }
  l1Top.move();
  l1Mid.move();
  l1Bot.move();
  r1Top.move();
  r1Mid.move();
  r1Bot.move();
  noStroke();
  fill(100,150,208);
  quad(l1Top.getX(),l1Top.getY(),l1Mid.getX(),l1Mid.getY(),r1Mid.getX(),r1Mid.getY(),r1Top.getX(),r1Top.getY());
  fill(25,120,208);
  quad(l1Mid.getX(),l1Mid.getY(),l1Bot.getX(),l1Bot.getY(),r1Bot.getX(),r1Bot.getY(),r1Mid.getX(),r1Mid.getY());
  
  if (pos == 0){
    l2Top.followTo(19*width/30,0);
    l2Mid.followTo(23*width/30,3*height/4);
    l2Bot.followTo(13*width/30,height);
    r2Top.followTo(21*width/30,0);
    r2Mid.followTo(25*width/30,3*height/4);
    r2Bot.followTo(16*width/30,height);
  }
  else{
    l2Top.followTo(6*width/30,0);
    l2Mid.followTo(3*width/30,6*height/16);
    l2Bot.followTo(13*width/30,height);
    r2Top.followTo(7*width/30,0);
    r2Mid.followTo(4*width/30,13*height/32);
    r2Bot.followTo(16*width/30,height);
  }
  l2Top.move();
  l2Mid.move();
  l2Bot.move();
  r2Top.move();
  r2Mid.move();
  r2Bot.move();
  noStroke();
  fill(175);
  quad(l2Top.getX(),l2Top.getY(),l2Mid.getX(),l2Mid.getY(),r2Mid.getX(),r2Mid.getY(),r2Top.getX(),r2Top.getY());
  fill(125);
  quad(l2Mid.getX(),l2Mid.getY(),l2Bot.getX(),l2Bot.getY(),r2Bot.getX(),r2Bot.getY(),r2Mid.getX(),r2Mid.getY());
}

void setGradient(int x, int y, float w, float h, color c1, color c2) {
  noFill();

  for (int i = y; i <= y+h; i++) {
    float inter = map(i, y, y+h, 0, 1);
    color c = lerpColor(c1, c2, inter);
    stroke(c);
    line(x, i, x+w, i);
  }
}
