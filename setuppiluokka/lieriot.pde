class Lierio {
  
  int osumat;
  
  public Lierio(){
  this.osumat = 0;
  
  }
  
  void piirra(float sade, float pituus, int sarmienMaara) {
    //miten lierio piirretään, Oliver?
  float kulma = 0;
  float kulmanLisays = TWO_PI / sarmienMaara;
  beginShape(QUAD_STRIP);
  for (int i = 0; i < sarmienMaara + 1; ++i) {
    vertex(sade*cos(kulma), 0, sade*sin(kulma));
    vertex(sade*cos(kulma), pituus, sade*sin(kulma));
    kulma += kulmanLisays;
  }
  endShape();
  
  if (sade != 0){
  kulma = 0;
  beginShape(TRIANGLE_FAN);
  
  vertex(0, 0, 0);
  for (int i = 0; i < sarmienMaara; i++){
    vertex(sade * cos(kulma), 0, sade * sin(kulma));
    kulma += kulmanLisays;
  }
  vertex(0, pituus, 0);
  for (int i = 0; i < sarmienMaara + 1; i++){
    vertex(sade * cos(kulma), pituus, sade * sin(kulma));
    kulma += kulmanLisays;
  }
  endShape();
  }
}
}
