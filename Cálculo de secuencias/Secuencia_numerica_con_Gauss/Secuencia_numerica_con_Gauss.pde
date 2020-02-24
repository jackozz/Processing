/*
 * SUMATORIA DE SECUENCIAS POR MEDIO DE LA FORMULA DE GAUSS
 * FECHA: 20200223
 * AUTOR: JAIME ANCRES CRUZ ROMERO
 */ 
 void setup() {
   // La función milis retorna la cantidad de milisegundos que pasan desde que se ejecuta un programa
   int m = millis();
   int i = 100000; // Secuencia numérica a calcular   
   int valor;
   
   // Cálculo de secuencia con fórmula de Gauss  
   valor = (i*(i+1))/2;
   
   // Imprime resultado de la sumatoria
   println("SUMATORIA DE SECUENCIAS POR MEDIO DE LA FORMULA DE GAUSS");
   println("Secuencia: " + i + " - Valor: " + valor);
   
   // Presenta en pantalla el tiempo transcurrido en segundos
   println("--- Ejecutado en " + m + " milisegundos");
 }
