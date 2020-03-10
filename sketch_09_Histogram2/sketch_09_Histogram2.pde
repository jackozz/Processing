/*
EJERCICIO CON HISTOGRAMAS (ESCALA DE GRISES)
Autor: Jaime Andrés CRuz Romero
Fecha: 20200309  
*/   

PrintWriter output, output2;

void setup(){
size(1500, 500);
output = createWriter("histogramPict01.txt");
output2 = createWriter("histogramPict02.txt");

}
// Load an image from the data directory
// Load a different image by modifying the comments
void draw(){
PImage img = loadImage("pic1.jpg");
PImage img2 = loadImage("pic2.jpg");

// Titulo imagen #1
stroke(255,255,255);
fill(255,255,255);
rect(0, 0, 100, 40);
fill(0,0,0);
text(" PICTURE 01",0,25);

// Titulo imagen #2
stroke(255,255,255);
fill(255,255,255);
rect((img.width) + 10, 0, 100, 40);
fill(0,0,0);
text(" PICTURE 02",(img.width) + 10,25);

image(img, 0, 50);
image(img2,(img.width) + 10,50);
int[] hist = new int[256];
int[] hist2 = new int[256];

// --------------------- Calculate the histogram PICT01
for (int i = 0; i < img.width; i++) {
  for (int j = 0; j < img.height; j++) {
    int bright = int(brightness(get(i, j)));
    hist[bright]++; 
  }
}

// Find the largest value in the histogram
int histMax = max(hist);

//stroke(255);
// Draw half of the histogram (skip every second value) PICT01
for (int i = 0; i < img.width; i += 2) {
  // Map i (from 0..img.width) to a location in the histogram (0..255)
  int which = int(map(i, 0, img.width, 0, 255));
  // Convert the histogram value to a location between 
  // the bottom and the top of the picture
  int y = int(map(hist[which], 0, histMax, img.height, 0));
  
  stroke(255,0,0);
  line(i, img.height + 50, i, y + 50);
  
  //println(i,y);
  //println(hist);
  output.println(i + "-" + y);
}

  output.flush();
  output.close();

// --------------------- Calculate the histogram PICT02
for (int i = 0; i < img2.width; i++) {
  for (int j = 0; j < img2.height; j++) {
    int bright2 = int(brightness(get(i, j)));
    hist2[bright2]++; 
  }
}

int histMax2 = max(hist2);

// Draw half of the histogram (skip every second value) PICT02
for (int i = 0; i < img2.width; i += 2) {
  // Map i (from 0..img.width) to a location in the histogram (0..255)
  int which = int(map(i, 0, img2.width, 0, 255));
  // Convert the histogram value to a location between 
  // the bottom and the top of the picture
  int y = int(map(hist2[which], 0, histMax2, img2.height, 0));
  
  stroke(255,0,0);
  line(i+img.width + 10, img2.height + 50, i+img.width + 10, y + 50);
  
  //println(i,y);
  output2.println(i + "-" + y);
}
  
  output2.flush();
  output2.close(); 
  
  // Compara los dos arreglos
  boolean flag = false;
  
  for (int i = 0; i <= hist.length; i++) {
    
    //println("val1:" + i + " - " + hist[i]);
    //println("val2:" + i + " - " + hist2[i]);
    
    if (hist[i] != hist2[i]) {
      flag = true;
      break;
    }
  }
  
  String resultado;
  if (flag) {
    resultado = "No son iguales";
  } else {
    resultado = "Son iguales";  
  }
  
  // Resultado
  stroke(255,255,255);
  fill(255,255,255);
  rect(0, img.height + 60, 500, 40);
  fill(0,0,0);
  text(" Resultado: " + resultado,0,img.height + 80);
  
  
  
  //exit();
}
