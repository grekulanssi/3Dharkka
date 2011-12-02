class Star { 
  float x=0,y=0,z=0,sx=0,sy=0;
  void SetPosition(){
    z=(float) random(300,255);
    x=(float) random(-2000,2000);
    y=(float) random(-2000,2000);
  }
  void DrawStar(){
    pushMatrix();
    translate(-500,-250, -250);
    if (z<SPEED){
	this.SetPosition();
    }
    z-=SPEED;
    sx=(x*SPREAD)/(z)+CX;
    sy=(y*SPREAD)/(4+z)+CY;
    if (sx<0 | sx>width*2){
	this.SetPosition();
    }
    if (sy<-2000 | sy>height * 1.5){
	this.SetPosition();
    }
    fill(color(255 - (int) z,255 - (int) z,255 - (int) z));
    ellipse( (int) sx,(int) sy,5,5);
    popMatrix();
  }
}
