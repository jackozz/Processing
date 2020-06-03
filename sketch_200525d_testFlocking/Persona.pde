class Persona {

  int tamanoPersona = 8;
    
  /***** Estados de la persona ******
  P = Propenso
  I = Infectado
  E = Excluido
  ***********************************/
  char estado = 'P';
  
  int duracionInfeccion = 15;
  int tiempoInfectado = 0;
  int tiempoTranscurrido = 0;
  
  PVector posicion;
  PVector velocidad;
  PVector aceleracion;
  
  float fuerzaMax = 2;     // Fuerza de dirección máxima
  float velocidadMax = 0.03;  // Velocidad máxima

    // Metodo constructor
    Persona(float posX, float posY) {
      this.posicion = new PVector(posX, posY);
      this.velocidad = new PVector();
      this.velocidad.setMag(random(0.5, 1.5));
      this.aceleracion = new PVector();    
  }
  
  //metodo para mostrar la particula en pantalla
  void mostrar(){
    strokeWeight(tamanoPersona);
    point(this.posicion.x, this.posicion.y);
  }
  
  //metodo para actualizar las propiedades de la particula
  void actualizar(int dias){
    this.posicion.add(this.velocidad.random2D());
    this.velocidad.add(this.aceleracion);
    
    // Identifica si está infectado
    if (estado == 'I') {
      if (dias <= tiempoInfectado) {
        stroke(255, 0, 0);
      } else {
        stroke(102, 102, 102);
      }
    } else {
      stroke(255, 255, 255);
    }
    
  }
  
  // Metodo para marcar a la persona como "infectada"
  void infectado (int tiempo){
    this.estado = 'I';
    this.tiempoInfectado = (tiempo + duracionInfeccion);
  }
  
  // Tiempo transcurrido para la persona
  void tiempoTranscurrido(int tiempo) {
    this.tiempoTranscurrido = tiempo;
  }
  
  // Separacion
  // Metodo de verificación para personas cercanas y mantener distancia
  PVector separar (ArrayList<Persona> personas) {
    float distanciaDeseada = 25.0f;
    PVector conducir = new PVector(0, 0, 0);
    int count = 0;
    
    // Para cada persona en el sistema, chequea si está muy cerca
    for (Persona otros : personas) {
      float d = PVector.dist(posicion, otros.posicion);
      
      // Si la distancia es mayor que cero y menor que el valor arbitrario (0 es porque es la misma persona)
      if ((d > 0) && (d < distanciaDeseada)) {
        
        // Calcula la dirección del ventor para alejarse del vecino
        PVector diff = PVector.sub(posicion, otros.posicion);
        diff.normalize();
        diff.div(d);        // Anchura por distancia
        conducir.add(diff);
        count++;            // Mantiene el rastro cuantos son los otros
      }
    }
    
    // Promedio: divide por la cantidad de otros 
    if (count > 0) {
      conducir.div((float)count);
    }

    // Mientras el vector sea mayor que cero
    if (conducir.mag() > 0) {
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      conducir.setMag(velocidadMax);

      // Implement Reynolds: Steering = Desired - Velocity
      //steer.normalize();
      //steer.mult(maxspeed);
      conducir.sub(velocidad);
      conducir.limit(fuerzaMax);
    }
    return conducir;
  }
  
  
}
