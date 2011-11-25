import processing.opengl.*;

/*import peasy.*;

PeasyCam cam;*/

Hakka hakka;

//hakassa olevien reikien lukumäärä:
final int REIKIA = 8;
//Yhden lankun paksuus
final int PAKSUUS = 15;
//Yhden reijän halkaisija 
final int HALKAISIJA = 12;

void setup() {
  size(800, 400, OPENGL);
  fill(112);
  hakka = new Hakka();
  
  // peasycam
  /*cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(200);
  cam.setMaximumDistance(500);*/
}

void draw() {
  
  // Change height of the camera with mouseY
  camera(50.0, mouseY, 220.0, // eyeX, eyeY, eyeZ
         0.0, 0.0, 0.0, // centerX, centerY, centerZ
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

/*
Hakka on H-kirjaimen muotoinen lasten lelu.
Mitat (edestä katsottuna):
x (leveys): 240 mm.
y (syvyys): 100 mm.
z (korkeus): 140mm.
MITTAKAAVA: 1 px = 1 mm.
*/
class Hakka {
  
  Lierio[] lieriot;
  
  public Hakka() {
    lieriot = new Lierio[REIKIA];
    for (int i = 0; i < REIKIA; i++){
      lieriot[i] = new Lierio();
      if(i == 0) {
        lieriot[i].asetaValittu();
      }
    }
  }
  
  void piirra() {
/*Pituus: 24 cm
Leveys: 10 cm
Korkeus: 14 cm*/
  box(PAKSUUS, 140, 100);
  //tähän kai translate tai pushmatrix tms sirto
  pushMatrix();
  translate(100,0,0);
  box(PAKSUUS, 140, 100);
  /*for (int i = 0; i < REIKIA; i++){
    translate(0,10*i,0);
    box(10, 10, 20*i);
    println(i);
  }*/
  popMatrix();
  //tähän kai translate takas tai popmatrix
  
  
  // piirretään tapit
  
  pushMatrix();
  rotateX(PI/2);
  translate(0, -50, -20);
  for(int i = 0; i < REIKIA; i++){
    Lierio tappi = lieriot[i];
    if (i % 4 == 0){
    translate(20*(i-(i-1)), 0, 0);
      }
    else if (i % 4 == 1) {
    translate(0, 0, 40*(i-(i-1)));
      }
     else if (i % 4 == 2){
     translate(20*(i-(i-1)), 0, 0);
     }
     else {
     translate(0, 0, -40*(i-(i-1)));
     }
     if(tappi.onkoValittu()) {
      fill(255); 
     }
     else {
       fill(100);
     }
    tappi.piirra(HALKAISIJA/2, 100, 100);
  }
    popMatrix();
  }
}
