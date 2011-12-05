/*
Äänien soittamisesta huolehtiva luokka.
*/

class Aani {
  
  int viimeksiammuttu = 0;
  int viive = 0;
  
  AudioPlayer djIntro;

  AudioSnippet nauru;
  AudioSnippet rajahdys;
  AudioSnippet hakkaus;

  public Aani() {
    println("3MINIM ON " + minim);
    //minim.debugOn();
  
    djIntro = minim.loadFile("alkuloop.mp3");
    
    nauru = minim.loadSnippet("nauru.wav");
    rajahdys = minim.loadSnippet("bomb.wav");
    hakkaus = minim.loadSnippet("hakkaus.mp3");
  }
  
  public void intronauha() {
    if(djIntro.isPlaying()) {
      return;
    }
    djIntro.loop();
  }
  
  public void rajahdys() {
    rajahdys.rewind();
    rajahdys.play();
  }
  
  public void nauru() {
    nauru.rewind();
    nauru.play();
  }
  
  public void hakkaus(){
    hakkaus.rewind();
    hakkaus.play();
  }
  
  int annaViive() {
    return viive;
  }
  
  private void asetaViive(int v) {
    viive = v;
  }
  
  // otetaan huomioon vain riittävän kovat äänet.
 
  
  void stop() {
    djIntro.close();
    
    nauru.close();
    rajahdys.close();
  }
}
