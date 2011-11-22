import processing.opengl.*;

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
}

void draw() {
  lights();
  background(240);
  
  // Change height of the camera with mouseY
  camera(30.0, mouseY, 220.0, // eyeX, eyeY, eyeZ
         0.0, 0.0, 0.0, // centerX, centerY, centerZ
         0.0, 1.0, 0.0); // upX, upY, upZ
  
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
    
  }
  
  void piirra() {
      /*Pituus: 24 cm
Leveys: 10 cm
Korkeus: 14 cm*/
  box(PAKSUUS, 140, 100);
  //tähän kai translate tai pushmatrix tms sirto
  box(PAKSUUS, 140, 100);
  //tähän kai translate takas tai popmatrix
  }
  
}
