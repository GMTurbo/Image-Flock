
boolean FLYMODE = false;

class diamond{
 boolean fromAbove = false;
 PImage piece = null;
 int centerX = 0;
 int centerY = 0;
 int xx = 0;
 int yy = 0;
 int w = 10;
 int h = 10;
 boolean selected = false;
 
 diamond(int x, int y, int wid, int he, PImage img) {
   centerX = x;
   centerY = y;
   w = wid;
   h = he;
   xx = centerX + w/2;
   yy = centerY + h/2;
   c = getRandomColor();
   c = img.get(centerX, centerY);
   piece = img.get(centerX, centerY, w, h);
   rate = random(PI/8, PI/2);
   start = new PVector(centerX + 500 * cos(random(-TWO_PI,TWO_PI)), centerX + 500 * sin(random(-TWO_PI,TWO_PI)));
   end = new PVector(centerX, centerX);
   fromAbove = boolean(round(random(0,1)));
 }
 
 diamond(float x, float y, int wid, int he, PImage img) {
  centerX = ceil(x); 
  centerY = ceil(y); 
  w = wid; 
  h = he; 
  xx = centerX + w/2; 
  yy = centerY + h/2; 
  c = getRandomColor();
  c = img.get(centerX, centerY);
  piece = img.get(centerX, centerY, w, h);
  rate = random(PI/8, PI/2);
  fromAbove = boolean(round(random(0,1)));
  start = new PVector(centerX + 10 * cos(random(-TWO_PI,TWO_PI)), centerX + 10 * sin(random(-TWO_PI,TWO_PI)), fromAbove ? 100 : -100);
  end = new PVector(centerX, centerX);
  
}
 
 color c = 0;
 
 color getRandomColor(){
    return color(360 * random(0.1,1.0) , 100, 100, 255); 
 }
 PVector start, end, middle;
 boolean underPoint(int x, int y){
    float scaler = 4.0;
    return abs(x - xx) < w*scaler && abs(y - yy) < h*scaler; 
 }
 
 void draw(float timeStep, PImage img, boolean useStroke, boolean go, boolean autoPlace){
     update(timeStep, autoPlace);
     noStroke();
     noFill();
     pushMatrix();
     middle = PVector.lerp(start, end, rotation/(TWO_PI) );

    // if(!selected || autoPlace){
       rotateX(-rotation);
       rotateZ(rotation);
       rotateY(-rotation);
     //}
     
     translate(centerX, centerY, 20 * rotation);
     
     //translate(middle.x, middle.y); //x, h\
     
     //translate(-middle.x, -middle.y);
     tint(360, rotation/(TWO_PI) * 360);
     
     image(piece, 0, 0);//piece
     if(useStroke)
       stroke(360, rotation/(TWO_PI) * 230 + 25);
     else
       noStroke();
     rect(0, 0, w, h);
     popMatrix();
 }
 
 float rotation = 0;
 float rate = PI/10;
 
 void update(float timeStep, boolean autoPlace){
  // timestep between 0 and 1
  //rotate PI at 1
  
  if(FLYMODE){
      //FLY MODE
      if(autoPlace && selected){
        rotation += rate;
        return;
      }
      else if(autoPlace){
        rotation += rate/50;
        return;
      }
      
      if(selected){
         rotation += autoPlace ? rate/50 : rate;
        if( rotation > TWO_PI)
         rotation = TWO_PI; 
      }
      else if(!run){
       rotation -= rate/100;
       if(rotation < -TWO_PI)
         rotation = -TWO_PI;
      }
  }else{
    if(selected){
         rotation += autoPlace ? rate/50 : rate;
        if( rotation > TWO_PI)
         rotation = TWO_PI; 
      }
      else if(!run){
       rotation -= rate/100;
       if(rotation < -TWO_PI)
         rotation = -TWO_PI;
      }
  }
 }
   
}
