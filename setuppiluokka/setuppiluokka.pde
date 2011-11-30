import processing.opengl.*;

/*import peasy.*;

PeasyCam cam;*/

Hakka hakka;
int lujuus; //kuinka lujaa hakkaa lyodaan
boolean onkoPohjassa; // painetaanko valilyontia

//hakassa olevien reikien lukumäärä:
final int REIKIA = 8;
//Yhden lankun paksuus
final int PAKSUUS = 12;
//Yhden reijän halkaisija 
final int HALKAISIJA = 12;
//TAHTIJUTTUJA
int tahtia=400;
final int SPREAD=94;
int CX,CY;
final float SPEED=1.9;

Star[] s = new Star[tahtia];

void setup() {
  size(800, 400, OPENGL);
  fill(112);
  hakka = new Hakka();
  lujuus = 0;
  onkoPohjassa = false;
  
  //TAHTIJUTTUJA
    CX=width/2 ; CY=height/2;
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

  // Change height of the camera with mouseY


  camera(80.0, mouseY, 150.0, // eyeX, eyeY, eyeZ
         80.0, 0.0, 0.0, // centerX, centerY, centerZ
         0.0, 1.0, 0.0); // upX, upY, upZ
  
  //lights();
  ambientLight(200,100,200);
  directionalLight(51, 102, 126, 0, -1, 0);
  background(0);
  
  noStroke();
  fill(112);
  hakka.piirra();
    
  stroke(0);
  line(-100, 0, 0, 100, 0, 0);
  line(0, -100, 0, 0, 100, 0);
  line(0, 0, -100, 0, 0, 100);
  
            //TAHTIJUTTUJA
  for(int i=0;i<tahtia;i++) {
    s[i].DrawStar();
  }
  
}

void keyPressed() {
  
 if(keyCode == UP && !onkoPohjassa) {
   hakka.hakanPainallus(true);
 }
 
 if(keyCode == DOWN && !onkoPohjassa) {
   hakka.hakanPainallus(false);
 }
 
 if(key == ' ') {
   lujuus+=5;
   onkoPohjassa = true;
 }
}

void keyReleased() {
  
  if(key == ' ') {
    Lierio valittu = hakka.annaValittuTappi();
    int muutos = (int) (255/50);
    if (valittu != null){
    valittu.muutaPositiota(muutos);
    println(valittu.annaPositio());
    }
    println(lujuus);
    lujuus = 0;
    onkoPohjassa = false;
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
  
  public Lierio annaValittuTappi(){
     for (int a = 0; a < REIKIA; a++){
       Lierio lierio = lieriot[a];
       if (lierio.onkoValittu()){
         return lierio;
       }
     }
     return null;
  }
  
  void piirra() {
    
    //println(this.valitunIndeksi);
    
    for(int j = 0; j < REIKIA; j++) {
      if(j == this.valitunIndeksi) {
       lieriot[j].asetaValittu(true); 
      } else {
       lieriot[j].asetaValittu(false); 
      }
    }
    
    fill(112);
    
  box(PAKSUUS, 80, 100);
  //tähän kai translate tai pushmatrix tms sirto
  pushMatrix();
  translate(150, 0, 0);
  box(PAKSUUS, 80, 100);
  translate(-75, 0, 0);
  box(140, 80, 10);
  popMatrix();
    
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
      //fill(255);
      if(lujuus <= 255) {
       fill(lujuus, 0, 0); 
      } else {
       fill(255, 10, 10); 
      }
     }
     else {
       fill(112);
     }
    translate(0, tappi.annaPositio(), 0);
    tappi.piirra(HALKAISIJA/2, 60, 100);
    translate(0, -tappi.annaPositio(), 0);
    pushMatrix();
    rotateX(PI/2);
    translate(0, 0, -tappi.annaPositio());
    ellipse(0, 0,HALKAISIJA, HALKAISIJA);
    translate(0,0,-60);
    ellipse(0, 0, HALKAISIJA, HALKAISIJA);
    translate(0, 0, 60);
    translate(0, 0, tappi.annaPositio());
    rotateX(-PI/2);
    popMatrix();
    
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
    pushMatrix();
    translate(-500,-250, -250);
    if (z<SPEED){
	this.SetPosition();
    }
    z-=SPEED;
    sx=(x*SPREAD)/(z)+CX;
    sy=(y*SPREAD)/(4+z)+CY;
    if (sx<0 | sx>width*2){
	this.SetPosition();
    }
    if (sy<-1000 | sy>height * 1.5){
	this.SetPosition();
    }
    fill(color(255 - (int) z,255 - (int) z,255 - (int) z));
    ellipse( (int) sx,(int) sy,5,5);
    popMatrix();
  }
}
