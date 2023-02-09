#include <AccelStepper.h>

#define STBY 16
#define AIN1 17
#define AIN2 5
#define BIN1 4
#define BIN2 3

#define motorPin1 26
#define motorPin2 25
#define motorPin3 33
#define motorPin4 32

#define MotorInterfaceType 8

AccelStepper stepper = AccelStepper(MotorInterfaceType, motorPin1, motorPin3, motorPin2, motorPin4);

void setup() {


  pinMode(STBY,OUTPUT);
  pinMode(AIN1,OUTPUT);
  pinMode(AIN2,OUTPUT);
  pinMode(BIN1,OUTPUT);
  pinMode(BIN2,OUTPUT);

  digitalWrite(STBY,HIGH);

   // Set the stepper rpm:(0-200)
  stepper.setMaxSpeed(1000);
  Serial.begin(9600);
}

void loop() {

String bleInput = Serial.readString();
//stepper continuous rotation
if (bleInput == "stepper_rotate") {
stepper.setSpeed(500); 
stepper.runSpeed();
}

//stop stepper
if (bleInput == "stepper_stop") {
stepper.setSpeed(0); 
stepper.runSpeed();
}

//Movement
//Go forward
if (bleInput == "movement_forward") {
digitalWrite(AIN1, LOW);
digitalWrite(AIN2, HIGH);
digitalWrite(BIN1, HIGH);
digitalWrite(BIN2, LOW);
}

// Left condition
else if (bleInput == "movement_left") {
digitalWrite(AIN1, LOW);
digitalWrite(AIN2, HIGH);
digitalWrite(BIN1, LOW);
digitalWrite(BIN2, LOW);
}

// Right condition
else if (bleInput == "movement_right") {
digitalWrite(AIN1, LOW);
digitalWrite(AIN2, LOW);
digitalWrite(BIN1, HIGH);
digitalWrite(BIN2, LOW);
}

// Go back condition
else if (bleInput == "movement_back") {
digitalWrite(AIN1, HIGH);
digitalWrite(AIN2, LOW);
digitalWrite(BIN1, LOW);
digitalWrite(BIN2, HIGH);
}

//stop condition
else {
digitalWrite(AIN1, LOW);
digitalWrite(AIN2, LOW);
digitalWrite(BIN1, LOW);
digitalWrite(BIN2, LOW);
}
}
