/*
 * SUMATORIA DE SECUENCIAS POR MEDIO DEL CICLO "FOR"
 * FECHA: 20200223
 * AUTOR: JAIME ANCRES CRUZ ROMERO
 */ 
 void setup() {
   // La función milis retorna la cantidad de milisegundos que pasan desde que se ejecuta un programa
   int m = millis();
   int i; // Secuencia numérica a calcular (aumenta en el ciclo FOR)
   int valor = 0;

   // Cálculo de secuencia con FOR
   for(i=1; i<=100000; i++){
     valor = valor + i;
     //println("Sec: " + i + " - Valor: " + valor);
   }
   
   // Imprime resultado de la sumatoria
   println("SUMATORIA DE SECUENCIAS POR MEDIO DEL CICLO 'FOR'");
   println("Secuencia: " + (i-1) + " - Valor: " + valor);
   
   // Presenta en pantalla el tiempo transcurrido en segundos
   println("--- Ejecutado en " + m + " milisegundos");
 }
