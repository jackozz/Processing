/*
  Análisis de imágen por medio de Fibonacci
  Autor: Jaime Andrés
  Fecha: 20200302
*/

PImage img;

int lineaA_x = 357;
int lineaA_y = 522;
int lineaC_x = 524;
int lineaC_y = lineaA_y + 20;

int A_const  = 215;
int C_const  = 260;

void setup() {    
  //noLoop();
  size(850, 1170); // Tamaño de la ventana (tamaño original: 1920, 2560)
  img = loadImage("fotoJA.jpg");
}

void draw() {
  image(img, 0, 0, width, height); //image(img, 0, 0, width/2, height/2);
  
  //Linea A;
  int longA = lineaA(lineaA_x, lineaA_y, A_const);
  
  //Linea B (hallando el centro de A);
  lineaB(longA/2);
  
  //Linea C;
  int longC = lineaC(lineaC_x, lineaC_y, C_const);
  
  //Linea D (hallado el centro de C);
  lineaD(longC/2);
}

int lineaA(int coord_x, int coord_y, int c){
  //Colorea y dibuja linea
  stroke(255,0,0);
  strokeWeight(4);
  line(coord_x, coord_y, coord_x + c, coord_y);
  return (coord_x + c) - coord_x; 
}

void lineaB(int distA){
  //Colorea y dibuja linea basado e A
  //Linea B;
  lineaA(lineaA_x - distA, lineaA_y + 20, A_const * 2);
}

int lineaC(int coord_x, int coord_y, int c){
  //Colorea y dibuja linea
  stroke(0,0,255);
  strokeWeight(4);
  line(coord_x, coord_y, coord_x, coord_y + c);
  return (coord_x + c) - coord_x; 
}

void lineaD(int distC){
  //Colorea y dibuja linea basado en C
  //Linea D;
  lineaC(lineaC_x - 55, lineaC_y - (distC*2), C_const * 3);
}
