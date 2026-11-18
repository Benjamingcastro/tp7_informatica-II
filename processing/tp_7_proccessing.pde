import processing.serial.*;

Serial puerto;
int e1 = 0, e2 = 0; // Estados de entradas recibidos de Arduino
boolean l1 = false, l2 = false; // Estados lógicos de las salidas

void setup() {
  size(500, 350);
  
  // Muestra los puertos disponibles en la consola inferior
  printArray(Serial.list());
  
  // Verificamos si hay puertos antes de intentar abrirlos para evitar el error anterior
  if (Serial.list().length > 0) {
    puerto = new Serial(this, Serial.list()[0], 9600);
    puerto.bufferUntil('\n');
  } else {
    println("¡ATENCIÓN! No se encontró ningún Arduino conectado.");
  }
}

void draw() {
  // Fondo de atras
  background(30, 34, 42);
  
  // Seccion de las entradas
  fill(24, 43, 73);
  stroke(41, 128, 185);
  strokeWeight(2);
  rect(60, 40, 380, 110, 10);
  
  // Título de la sección
  fill(255);
  noStroke();
  textSize(20);
  text("Entradas", 80, 75);
  
  // E1
  fill(e1 == 1 ? color(46, 204, 113) : color(44, 62, 80)); // Verde cuando esta activo
  stroke(52, 152, 219);
  rect(240, 70, 70, 50, 6);
  fill(255);
  textSize(18);
  text("E1", 263, 102);
  
  // E2
  fill(e2 == 1 ? color(46, 204, 113) : color(44, 62, 80));
  stroke(52, 152, 219);
  rect(335, 70, 70, 50, 6);
  fill(255);
  text("E2", 358, 102);
  
  // Seccion salidas
  fill(73, 24, 24);
  stroke(192, 57, 43);
  strokeWeight(2);
  rect(60, 180, 380, 110, 10);
  
  // Título de la seccion
  fill(255);
  noStroke();
  text("Salidas", 80, 215);
  
  // Círculo L1
  fill(l1 ? color(231, 76, 60) : color(92, 39, 33));
  stroke(231, 76, 60);
  strokeWeight(2);
  ellipse(275, 235, 60, 60);
  fill(255);
  noStroke();
  text("L1", 264, 242);
  
  // Círculo L2
  fill(l2 ? color(231, 76, 60) : color(92, 39, 33));
  stroke(231, 76, 60);
  strokeWeight(2);
  ellipse(370, 235, 60, 60);
  fill(255);
  noStroke();
  text("L2", 359, 242);
}

// Lectura automática de datos que llegan desde Arduino por puerto serie
void serialEvent(Serial p) {
  String mensaje = p.readStringUntil('\n');
  if (mensaje != null) {
    mensaje = trim(mensaje);
    int[] valores = int(split(mensaje, ','));
    if (valores.length >= 2) {
      e1 = valores[0];
      e2 = valores[1];
    }
  }
}

// Interacción con el Mouse 
void mousePressed() {
  // Si el puerto está inicializado, evitamos errores al hacer clic
  if (puerto == null) return;
  
  // Coordenadas del círculo L1 
  if (dist(mouseX, mouseY, 275, 235) < 30) {
    l1 = !l1; // Cambiar estado lógico
    if (l1) {
      puerto.write('A'); 
    } else {
      puerto.write('a'); 
    }
  }
  
  // Coordenadas del círculo L2 
  if (dist(mouseX, mouseY, 370, 235) < 30) {
    l2 = !l2; // Cambiar estado lógico
    if (l2) {
      puerto.write('B'); 
    } else {
      puerto.write('b'); 
    }
  }
}
