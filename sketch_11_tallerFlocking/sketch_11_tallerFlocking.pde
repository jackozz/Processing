Manada manada;

int cantidadPersonas = 300;
int duracionInfeccion = 15;

int diaCero = 0;
int diasTranscurridos = 0;
int diasInfeccion = 0;

void setup() {
  size(800, 600);
  manada = new Manada();
  
  // Adiciona la cantidad inicial de personas al sistema
  for (int i = 0; i < cantidadPersonas; i++) {
    manada.adicionaPersona(new Persona(random(50),random(50)));
  }
}

void draw() {
  background(50);
  manada.ejecutar(diasTranscurridos);
  
  // Identifica el tiempo transcurrido desde el día de inicio d ela infección (Se representa cada segundo como los días transcurridos)
  this.diasTranscurridos = int(frameCount / 100);
  
  // Calculo de los dias transcurridos desde el día cero
  if (diaCero > 0) {
    this.diasInfeccion = diasTranscurridos - diaCero;
  }  
  
  // Presenta informacion en pantalla  
  textSize(16);  
  fill(255, 255, 255);
  text("Tiempo de duración de la infección: " + duracionInfeccion + " dias", 10, 20);  
  fill(255, 255, 255);
  text("Propenso", 10, 60);  
  fill(255, 0, 0);
  text("Infectado", 10, 80);  
  fill(102, 102, 102);
  text("Excluido", 10, 100);  
  textSize(24);
  fill(0, 255, 255);
  text("Dias transcurridos: " + diasTranscurridos, 10, this.height - 35);
  textSize(24);
  fill(255, 0, 0);
  text("Dias de infección: " + diasInfeccion, 10, this.height - 10);
}

// Add a new boid into the System
void mousePressed() {
  
  // Tienen que pasar 10 días para poder adicionar a una persona (mientras se estabiliza la dispersión de la población)
  if (this.diasTranscurridos > 10) {
    Persona infectada = new Persona(mouseX, mouseY);
    
    // Indica que la persona está infectada  
    infectada.infectado(diasTranscurridos, duracionInfeccion);  
    manada.adicionaPersona(infectada);  
    
    // Indicamos el dia cero de la infección
    if (this.diaCero == 0) {
      this.diaCero = this.diasTranscurridos;
    }
  }
}
