class Manada {
  ArrayList<Persona> personas; // An ArrayList for all the boids

  Manada() {
    personas = new ArrayList<Persona>(); // Initialize the ArrayList
  }

  void ejecutar(int diasTranscurridos) {
    for (Persona p : personas) {
      p.diasTranscurridos = diasTranscurridos;
      p.run(personas);  // Passing the entire list of boids to each boid individually
    }
  }

  void adicionaPersona(Persona b) {
    personas.add(b);
  }

}
