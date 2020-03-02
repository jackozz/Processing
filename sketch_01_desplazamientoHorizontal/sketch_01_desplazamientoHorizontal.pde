// Declaración de variables
int x, y; // Variables de posición
boolean flag_dir = true;

 void setup() {
   size(800, 600); // Tamalo de la ventana   
 }
 
 void draw() {
   background(255,255,255); //Pinta el fondo de la ventana de blanco (colores RGB)
   
   
   if (x == 800) {
     flag_dir = false;
   } 
   
   if (x == 0) {
     flag_dir = true;
   }
   
   if (flag_dir) {
     x = x+5;
   } else {
     x = x-5;
   }
   
   fill(127,0,0); // Setea el interior de un objeto al color indicado
   ellipse(x,50,50,50); // Pinta una elipse
 }
