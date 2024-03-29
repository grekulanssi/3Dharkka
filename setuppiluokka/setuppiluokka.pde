import processing.opengl.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput lineIn;
FFT fft;

Aani aani;
Hakka hakka;
int lujuus; //kuinka lujaa hakkaa lyodaan

boolean aloitusnaytto;

boolean onkoPohjassa; // painetaanko valilyontia
boolean ylosalaisin; // onko hakka ylosalaisin suhteessa alkup. asentoon

// Apumuuttujia piirtoa ja pelin kulkua varten
int onHakattuPohjaan;
int hakkaaKaannetty;
boolean kaantoKaynnissa;
int kaanto;
final int KAANNON_NOPEUS = 100;

boolean nostoKaynnissa;
int dz;
boolean laskuKaynnissa;
boolean nostettu; // apuna hakan nostamisessa lopussa
int nostoluku; // apuna hakan nostamisessa lopussa
boolean voitettu; // kytkimiä
boolean rajahdetty;

//hakassa olevien reikien lukumäärä:
final int REIKIA = 8;
//Yhden lankun paksuus
final int PAKSUUS = 12;
//Yhden reijän halkaisija 
final int HALKAISIJA = 12;

int lierioitaLuotu;
int klikattu; // maarittaa sen pyoritetaanko hakkaa vai ei


PImage aloitus;

PImage puu;
PImage lattia;
PImage katto;

PImage[] walls;

void setup() {
  
  size(800, 600, OPENGL);
  fill(112);
  
  aloitus = loadImage("aloitus.png");
  
  minim = new Minim(this);
  aani = new Aani();
  if (aani == null){
    println("aani on null jo setupissa");
  }
  if (aani != null){
    println("aani ei oo null setupissa");
  }
  
  hakka = new Hakka();
  
  aloitusnaytto = true;
  
  aani.intronauha();
  lujuus = 10;
  onkoPohjassa = false;
  onHakattuPohjaan = 0;
  hakkaaKaannetty = 0;
  nostettu = false;
  nostoluku = 0;
  voitettu = false;
  
  lierioitaLuotu = 0;
  klikattu = 0;
  
  puu = loadImage("wood.png");
  lattia = loadImage("lattia.png");
  katto = loadImage("eye.jpg");
  
  walls = new PImage[4];
  
  walls[0] = loadImage("anssi.jpg");
  walls[1] = loadImage("artti.jpg");
  walls[2] = loadImage("tiina.jpg");
  walls[3] = loadImage("oliver.jpg");
  
}


void draw() {
  //Aloitusnayton piirtaminen
  if(aloitusnaytto) {
   image(aloitus,0,0);
   return; 
  }

  // Kameran korkeutta voi muuttaa liikuttamalla hiirta
  camera(0.0, mouseY-60, 150.0, // eyeX, eyeY, eyeZ
         0.0, 0.0, 0.0,//50.0, // centerX, centerY, centerZ
         0.0, 1.0, 0.0); // upX, upY, upZ
     
  rotateZ(frameCount / 500.0);

  ambientLight(200,200,200);

  directionalLight(110, 110, 110, 0.5, -0.5, 0);
  directionalLight(110, 110, 110, -0.5, 0.5, 0);
  directionalLight(80,80,80, 0,0,1);
  
  directionalLight(150,150,150, 0,0,-1);

 background(0);
  
  noStroke();

  fill(200);
  //LATTIA
  beginShape();
  texture(lattia);
  textureMode(NORMALIZED);
  vertex(-500,-500,-50, 0,0);
  vertex(-500, 500,-50, 0,1);
  vertex(500, 500,-50, 1,1);
  vertex(500,-500,-50, 1,0);
  endShape();
  
  //SEINAT
  //for(int s = 0; s < 4, s++) {
    beginShape();
 //   texture(walls[s]);
    texture(walls[0]);
    textureMode(NORMALIZED);
    vertex(-500,-500,-50, 0,1);
    vertex(-500,-500,615, 0,0);
    vertex(-500,500,615, 1,0);
    vertex(-500,500,-50, 1,1);
   endShape();
  //}
  beginShape();
    texture(walls[1]);
    textureMode(NORMALIZED);
    vertex(500,-500,-50, 0,1);
    vertex(500,-500,615, 0,0);
    vertex(500,500,615, 1,0);
    vertex(500,500,-50, 1,1);
  endShape();
  
  beginShape();
    texture(walls[2]);
    textureMode(NORMALIZED);
    vertex(-500,-500,-50, 0,1);
    vertex(-500,-500,615, 0,0);
    vertex(500,-500,615, 1,0);
    vertex(500,-500,-50, 1,1);
  endShape();  

  beginShape();
    texture(walls[3]);
    textureMode(NORMALIZED);
    vertex(-500,500,-50, 0,1);
    vertex(-500,500,615, 0,0);
    vertex(500,500,615, 1,0);
    vertex(500,500,-50, 1,1);
  endShape();
  
  //KATTO
  beginShape();
    textureMode(NORMALIZED);
    texture(katto);
    vertex(-500,-500,615, 0,0);
    vertex(-500,500,615, 0,1);
    vertex(500,500,615, 1,1);
    vertex(500,-500,615, 1,0);
  endShape();
  
  // jos voittoehdot ovat täyttyneet
  if (voitettu) {
    // jos hakkaa ei ole vielä nostettu
    if (!nostettu) {
    pushMatrix();
    translate(0,0,nostoluku*2); // nostetaan hakkaa
    hakka.piirra();
    popMatrix();
    nostoluku++;
     }
     // kun hakka on tarpeeksi korkealla, räjähdetään
    if (nostoluku > 210) {
      if (!rajahdetty){
      nostettu = true;
      rajahda();
        }
      rajahdetty = true;
      }
   }
   
  else if(nostoKaynnissa) {
    dz++;
    pushMatrix();
      translate(0,0,dz);
      hakka.piirra();
    popMatrix();
      if(abs(dz) >= 20) {
      nostoKaynnissa = false;
      laskuKaynnissa = true;
    }
  }
  else if(kaantoKaynnissa) {  
    kaanto ++;
    pushMatrix();
      translate(0,0,20);
      rotateX((PI/KAANNON_NOPEUS)*kaanto);
      hakka.piirra();
    popMatrix();
    if(kaanto >= KAANNON_NOPEUS) {
      kaantoKaynnissa = false;  
      if(ylosalaisin) {
        ylosalaisin = false;
      }
      else ylosalaisin = true;
      kaanto = 0;
      laskuKaynnissa = true;
    }
  }
  else if(laskuKaynnissa) {
    dz--;
    pushMatrix();
      translate(0,0,dz);
      hakka.piirra();
    popMatrix();
    println(ylosalaisin);
    if(abs(dz) == 0) {
      laskuKaynnissa = false;
    }
  }
  else {
    hakka.piirra();
  }
    
  stroke(color(255,0,0));
  line(-300, 0, 0, 300, 0, 0);
  stroke(color(0,255,0));
  line(0, -300, 0, 0, 300, 0);
  stroke(color(0,0,255));
  line(0, 0, -300, 0, 0, 300);
  
  stroke(0);
  
  
}

void aloita() {
  aloitusnaytto = false;
  aani.nauru();
}

void mouseClicked() {
 if(aloitusnaytto) {
   if(340 < mouseX && mouseX < 460 && 435 < mouseY && mouseY < 595) {
     aloita();
   }
 } 
}

void keyPressed() {
 // vaihdetaan valittua hakkaa hakanPainallus()-metodin avulla
 // riippuen siita painaako nuolta ylos- vai alaspain
 
 // tarkistetaan aina aluksi, onko jo voitettu
 voitto();
 if(!voitettu){
 
 if(keyCode == UP && !onkoPohjassa) {
   hakka.hakanPainallus(true);
 }
 
 if(keyCode == DOWN && !onkoPohjassa) {
   hakka.hakanPainallus(false);
 }
 // jos kääntö on käynnissä, ei toimita
 if(kaantoKaynnissa) return;
 // a:n painaminen kääntää hakan ympäri
 if(key == 'a') {
   if(aloitusnaytto) {
     aloita();
     return;
   }
  kaannaHakkaYmpari();
  aani.nauru();
 
 }
 
 // valilyonnin painaminen muuttaa hakan lyonnin lujuutta
 if(key == ' ') {
   if (lujuus < 400){
   lujuus+=10;
   }
   onkoPohjassa = true;
   }
  }
 }

void keyReleased() {
  if(kaantoKaynnissa) return;

  // kun valilyonnista paastetaan irti muutetaan hakan sijaintia lyonnin lujuuden suhteen
  if(key == ' ') {
    Lierio valittu = hakka.annaValittuTappi();
    int muutos = (int) (lujuus/8);
    if (muutos < 1){
      muutos = 1;
  }
  // muutetaan valitun tapin paikkaa alaspäin
    if (valittu != null){
      valittu.muutaPositiota(muutos);
      if (muutos > 38){
      aani.hakkaus();
      }
      // kun kaikki tapit on pohjassa, käännetään hakka
      if(hakka.kaikkiPohjassa()) {
        kaannaHakkaYmpari();
        aani.nauru();
        onHakattuPohjaan++;
      }
    }
    lujuus = 10;
    onkoPohjassa = false;
  }
  
}

void kaannaHakkaYmpari() {
    hakkaaKaannetty++;
    kaantoKaynnissa = true;
    nostoKaynnissa = true;
  }
  
  public void voitto(){
    // peli voitetaan, kun hakka on kääntynyt yli kaksi kertaa
    // ja tapit on hakattu pohjaan yli kaksi kertaa
   if (hakkaaKaannetty > 2 && onHakattuPohjaan > 2){
     
   voitettu = true;
   }
 }
 
 public void rajahda(){
   aani.rajahdys();
   
 }
