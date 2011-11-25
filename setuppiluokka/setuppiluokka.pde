import processing.opengl.*;

/*import peasy.*;

PeasyCam cam;*/

Hakka hakka;

//hakassa olevien reikien lukumäärä:
final int REIKIA = 8;
//Yhden lankun paksuus
final int PAKSUUS = 12;
//Yhden reijän halkaisija 
final int HALKAISIJA = 12;
//TAHTIJUTTUJA
int tahtia=400;
final int SPREAD=64;
int CX,CY;
final float SPEED=1.9;

Star[] s = new Star[tahtia];

void setup() {
  size(800, 400, OPENGL);
  fill(112);
  hakka = new Hakka();
  
  //TAHTIJUTTUJA
    CX=width/2 ; CY=height/2;
 /// s = new Star[numstars];
  for(int i=0;i<tahtia;i++){
    s[i]=new Star();
    s[i].SetPosition();
  }
  
  // peasycam
  /*cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(200);
  cam.setMaximumDistance(500);*/
}

void draw() {
 
 /*       //TAHTIJUTTUJA
    for(int i=0;i<tahtia;i++){
    s[i].DrawStar();
  }*/
  
  // Change height of the camera with mouseY
/* camera(50.0, mouseY, 220.0, // eyeX, eyeY, eyeZ
         0.0, 0.0, 0.0, // centerX, centerY, centerZ
         0.0, 1.0, 0.0); // upX, upY, upZ 
         */
  camera(80.0, mouseY, 250.0, // eyeX, eyeY, eyeZ
         80.0, 0.0, 0.0, // centerX, centerY, centerZ
         0.0, 1.0, 0.0); // upX, upY, upZ
  
  //lights();
  ambientLight(200,100,200);
  directionalLight(51, 102, 126, 0, -1, 0);
  background(0);
  
  noStroke();
  
  hakka.piirra();
    
  stroke(0);
  line(-100, 0, 0, 100, 0, 0);
  line(0, -100, 0, 0, 100, 0);
  line(0, 0, -100, 0, 0, 100);
}

void keyPressed() {
  
 if(keyCode == UP) {
   hakka.hakanPainallus(true);
 }
 
 if(keyCode == DOWN) {
   hakka.hakanPainallus(false);
 }
}

/*
Hakka on H-kirjaimen muotoinen lasten lelu.
Mitat (edestä katsottuna):
x (leveys): 240 mm.
y (syvyys): 100 mm.
z (korkeus): 140mm.
MITTAKAAVA: 1 px = 1 mm.
*/
class Hakka {
  
  int valitunIndeksi;
  Lierio[] lieriot;
  
  public Hakka() {
    lieriot = new Lierio[REIKIA];
    for (int i = 0; i < REIKIA; i++){
      lieriot[i] = new Lierio();
      if(i == 0) {
        lieriot[i].asetaValittu(true);
        this.valitunIndeksi = i;
      }
    }
  }
  
  public void hakanPainallus(boolean a) {
   
   if(a) {
     if(this.valitunIndeksi != REIKIA) {
       this.valitunIndeksi++;
     }
     else {
      this.valitunIndeksi = 0; 
     }
   }
   else {
     if(this.valitunIndeksi != 0) {
       this.valitunIndeksi--;
     }
     else {
      this.valitunIndeksi = REIKIA; 
     }
   }
    
  }
  
  void piirra() {
    
    println(this.valitunIndeksi);
    
    for(int j = 0; j < REIKIA; j++) {
      if(j == this.valitunIndeksi) {
       lieriot[j].asetaValittu(true); 
      } else {
       lieriot[j].asetaValittu(false); 
      }
    }
    
/*Pituus: 24 cm
Leveys: 10 cm
Korkeus: 14 cm*/
  box(PAKSUUS, 80, 100);
  //tähän kai translate tai pushmatrix tms sirto
  pushMatrix();
  translate(150, 0, 0);
  box(PAKSUUS, 80, 100);
  translate(-75, 0, 0);
  box(140, 80, 10);
  popMatrix();
  //tähän kai translate takas tai popmatrix
  
  
  // piirretään tapit
  
  pushMatrix();
  rotateX(PI/2);
  translate(0, -20, -20);
  for(int i = 0; i < REIKIA; i++){
    Lierio tappi = lieriot[i];
    if (i % 4 == 0){
    translate(30*(i-(i-1)), 0, 0);
      }
    else if (i % 4 == 1) {
    translate(0, 0, 35*(i-(i-1)));
      }
     else if (i % 4 == 2){
     translate(30*(i-(i-1)), 0, 0);
     }
     else {
     translate(0, 0, -35*(i-(i-1)));
     }
     if(tappi.onkoValittu()) {
      fill(255); 
     }
     else {
       fill(100);
     }
    tappi.piirra(HALKAISIJA/2, 60, 100);
  }
    popMatrix();
  }
}
class Star { 
  float x=0,y=0,z=0,sx=0,sy=0;
  void SetPosition(){
    z=(float) random(300,255);
    x=(float) random(-1000,1000);
    y=(float) random(-1000,1000);
  }
  void DrawStar(){
    if (z<SPEED){
	this.SetPosition();
    }
    z-=SPEED;
    sx=(x*SPREAD)/(z)+CX;
    sy=(y*SPREAD)/(4+z)+CY;
    if (sx<0 | sx>width){
	this.SetPosition();
    }
    if (sy<0 | sy>height){
	this.SetPosition();
    }
    fill(color(255 - (int) z,255 - (int) z,255 - (int) z));
    ellipse( (int) sx,(int) sy,3,3);
  }
}
