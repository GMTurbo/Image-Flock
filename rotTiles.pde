
ArrayList<diamond> diamonds = new ArrayList<diamond>();
PImage img = null;

void setup(){
  size(640, 750, P3D);
  //frame.setResizable(true);  
  smooth();
  frameRate(30);
  colorMode(HSB, 360, 100, 100);
  initialize();
}

int offsetX = 0;
int offsetY = 0;

void initialize(){
  
  float size = 20;
  
  img = loadImage("http://25.media.tumblr.com/7b954d45849e9d63aaa14a1e3c8890e9/tumblr_mgvz71KVoD1r11fapo1_500.jpg");
   //
   //if(width != img.width || img.height != height)
   //    frame.setSize(img.width,img.height);
       
  //img.resize(width/2, height/2);

  float xWidth = img.width;
  float yHeight = img.height;
  float xStep = xWidth/size;
  float yStep = yHeight/size;
  
  offsetX = int( xStep/(2) * sqrt(2) );
  offsetY = int( yStep/(2) * sqrt(2) );
  
  for(float i = 0 ; i < xWidth ; i+= xStep)
   for(float j = 0 ; j < yHeight ; j+= yStep){
     diamonds.add(new diamond(i, j, ceil(xStep), ceil(yStep), img)); 
      //if(j == 0)
        //diamonds.add(new diamond(i * sqrt(2) - offsetX, j * sqrt(2) - offsetY, int(xStep), int(yStep), img));
      //diamonds.add(new diamond(i * sqrt(2), j * sqrt(2), int(xStep), int(yStep),img)); 
      //diamonds.add(new diamond(offsetX + i * sqrt(2),offsetY + j * sqrt(2), int(xStep), int(yStep),img)); 
   }
   
   /*
    offsetX = int( width/(2*size) * sqrt(2) );
  offsetY = int( height/(2*size) * sqrt(2) );
  for(int i = 0 ; i < width/size ; i++)
   for(int j = 0 ; j <height/size ; j++){
      if(j == 0)
        diamonds.add(new diamond(i * width/size * sqrt(2) - offsetX, j*height/size * sqrt(2) - offsetY, int(width/size), int(size)));
      diamonds.add(new diamond(i * width/size * sqrt(2), j * height/size * sqrt(2), int(width/size), int(height/size))); 
      diamonds.add(new diamond(offsetX + i * width/size * sqrt(2),offsetY + j * height/size * sqrt(2), int(width/size), int(height/size))); 
   }
   */
  
   
   //img.resize(width/2, height/2);
}

//float timeStep = 0;

boolean saveGif = false;
int gifFrame = 0;

boolean showStroke = false;
boolean run = true;
boolean auto = false;

void draw(){

  background(0);
  
  
  pushMatrix();
  
  translate(0,0,-450);
  for(diamond d : diamonds){
     d.draw(0, img, showStroke, run, auto); 
  }
  
  popMatrix();
  
  stroke(360);
  rect(mouseX, mouseY, 5, 5);
  if(keyCode == CONTROL && keyPressed){
    selectDiamondAt(mouseX, mouseY);
  }else{
    deSelectAll(); 
  }
  
  if(saveGif){
     saveFrame("gif" + (gifFrame++) + ".png");
  }
  
  if(frameCount % 20 == 0){
      println();
      println("run: " + !run);
      println("auto: " + auto);
      println("flymode: " + FLYMODE);
      println("showStroke: " + showStroke);
  }
    
}

void selectDiamondAt(int x, int y){
  
  for(diamond d : diamonds){
      //d.selected = false;
      d.selected = d.underPoint(x, y); 
      //if(d.selected)
      //  timeStep = 0;
  }
}

void deSelectAll(){
  for(diamond d : diamonds){
      d.selected = false;
  }
}
int screenshotCount = 0;
void keyPressed(){
   switch(key){
      case 's': // toggle stroke
      showStroke = !showStroke;
      break;
      case 'p':
      saveFrame("screenCap" + (screenshotCount++) + ".png");
      break;
      case 'r': // run
      run = !run;
      break;
      case 'a':
      auto = !auto;
      break;
      case 'f':
      FLYMODE = !FLYMODE;
      break;
      case 'c': // cecnter
      beginCamera();
       
      camera(width/2, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
          
      endCamera(); 
      break;
   } 
}

void mouseDragged(){
       beginCamera();
       
      camera(mouseX * 2, mouseY * 2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
          
       endCamera(); 
}

