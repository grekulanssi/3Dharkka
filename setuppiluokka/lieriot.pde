class Lierio {
  
  int positio;
  boolean onkoValittu;
  
  public Lierio(){
    
  this.positio = 0;
  this.onkoValittu = false;
  
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

  float kulma = 0;
  float kulmanLisays = TWO_PI / sarmienMaara;
  beginShape(QUAD_STRIP);
  texture(puu);
  tint(0, 153, 204);
  for (int i = 0; i < sarmienMaara + 1; ++i) {
    vertex(sade*cos(kulma), 0, sade*sin(kulma));
    vertex(sade*cos(kulma), pituus, sade*sin(kulma));
    kulma += kulmanLisays;
  }
  endShape();
  
  if (sade != 0){
  kulma = 0;
  beginShape(TRIANGLE_FAN);
  texture(puu);
  vertex(0, 0, 0);
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
