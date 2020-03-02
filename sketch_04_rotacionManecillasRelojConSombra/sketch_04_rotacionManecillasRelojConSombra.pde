int centroX = 400;
int centroY = 300;
float angulo = 0.05;
int radio = 200;
float velocidad = 0.01;
 
void setup(){
  
  // Tamaño de la ventana
  size(800,600);
  
  // Suaviza el dibujado de las imágenes (valores entre 1 y 8, por defecto 3) 
  smooth();
  
  // Elimina los bordes de las figuras geométricas
  noStroke();
}

void draw(){
  
  // Dibuja el fondo en color blanco
  background(255, 255, 255);
  
  // Cálculo de las posiciones para girar en sentido horario. Para invertir el sentido, sólo basta con cambiar el seno y el coseno de coordenadas
  float x = centroX + cos(angulo) * radio;
  float y = centroY + sin(angulo) * radio;
  
  //---------------------
  float Sx = centroX + cos(angulo-0.05) * radio;
  float Sy = centroY + sin(angulo-0.05) * radio;
  //---------------------
  
  // Dibuja punto central  
  fill(0, 255, 0);
  ellipse(centroX, centroY, 10, 10);  
  
  // Dibuja el circulo que gira  
  fill(0, 0, 255);
  ellipse(x,y,25,25);
  
  // Dibuja sombra
  fill(0, 0, 200);
  ellipse(Sx,Sy,25,25);
  
  //drawCircle(x, y, 25, 10);
  
  // Calcula el siguiente valor del angulo a dibujar, según la velocidad indicada
  angulo = angulo + velocidad;
}

// Adaptación del código de recursividad para añadir efecto de sombreado
void drawCircle(float x, float y, float radius, int level) {
  float tt = 126 * level / 4.0;
  fill(tt);  
  
  float shadowX = x - cos(angulo-0.05) * radio;
  float shadowY = y - sin(angulo-0.05) * radio;
  
  ellipse(shadowX, shadowY, radius, radius);
  
  if (level > 1) {
    level--;
    drawCircle(x - 0.05, y - 0.05, radius, level);
  }
}
