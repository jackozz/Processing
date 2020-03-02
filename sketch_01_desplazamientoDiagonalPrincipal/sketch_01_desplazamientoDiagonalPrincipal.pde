// Declaración de variables
int i, x, y; // Variables de posición
boolean flag_dir = true;

 void setup() {
   size(1024, 600); // Tamalo de la ventana   
 }
 
 void draw() {
   background(255,255,255); //Pinta el fondo de la ventana de blanco (colores RGB)
   
   if(x == 0 && y == 0) {
     flag_dir = true;     
   }
   
   if(x > width && y > height) {
     flag_dir = false;     
   }
   
   if (flag_dir) {
     // Incrementa posición
     i++;
   } else {
     // Decrementa posición
     i--;
   }
   
   x = (width * i) / 100;
   y = (height * i) / 100;
   
   fill(127,0,0); // Setea el interior de un objeto al color indicado
   ellipse(x,y,50,50); // Pinta una elipse
 }
