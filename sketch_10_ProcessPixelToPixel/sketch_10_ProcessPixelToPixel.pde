/*
  PROCESAMIENTO DE IMAGENES PIXEL A PIXEL
  Autor: Jaime Andrés Cruz Romero
  Fecha: 20200315
*/
import controlP5.*;
ControlP5 cp5;

PImage img01;
PImage img02;
int topMargin = 60;
int margin = 5;

void setup() {
  // Adicionamos la barra de tolerancia
  cp5 = new ControlP5(this);
  cp5.addSlider("Tolerancia").setPosition(margin, margin).setSize(500, (topMargin - (margin * 2))).setRange(0, 2000);
  
  size(1825, 550);
  //noLoop();
  
  img01 = loadImage("img01.jpg");
  img02 = loadImage("img02.jpg");
}

void draw () {
  
  // Valores de Tolerancia para comparativa de pixeles 
  float tolerance = (cp5.getController("Tolerancia").getValue()) * 1000;
  println(tolerance);
  
  // Posicion inicial de las coordenadas de resultado
  int pintaIniX = img01.width + img02.width + (margin * 3);
  int pintaIniY = topMargin;
  
  // Variables de pintado
  int pintaX = 0;
  int pintaY = 0;
  
  // Inicializa coordenada en X
  pintaX = pintaIniX;
  pintaY = pintaIniY;
  
  // Dibuja imagen 01 e imagen 02
  image(img01, margin, topMargin);  
  image(img02, img01.width + (margin * 2), topMargin);
  
  // Recorrido pixel a pixel de imagen 01
  for (int i = 0; i < img01.height; i++) {
    
    for (int j = 0; j < img01.width; j++) {
      
      // Lectura y comparativa de pixeles
      int pixel01 = get(j + margin, i + topMargin);
      int pixel02 = get(j + (img01.width + (margin * 2)), i + topMargin);
      
      //println(pixel01 + " - " + pixel02);
      
      // Escritura del pixel cuando hay diferencia (con tolerancia)
      if (abs(pixel01 - pixel02) <= tolerance) {
        set(pintaX, pintaY, color(0));
      } else {
        set(pintaX, pintaY, color(pixel01));
      }
      
      // Aumenta en un pixel la coordenada en X 
      pintaX += 1;
    }
    
    // Aumenta en un pixel la coordenada en Y y retorna en X
    pintaX = pintaIniX;
    pintaY += 1;
  }
  
}
