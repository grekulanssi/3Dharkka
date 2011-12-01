import processing.opengl.*;

/*import peasy.*;

PeasyCam cam;*/

Hakka hakka;
int lujuus; //kuinka lujaa hakkaa lyodaan
boolean onkoPohjassa; // painetaanko valilyontia
boolean ylosalaisin; // onko hakka ylosalaisin suhteessa alkup. asentoon

//hakassa olevien reikien lukumäärä:
final int REIKIA = 8;
//Yhden lankun paksuus
final int PAKSUUS = 12;
//Yhden reijän halkaisija 
final int HALKAISIJA = 12;

int lierioitaLuotu;

//TAHTIJUTTUJA
int tahtia=400;
final int SPREAD=94;
int CX,CY;
final float SPEED=1.9;

Star[] s = new Star[tahtia];

PImage puu;

void setup() {
  size(800, 400, OPENGL);
  fill(112);
  hakka = new Hakka();
  lujuus = 0;
  onkoPohjassa = false;
  
  lierioitaLuotu = 0;
  
  puu = loadImage("wood.png");
  
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
  ambientLight(200,200,200);
  directionalLight(110, 110, 110, 0.5, -0.5, 0);
  
  background(0);
  
  noStroke();

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

