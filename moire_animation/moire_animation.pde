
Moire m;
ControlFrame cf;

/*
  MAIN SETUP
 */
void setup() {
  // Instanciamos
  m = new Moire();
  // cf = new ControlFrame(this, 360, 720, "controlframe");
  frameRate(8);

  // Tamaño inicial
  size(953, 1000);
  surface.setTitle("Vista previa");
  
  surface.setLocation(600, 200);

}

/*
  MAIN DRAW
 */
void draw() {
  m.update();
  m.display();
}
