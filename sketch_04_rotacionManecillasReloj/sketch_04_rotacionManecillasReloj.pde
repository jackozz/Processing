/****************************
   Proyecto: Rotacion de elipse en sentido horario
   Autor: Jaime Andrés Cruz Romero
   Fecha: 20200209
*****************************/
 
int   centroX   = 400;
int   centroY   = 300;
float angulo    = 0.05;
int   radio     = 200;
float velocidad = 0.01;
 
void setup(){
  
  size(800,600);   // Tamaño de la ventana  
  smooth();        // Suaviza el dibujado de las imágenes (valores entre 1 y 8, por defecto 3)
  noStroke();      // Elimina los bordes de las figuras geométricas
}

void draw(){
  
  // Dibuja el fondo en color blanco
  background(255, 255, 255);
  
  // Cálculo de las posiciones para girar en sentido horario. Para invertir el sentido, sólo basta con cambiar el seno y el coseno de coordenadas
  float x = centroX + cos(angulo) * radio;
  float y = centroY + sin(angulo) * radio;
  
  // Dibuja punto central  
  fill(255, 0, 0);
  ellipse(centroX, centroY, 10, 10);  
  
  // Dibuja el circulo que gira  
  fill(0, 0, 255);
  ellipse(x,y,50,50);
  
  // Calcula el siguiente valor del angulo a dibujar, según la velocidad indicada
  println("Angulo: " + angulo);
  angulo = angulo + velocidad;
}
