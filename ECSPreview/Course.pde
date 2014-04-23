import seltar.motion.*;

class Course {
  
  String number;
  String title;
  String time;
  int timeVal;
  String location;
  String instructor;
  String prereq;
  Motion slide;
  
  // Constructor
  Course(String number, String title, String time, int timeVal,
         String location, String instructor, String prereq){
    this.number = number;
    this.title = title;
    this.time = time;
    this.timeVal = timeVal;
    this.location = location;
    this.instructor = instructor;
    this.prereq = prereq;
    slide = new Motion(width*2,0);
  }
  
  void move(int pos) {
    slide.followTo(pos,0);
    slide.move();
    if (abs(slide.getX()) < width) slide.move();
    if(pos == 0) slide.move(); //double moving speed
  }

  void display(int pos) {
    move(pos);
    if (abs(slide.getX()) > width && pos != 0) return;
    
    pushMatrix();
    stroke(1);
    translate(slide.getX(), slide.getY());
    fill(100,50);
    rect(width/20,height/20, width - width/10 , height - height/10, 20);
    
    fill(255);
    
    textSize(min(height,width)/10);
    textAlign(LEFT);
    text(number,width/10,3*height/20);
    
    textSize(min(height,width)/15);
    textAlign(CENTER, TOP);
    text(title,width/10,4*height/20,8*width/10,4*height/20);
    
    textAlign(LEFT);
    text(time,width/10,12*height/20);
    text(instructor,width/10,14*height/20);
    textSize(min(height,width)/30);
    text(prereq,width/10,16*height/20);
    
    popMatrix();
  }
}
