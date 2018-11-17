import processing.serial.*;
import cc.arduino.*;

Arduino arduino;

int servoPin=5;
int trigPin=8;
int echoPin=12;
int c=34300;
Serial port;
void setup(){
  size(900,800); 
  arduino= new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(servoPin, Arduino.SERVO);
  arduino.pinMode(trigPin,Arduino.OUTPUT);
  arduino.pinMode(echoPin,Arduino.INPUT);
}
float m=0,l=450,x=200,y=200;
boolean crestere=true;

float grade(float g){
   float rad=(PI/180)*g;
   return rad;
 }
 void linie(float x,float y){
 line(x,height-y,x+cos(grade(m))*l,height-(y+sin(grade(m))*l));
 }
 
 void Obstacol(float a,float b){
   float dim=25;
   fill(200,60,120);
   ellipse(a,b,dim,dim);
   noFill();
 }
  
  float time(){
    
    int tm = millis();
    int dt = 1000;
    
    while(arduino.digitalRead(echoPin)!=Arduino.HIGH){
     // println("1");
      int ct = millis();
      if(ct-tm>=dt)
        break;

    }
//record initial time
float t0=millis();
//wait till pin exits from desired state
tm = millis();
while(arduino.digitalRead(echoPin)==Arduino.HIGH){
    int ct = millis();
      if(ct-tm>=dt)
        break;
}
//record final time
float t1=millis();
//return time difference
return (t1-t0)/1000;
  }
  
 float distance(){
 
   arduino.digitalWrite(trigPin,Arduino.LOW);
   delay(2);
    arduino.digitalWrite(trigPin,Arduino.HIGH);
   delay(5);
   arduino.digitalWrite(trigPin,Arduino.LOW);
   float timp = time();
   return(c*timp/2);
 }
  
void draw(){
 // arduino.servoWrite(servoPin,(int)m);
  
  
  clear();
  background(0,200,200);
  linie(width/2,height/2-200);
  delay(100);
  if(crestere==true){
    m=m+5;}
    else{
    m=m-5;
  }
  if(m==180){
  crestere=false;
  }
  if(m==0){
    crestere=true;
  }
  Obstacol(200,250);
  println(distance());
}
