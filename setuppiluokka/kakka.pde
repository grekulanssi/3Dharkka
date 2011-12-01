/*
Hakka on H-kirjaimen muotoinen lasten lelu.
Mitat (edestä katsottuna):
x (leveys): 240 mm.
y (syvyys): 100 mm.
z (korkeus): 140mm.
MITTAKAAVA: 1 px = 1 mm.
*/
class Hakka {
  
  color puunvari = color(165,83,0);
  
  int valitunIndeksi;
  Lierio[] lieriot;
  
  public Hakka() {
    lieriot = new Lierio[REIKIA];
    for (int i = 0; i < REIKIA; i++){
      lieriot[i] = new Lierio();
      lierioitaLuotu ++;
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
    
    fill(puunvari);
    //println(this.valitunIndeksi);
    
    for(int j = 0; j < REIKIA; j++) {
      if(j == this.valitunIndeksi) {
       lieriot[j].asetaValittu(true); 
      } else {
       lieriot[j].asetaValittu(false); 
      }
    }
    
    
  box(PAKSUUS, 80, 100);
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

