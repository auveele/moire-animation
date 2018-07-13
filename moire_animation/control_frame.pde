/*
  
 Ventana de control
 
 */

import controlP5.*;

public class ControlFrame extends PApplet {
  // Atributos
  int pxls_column = 30;
  int w, h;
  PApplet parent;
  ControlP5 cp5;

  // Variables
  boolean setup = false;
  String[] file_path;  // Nombre de la imagen que cargas
  String file_name;

  public ControlFrame(PApplet _parent, int _w, int _h, String _name) {
    super();   
    parent = _parent;
    w=_w;
    h=_h;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(w, h);
  }

  public void setup() {
    surface.setLocation(200, 200);
    surface.setTitle("Triangulator v0.1");
    cp5 = new ControlP5(this);

    /*
    FIN SETUP
     */
    setup = true;
  }

  /*
    CARGAMOS IMAGEN
   */
  void load_image() {
    selectInput("Select an image", "imageChosen");
  }
  // COMPROBAMOS IMAGEN CARGADA
  void imageChosen( File f ) {
    if ( f.exists() ) {
      // Pillamos el nombre del fichero de la ruta absoluta
      file_path = splitTokens(f.getAbsolutePath(), System.getProperty("file.separator"));
      file_name = file_path[file_path.length - 1];
      // Pasamosla imagen al triangulator
    } else {
      // No existe
      println("Window was closed or user canceled");
      exit();
    }
  }

  /*
    UPDATE IN LOOP
   */
  void update() {
  }

  /*
    UTILIDAD COLUMNAS
   */
  int get_pixel_from_column(int column, int offset) {
    return (column * pxls_column) + offset;
  }

  /*
    DRAW CONTROL
   */
  void draw() {
    background(255);
  }
}
