class Lierio {
  
  static final int MAX_POSITIO = (55/2)-5;
  static final int MIN_POSITIO = -((55/2)-4);
  
  int pituus;
  
  int positio;
  boolean onkoValittu;
  color vari;
  
  public Lierio(int pituus){
    
  this.positio = 0;
  this.pituus = pituus;
  this.onkoValittu = false;
  this.vari = annaVari();
  
  }
  
  public color annaVari () {
    switch(lierioitaLuotu) {
      case 1: return color(255,0,0);
      case 2: return color(255,255,0);
      case 3: return color(0,255,0);
      case 4: return color(0,255,255);
      case 5: return color(255,0,255);
      case 6: return color(0,0,255);
      case 7: return color(255,255,255);
      case 8: return color(0,0,0);
      default: return color(255,0,0);
    }
    
  }
  
  public void asetaValittu(boolean valinta) {
    this.onkoValittu = valinta;
  }
  
  public boolean onkoValittu() {
    if(this.onkoValittu) {
      return true;
    }
    else {
      return false;
    }
  }
  
   public int annaPositio(){
    return this.positio;
  }
  
  public boolean onPohjassa() {
    return(this.annaPositio() == (ylosalaisin? MAX_POSITIO : MIN_POSITIO));
  }
  
  // tapin voi lyoda pohjaan asti, ei syvemmalle
  public void muutaPositiota(int muutos){
      if (!this.onPohjassa()){
        this.positio = (ylosalaisin? this.positio + muutos : this.positio - muutos);
        if(positio < MIN_POSITIO) {
          positio = MIN_POSITIO;
        }
        else if(positio > MAX_POSITIO) {
          positio = MAX_POSITIO;
        }
      }
  }
  
  void piirra(float sade, int sarmienMaara) {

    // Itse tappien piirto:
  float kulma = 0;
  float kulmanLisays = TWO_PI / sarmienMaara;
  beginShape(QUAD_STRIP);
  texture(puu);
  tint(this.vari);
  textureMode(NORMALIZED);
  for (int i = 0; i < sarmienMaara + 1; ++i) {
    vertex(sade*cos(kulma), 0, sade*sin(kulma), kulma/TWO_PI, 0);
    vertex(sade*cos(kulma), pituus, sade*sin(kulma), kulma/TWO_PI, pituus);
    kulma += kulmanLisays;
  }
  endShape();
  
  // Tappien päätykiekkojen piirtäminen:
  if (sade != 0){
    piirraKiekko(sade, sarmienMaara, kulmanLisays);
    pushMatrix();
    translate(0,pituus,0);
    piirraKiekko(sade, sarmienMaara, kulmanLisays);
    popMatrix();
  }
}

  void piirraKiekko(float sade, int sarmienMaara, float kulmanLisays) {
    float kulma = 0;
    beginShape();
    texture(puu);
    textureMode(NORMALIZED);
    for (int i = 0; i < sarmienMaara; i++){
      float u = cos(kulma);
      float v = sin(kulma);
      vertex(sade * cos(kulma), 0, sade * sin(kulma), u,v);
      kulma += kulmanLisays;
    }
    endShape();
  }


}
