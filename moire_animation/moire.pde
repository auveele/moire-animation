import java.io.File;

class Moire {
  
  // CONFIGURACIÓN
  int column_width = 4;
  boolean show_lines = true;
  
  // Variable
  PImage[] image_list = new PImage[5];
  PGraphics merged_image;
  PGraphics lines_image;
  String base_name = "frame_";
  int image_count = 0;
  int column_count = 0;
  int image_x;
  int image_y;

  int actual_image = 0;
  int pixel_column = 0;
  int index = 0;

  Moire() {
    println("=====================");
    println("MOIRE ANIMATION v0.1");
    println("=====================");
    println();
    load_images_from_folder();
    set_windows_size();
    merge_images();
  }

  void setup() {
  }

  /*
    MERGE IMAGES
   */
  void merge_images() {
    // Cargamos píxeles de imágenes
    for (int k = 0; k < image_count; k++) {
      image_list[k].loadPixels();
    }
    merged_image.beginDraw();
    merged_image.loadPixels();
    // ITERAMOS COLUMNAS
    for (int i = 0; i < column_count; i++) {
      // Cargamos imagen de la columna
      actual_image = i % image_count;
      // ITERAMOS PIXELS DENTRO DE COLUMNA
      for (int j = 0; j < column_width; j++) {
        pixel_column = (i * column_width) + j;
        if (pixel_column >= image_x) break;
        // ITERAMOS COLUMNAS
        for (int k = 0; k < image_y; k++) {
          // Pillamos el píxel que toca
          merged_image.pixels[pixel_column + (k * image_x)] = image_list[actual_image].pixels[pixel_column + (k * image_x)];
        }
      }
    }
    merged_image.updatePixels();
    merged_image.endDraw();
  }

  /*
    LOAD IMAGES
   */
  void load_images_from_folder() {
    for (int i = 0; i <= image_list.length - 1; i++) {
      File f = new File(dataPath(base_name + i + ".jpg"));
      if (f.exists()) {

        image_list[image_count] = loadImage(base_name + i + ".jpg");
        image_count++;
        // println(base_name + i + ".jpg Existe");
      } else {
        // println(base_name + i + ".jpg NO existe");
      }
    }
    println("Se han cargado " + image_count + " imágenes.");
    image_x = image_list[0].width;
    image_y = image_list[0].height;
    column_count = image_x / column_width;
    if ((image_x % column_width) != 0) column_count++;
    println("Hay " + column_count + " columnas.");
  }
  /*
    AJUSTAMOS TAMAÑO VENTANA
   */
  void set_windows_size() {
    if (image_list[0] != null) {
      surface.setSize(image_x, image_y);

      merged_image= createGraphics(image_x, image_y);
      lines_image= createGraphics(image_x, image_y);
      /*
      merged_image.beginDraw();
       merged_image.background(0);
       merged_image.endDraw();
       */
    } else {
      println("NO RESIZE");
    }
  }


  /*
    CREATE LINES
   */
  void create_lines(int image_index) {
    // lines_image.clear();
    lines_image.beginDraw();
    lines_image.clear();
    lines_image.noStroke();
    lines_image.fill(0);
    for (int i = 0; i < column_count; i++) {
      actual_image = i % image_count;
      if (actual_image != image_index) {
        lines_image.rect(i * column_width, 0, column_width, image_y);
      }
    }
    lines_image.endDraw();
  }

  void update() {
    index = (index + 1) % image_count;
    create_lines(index);
  }

  void display() {
    image(merged_image, 0, 0);
    if (show_lines == true) image(lines_image, 0, 0);
  }
}
