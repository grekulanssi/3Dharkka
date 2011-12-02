import processing.opengl.*;

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
int klikattu; // maarittaa sen pyoritetaanko hakkaa vai ei

//TAHTIJUTTUJA
int tahtia = 400;
final int SPREAD = 200;
int CX, CY;
final float SPEED = 1.9;

Star[] s = new Star[tahtia];

PImage puu;
PImage lattia;

void setup() {
  
  size(800, 400, OPENGL);
  fill(112);
  hakka = new Hakka();
  lujuus = 10;
  onkoPohjassa = false;
  
  lierioitaLuotu = 0;
  klikattu = 0;
  
  puu = loadImage("wood.png");
  lattia = loadImage("lattia.png");
  
  //TAHTIJUTTUJA
  CX = width/2;
  CY = height/2;
    
  for (int i = 0; i < tahtia; i++) {
    s[i] = new Star();
    s[i].SetPosition();
  }
  
}


void draw() {

  // Change height of the camera with mouseY
  camera(0.0, 200.0 + mouseY, 150.0, // eyeX, eyeY, eyeZ
         0.0, 0.0, 0.0, // centerX, centerY, centerZ
         0.0, 1.0, 0.0); // upX, upY, upZ
     
  rotateZ(frameCount / 100.0);

  ambientLight(200,200,200);

  directionalLight(110, 110, 110, 0.5, -0.5, 0);
  directionalLight(110, 110, 110, -0.5, 0.5, 0);
  directionalLight(110, 110, 110, 0, 0, 1);

 background(0);
  
  noStroke();

  fill(200);
  beginShape();
  texture(lattia);
  textureMode(NORMALIZED);
  vertex(-500,-500,-50, 0,0);
  vertex(-500, 500,-50, 0,1);
  vertex(500, 500,-50, 1,1);
  vertex(500,-500,-50, 1,0);
  endShape();

  hakka.piirra();
    
  stroke(color(255,0,0));
  line(-300, 0, 0, 300, 0, 0);
  stroke(color(0,255,0));
  line(0, -300, 0, 0, 300, 0);
  stroke(color(0,0,255));
  line(0, 0, -300, 0, 0, 300);
  
  stroke(0);
  
  // TAHTIJUTTUJA
 /* for (int i=0;i<tahtia;i++) {
    s[i].DrawStar();
  }*/
  
}

void keyPressed() {
 
 // vaihdetaan valittua hakkaa hakanPainallus()-metodin avulla
 // riippuen siita painaako nuolta ylos- vai alaspain
 if(keyCode == UP && !onkoPohjassa) {
   hakka.hakanPainallus(true);
 }
 
 if(keyCode == DOWN && !onkoPohjassa) {
   hakka.hakanPainallus(false);
 }
 
 if(key == 'a') {
  hakka.kaannaYlosalaisin(); 
 }
 
 // valilyonnin painaminen muuttaa hakan lyonnin lujuutta
 if(key == ' ') {
   if (lujuus < 330){
   lujuus+=10;
   }
   onkoPohjassa = true;
 }
}

void keyReleased() {
  
  // kun valilyonnista paastetaan irti muutetaan hakan sijaintia lyonnin lujuuden suhteen
  if(key == ' ') {
    Lierio valittu = hakka.annaValittuTappi();
    int muutos = (int) (lujuus/9);
    if (muutos < 1){
      muutos = 1;
  }
    if (valittu != null){
      valittu.muutaPositiota(muutos);
      if(hakka.kaikkiPohjassa()) {
        hakka.kaannaYlosalaisin();
        println("KAIKKI DOWN");
      }
    }
    println(lujuus);
    lujuus = 10;
    onkoPohjassa = false;
  }
  
}
