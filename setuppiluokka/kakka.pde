/*
Hakka on H-kirjaimen muotoinen lasten lelu.
*/
class Hakka {
  
  final int TAPIN_PITUUS = 60;
  int kaantokello;
  boolean kaantoKaynnissa;
  color puunvari = color(165,83,0);
  
  int valitunIndeksi;
  Lierio[] lieriot;
  
  public Hakka() {
    lieriot = new Lierio[REIKIA];
    for (int i = 0; i < REIKIA; i++){
      lieriot[i] = new Lierio(TAPIN_PITUUS);
      lierioitaLuotu ++;
      if(i == 0) {
        lieriot[i].asetaValittu(true);
        this.valitunIndeksi = i;
      }
    }
  }
  
  public void hakanPainallus(boolean suunta) {
    // tassa metodissa muutetaan valitun hakan indeksia
   if(suunta) {
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
    
    if(kaikkiPohjassa()) {
      
      /*if(kaantoKaynnissa) {
        int kulunutAikaMs = millis() - kaantokello;
        rotateX(kulunutAikaMs/1000);
        if(kulunutAikaMs/1000 >= PI) {
          kaantoKaynnissa = false;
          kaantokello = 0;
        }
      }*/
    }
    
    fill(puunvari);
    //println(this.valitunIndeksi);
    
    for(int j = 0; j < REIKIA; j++) {
      if(j == this.valitunIndeksi) {
       lieriot[j].asetaValittu(true); 
      } else {
       lieriot[j].asetaValittu(false); 
      }
    }
    
  fill(255,0,0);

  pushMatrix();
    translate(-75,0,0);
    piirraLaita();
    
    translate(150, 0, 0);
    piirraLaita();
  
    translate(-75, 0, 0);
    fill(puunvari);
    piirraLevy();
  popMatrix();
    
  // piirretään tapit
  
  pushMatrix();
  rotateX(PI/2);
  translate(-75, -20, -20);
  
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
      if(lujuus <= 255) {
       fill(lujuus, 0, 0); 
      } else {
       fill(255,255,255); 
      }
     }
     else {
      fill(puunvari);
     }
    translate(0, tappi.annaPositio(), 0);
    tappi.piirra(HALKAISIJA/2, 100);
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
  
  // piirtää laitapalikan vertekseillä
  void piirraLaita() {
    //ylä- ja alareunat (päädyt)
  beginShape();
  texture(puu);
  textureMode(NORMALIZED);
    vertex(-PAKSUUS/2, -40, -50, 0.4,0.6);
    vertex(PAKSUUS/2, -40, -50, 0.6,0.4);
    vertex(PAKSUUS/2, 40, -50, 0.6,0.6);
    vertex(-PAKSUUS/2, 40, -50, 0.4,0.4);
  endShape();
  beginShape();
  texture(puu);
    vertex(-PAKSUUS/2, 40, 50, 0.4,0.4);
    vertex(PAKSUUS/2, 40, 50, 0.4,0.6);
    vertex(PAKSUUS/2, -40, 50, 0.6,0.6);
    vertex(-PAKSUUS/2, -40, 50, 0.6,0.4);
  endShape();
    //pitkät sivut, reunat
  beginShape();
  texture(puu);
    vertex(-PAKSUUS/2, 40, 50, 0.4,0);
    vertex(PAKSUUS/2, 40, 50, 0.6,0);
    vertex(PAKSUUS/2, 40, -50, 0.6,1);
    vertex(-PAKSUUS/2, 40, -50, 0.4,1);
  endShape();
  beginShape();
  texture(puu);
    vertex(-PAKSUUS/2, -40, -50, 0.4,0);
    vertex(PAKSUUS/2, -40, -50, 0.6,0);
    vertex(PAKSUUS/2, -40, 50, 0.6,1);
    vertex(-PAKSUUS/2, -40, 50, 0.4,1);
  endShape();
    //sisä- ja ulkolaidat
  beginShape();
  texture(puu);
    vertex(PAKSUUS/2, -40, 50, 0,0);
    vertex(PAKSUUS/2, 40, 50, 1,0);
    vertex(PAKSUUS/2, 40, -50, 1,1);
    vertex(PAKSUUS/2, -40, -50, 0,1);
  endShape();
  beginShape();
  texture(puu);
    vertex(-PAKSUUS/2, -40, -50, 0,0);
    vertex(-PAKSUUS/2, 40, -50, 1,0);
    vertex(-PAKSUUS/2, 40, 50, 1,1);
    vertex(-PAKSUUS/2, -40, 50, 0,1);
  endShape();
  }
  
  // piirtää keskilevyn verteksinä
  void piirraLevy() {
  beginShape();
  texture(puu);
  textureMode(NORMALIZED);
    vertex(-70, -40, -5, 0,0);
    vertex(70, -40, -5, 1,0);
    vertex(70, 40, -5, 1,1);
    vertex(-70, 40, -5, 0,1);
  endShape();
  beginShape();
  texture(puu); 
    vertex(-70, 40, 5, 0,1);
    vertex(70, 40, 5, 1,1);
    vertex(70, -40, 5, 1,0);
    vertex(-70, -40, 5, 0,0);
  endShape();
  
  beginShape();
  texture(puu);
    vertex(-70, 40, 5, 0,0.6);
    vertex(70, 40, 5, 1,0.6);
    vertex(70, 40, -5, 1,0.4);
    vertex(-70, 40, -5, 0,0.4);
  endShape();
  beginShape();
  texture(puu);
    vertex(-70, -40, -5, 0,0.4);
    vertex(70, -40, -5, 1,0.4);
    vertex(70, -40, 5, 1,0.6);
    vertex(-70, -40, 5, 0,0.6);
  endShape();
  
  beginShape();
    vertex(70, -40, 5);
    vertex(70, 40, 5);
    vertex(70, 40, -5);
    vertex(70, -40, -5);
  endShape();
  beginShape();
    vertex(-70, -40, -5);
    vertex(-70, 40, -5);
    vertex(-70, 40, 5);
    vertex(-70, -40, 5);
  endShape();
  }
  
  /*kertoo, onko kaikki tapit hakattu pohjaan saakka
    jotta hakka voitaisiin kääntää ympäri */
  boolean kaikkiPohjassa() {
    for(int t = 0; t < REIKIA; t++) {
      if(!lieriot[t].onPohjassa()) {
        return false;
      }
    }
    if(!kaantoKaynnissa) kaannaYlosalaisin();
    return true;
  }
  
  void kaannaYlosalaisin() {
    kaantoKaynnissa = true;
    kaantokello = millis();
    if(ylosalaisin) {
      ylosalaisin = false;
    }
    else ylosalaisin = true;
    println(ylosalaisin);
  }
}


