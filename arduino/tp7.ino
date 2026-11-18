const int pinE1 = 2; 
const int pinE2 = 3; 
const int pinL1 = 4; 
const int pinL2 = 5; 

void setup() {
  pinMode(pinE1, INPUT_PULLUP); 
  pinMode(pinE2, INPUT_PULLUP);
  pinMode(pinL1, OUTPUT);
  pinMode(pinL2, OUTPUT);
  
  Serial.begin(9600);
}

void loop() {
  // 1. Leer estados de las entradas (invertidos si usamos INPUT_PULLUP, LOW al presionar)
  int estadoE1 = digitalRead(pinE1) == LOW ? 1 : 0;
  int estadoE2 = digitalRead(pinE2) == LOW ? 1 : 0;

  // 2. Enviar estados hacia Processing en formato de cadena separado por comas
  Serial.print(estadoE1);
  Serial.print(",");
  Serial.println(estadoE2);

  // 3. Leer si Processing manda comandos para cambiar las salidas (L1 y L2)
  if (Serial.available() > 0) {
    char comando = Serial.read();
    
    // A enciende L1, a apaga L1
    // B enciende L2, b apaga L2
    if (comando == 'A') digitalWrite(pinL1, HIGH);
    if (comando == 'a') digitalWrite(pinL1, LOW);
    if (comando == 'B') digitalWrite(pinL2, HIGH);
    if (comando == 'b') digitalWrite(pinL2, LOW);
  }

  delay(50); // Pequeña pausa para estabilidad en la comunicación
}