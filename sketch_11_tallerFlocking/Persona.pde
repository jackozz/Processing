class Persona {

  PVector posicion;
  PVector velocidad;
  PVector aceleracion;
  
  /***** Estados de la persona ******
  P = Propenso
  I = Infectado
  E = Excluido
  ***********************************/
  char estado = 'P';
  int tiempoInfectado = 0;
  int diasTranscurridos; // Atributo que identifica los dias transcurridos desde su nacimiento
  
  float r;
  float fuerzaMax = 0.03;    // Maximum steering force
  float velocidadMax = 1.0;    // Maximum speed  
  float distanciaPersonas = 50.0f;
  

    Persona(float x, float y) {
    aceleracion = new PVector(0, 0);

    // This is a new PVector method not yet implemented in JS
    // velocity = PVector.random2D();

    // Leaving the code temporarily this way so that this example runs in JS
    float angle = random(TWO_PI);
    velocidad = new PVector(cos(angle), sin(angle));

    posicion = new PVector(x, y);
    r = 1.0;
  }

  void run(ArrayList<Persona> boids) {
    flock(boids);
    actualizar();
    borders();    
    render();
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    aceleracion.add(force);
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<Persona> personas) {
    PVector sep = separacion(personas);
    PVector ali = alineacion(personas);      // Alignment
    PVector coh = cohesion(personas);   // Cohesion
    // Arbitrarily weight these forces
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  // Method to update position
  void actualizar() {
    // Update velocity
    velocidad.add(aceleracion);
    // Limit speed
    velocidad.limit(velocidadMax);
    posicion.add(velocidad);
    // Reset accelertion to 0 each cycle
    aceleracion.mult(0);
  }

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, posicion);  // A vector pointing from the position to the target
    // Scale to maximum speed
    desired.normalize();
    desired.mult(velocidadMax);

    // Above two lines of code below could be condensed with new PVector setMag() method
    // Not using this method until Processing.js catches up
    // desired.setMag(maxspeed);

    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocidad);
    steer.limit(fuerzaMax);  // Limit to maximum steering force
    return steer;
  }

  void render() {    
    // Identifica si está infectado
    if (tiempoInfectado > 0) {
      println(diasTranscurridos, tiempoInfectado);
    }
    
    stroke(0, 0, 0);
    if ((estado == 'I') || (estado == 'E')) {      
      if (diasTranscurridos <= tiempoInfectado) { // Si se han superado los 15 dias, se excluye a la persona
        fill(255, 0, 0);
      } else {
        estado = 'E';
        fill(102, 102, 102);
      }
    } else {
      fill(255, 255, 255);
    }
    pushMatrix();
    translate(posicion.x, posicion.y);
    circle(10, 10, 10);
    popMatrix();
  }
  
  // Wraparound
  void borders() {
    if (posicion.x < -r) posicion.x = width+r;
    if (posicion.y < -r) posicion.y = height+r;
    if (posicion.x > width+r) posicion.x = -r;
    if (posicion.y > height+r) posicion.y = -r;
  }

  // Separation
  // Method checks for nearby boids and steers away
  PVector separacion (ArrayList<Persona> personas) {    
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Persona other : personas) {
      float d = PVector.dist(posicion, other.posicion);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < this.distanciaPersonas)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(posicion, other.posicion);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      steer.setMag(velocidadMax);

      // Implement Reynolds: Steering = Desired - Velocity
      steer.sub(velocidad);
      steer.limit(fuerzaMax);
    }
    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector alineacion (ArrayList<Persona> personas) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Persona other : personas) {
      float d = PVector.dist(posicion, other.posicion);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocidad);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.setMag(velocidadMax);
      PVector steer = PVector.sub(sum, velocidad);
      steer.limit(fuerzaMax);
      return steer;
    } 
    else {
      return new PVector(0, 0);
    }
  }

  // Cohesion
  // For the average position (i.e. center) of all nearby boids, calculate steering vector towards that position
  PVector cohesion (ArrayList<Persona> personas) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all positions
    int count = 0;
    for (Persona other : personas) {
      float d = PVector.dist(posicion, other.posicion);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.posicion); // Add position
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the position
    } 
    else {
      return new PVector(0, 0);
    }
  }
  
  // Metodo para marcar a la persona como "infectada"
  void infectado (int tiempo, int duracionInfeccion){
    this.estado = 'I';
    this.tiempoInfectado = (tiempo + duracionInfeccion);
  }
}
