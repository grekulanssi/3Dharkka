class Lierio {
  
  int positio;
  boolean onkoValittu;
  color vari;
  
  public Lierio(){
    
  this.positio = 0;
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
  
  public void asetaValittu(boolean a) {
    this.onkoValittu = a;
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
  
  // tapin voi lyoda pohjaan asti, ei syvemmalle
  public void muutaPositiota(int muutos){
    if (positio <= 30 && positio >= -30){
    this.positio -= muutos;
    }
  }
  
  void piirra(float sade, float pituus, int sarmienMaara) {

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
    kulma = 0;
    beginShape(TRIANGLE_FAN);
    texture(puu);
    //tint(255);
    textureMode(NORMALIZED);
    vertex(0, 0, 0, 0.5,0.5);
    for (int i = 0; i < sarmienMaara; i++){
      vertex(sade * cos(kulma), 0, sade * sin(kulma));
      kulma += kulmanLisays;
    }
    vertex(0, pituus, 0);
    for (int i = 0; i <= sarmienMaara; i++){
      vertex(sade * cos(kulma), pituus, sade * sin(kulma));
      kulma += kulmanLisays;
    }
  endShape();
  }
}
}
