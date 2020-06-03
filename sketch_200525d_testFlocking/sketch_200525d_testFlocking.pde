ArrayList<Persona> persona = new ArrayList<Persona>();

int cantPersonas = 500;
int dias = 0;
int ancho = 800;
int alto = 600;

void setup(){
  size(800, 600); //width, height
  
  // Adiciono al vector la cantidad de particulas indicadas
  for(int i=0; i < cantPersonas; i++){
    persona.add(new Persona(random(ancho), random(alto)));
  }  
}

void draw(){  
  background(0, 0, 0);  
  
  // Identifica el tiempo transcurrido (Se representa cada segundo como los días transcurridos)
  this.dias = int(frameCount/frameRate);
  
  // Crea a las persnonas
  for (Persona p : persona) {
    p.actualizar(dias);
    p.mostrar();
  }
  
  // Presenta informacion en pantalla  
  textSize(16);
  
  fill(255, 255, 255);
  text("Tiempo de duración de la infección: 15 dias", 10, 20);
  
  fill(255, 255, 255);
  text("Propenso", 10, 60);
  
  fill(255, 0, 0);
  text("Infectado", 10, 80);
  
  fill(102, 102, 102);
  text("Excluido", 10, 100);
  
  textSize(24);
  fill(0, 255, 255);
  text("Dias transcurridos: " + dias, 10, this.height - 10);
}

void mousePressed(){
  Persona infectado = new Persona(mouseX,mouseY);
  infectado.infectado(dias);
  persona.add(infectado);
}
