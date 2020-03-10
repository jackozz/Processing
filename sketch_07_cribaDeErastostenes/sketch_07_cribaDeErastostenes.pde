/*
TALLER - CRIBA DE ERASTOTENES
AUTOR: JAIME ANDRES CRUZ ROMERO
FECHA: 20200307
*/

// Tamaño del arreglo a calcular (filas x columnas)
int cols = 10;
int rows = 10;

int upper_margin = 50;   // Tamaño de la margen superior
int boxSize = 40;        // Tamaño de la caja a pintar
int maxValue = cols * rows;
int primos[] = new int[maxValue];
int totalPrimos = 0;
PFont Font1;
  
void setup() {
  size(1366, 768);
  Font1 = createFont("Ubuntu Bold", 18);
  noLoop();
  
  //println(PFont.list());  
}

void draw() {
  
  
  int posicion = 0;
  
  for (int i = 1; i <= maxValue; i++) {
    if (esPrimo(i)) {
      
      primos[posicion] = i;
      posicion += 1;
    }
  }
  
  // Pinta primos
  printPrimos(primos);
  printArray(cols, rows);  
  
  
}

// Imprie matriz en pantalla
void printArray(int col, int row){
  
  // Variable de secuencia numérica a evaluar
  int valor = 1;
  int numPrimo;
  
  // Posición central de la pantalla en X
  int center = width/2;
  
  // Recorrido de filas
  for(int r = 0; r < row; r++){
    
    // Recorrido de columnas
    for(int c = 0; c < col; c++){
      
      // Identifica si la cantidad de columnas es par o impar para calcular el centro que se debe usar para posicionar la matriz a pintar
      int posIni;
      if ((col % 2) == 0) {
        
        posIni = center - (boxSize * (cols / 2));
      } else {
        
        posIni = center - ((boxSize / 2) * (cols / 2));
      }
      
      int posX = posIni + (c * boxSize);
      int posY = row + (r * boxSize) + upper_margin;
      
      for (int i = 0; i < totalPrimos; i++) {
        numPrimo = primos[i];
        
        if ((valor % numPrimo) == 0) {
          
          dibujoCeldas(valor, posX, posY, colorNumero(numPrimo));
        } /*else {
          
          dibujoCeldas(valor, posX, posY, 255);
        }*/
      }
      
      
      
      // Aumento numérico
      valor += 1; 
    }
  } 
  
}

// Funcion para identificación de numeros primos
boolean esPrimo(int num) {
  
  // Bandera de evaluación
  boolean flag = true;
  
  // Si es 1, devuelve que no es primo
  if (num > 1) {
    
    // Si es mayor a dos, realiza el proceso para evaluar si es primo
    if (num > 2) {
      
      for (int i = 2; i < num; i++) {
        if ((num % i) == 0) {
          flag = false;
        }
        
      } 
    } else {      
      flag = true;
    }  
  } else {
    flag = false;
  }
  
 return flag; 
}

// Pinta en pantalla el numero evaluado y asigna un color cuando es primo
void printPrimos(int primos[]) {
  
  int num;
  int colorNumero;
  int contador = 0;
  int titulo = 110;
  boolean conValor = true;
  
  // Imprime titulo de numeros primos
  fill(255,255,255);
  rect(0, 0, titulo, boxSize);
  
  fill(0,0,0);
  textSize(12);
  text(" # Primos: ", 0, (boxSize / 2));
  
  while(conValor){
    
    num = primos[contador];
    
    if (num > 0) {
    
      colorNumero = colorNumero(contador + 1);
      fill(colorNumero,255,255);
      square(titulo + ((contador - 1) * boxSize), 0, boxSize);
      
      fill(0,0,0);
      textSize(10);
      text(num, titulo + (((contador - 1) * (boxSize)) + (boxSize / 3)), (boxSize / 2));
      
      totalPrimos += 1;
      
    } else {
      
      conValor = false;
    }
     //<>//
    contador += 1;
  }
}

// Asigna un color al numero evaluado
int colorNumero (int num) {
  
  return 255 - (255 / num);
}

// Dibujo de celdas
void dibujoCeldas(int num, int posX, int posY, int colorCelda) {
  
  fill(colorCelda,255,255);
  square(posX, posY, boxSize);
  
  // Presentación de números en la malla
  fill(0,0,0);
  textSize(8);      
  text(num, posX + (boxSize / 3), posY + ((boxSize / 2) + 5));
}
