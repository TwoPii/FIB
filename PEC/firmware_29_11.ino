/*
This example shows how to take simple range measurements with the VL53L1X. The
range readings are in units of mm.
*/

#include <Wire.h>
#include <VL53L1X.h>
#include <Stepper.h>
#define STEPS 2048 //Aproximadament una mica menys de una revolucio, falta acabar d'ajustar

Stepper stepper(STEPS, 8, 9, 10, 11);
bool pas = true;
VL53L1X sensor;
int num;

void setup()
{  
  pinMode(13, OUTPUT);
  digitalWrite(13, HIGH);
  stepper.setSpeed(1);
  Serial.begin(115200);
  num = 1;

  Wire.begin();
  Wire.setClock(400000); // use 400 kHz I2C

  sensor.setTimeout(500);
  if (!sensor.init())
  {
    Serial.println("Failed to detect and initialize sensor!");
    while (1);
  }
  
  // Use long distance mode and allow up to 50000 us (50 ms) for a measurement.
  // You can change these settings to adjust the performance of the sensor, but
  // the minimum timing budget is 20 ms for short distance mode and 33 ms for
  // medium and long distance modes. See the VL53L1X datasheet for more
  // information on range and timing limits.
  sensor.setDistanceMode(VL53L1X::Long);
  sensor.setMeasurementTimingBudget(33000);

  // Start continuous readings at a rate of one measurement every 50 ms (the
  // inter-measurement period). This period should be at least as long as the
  // timing budget.
  sensor.startContinuous(33);
}

void readDistanceAndSend(){
  Serial.print(sensor.read());
  if (sensor.timeoutOccurred()) { Serial.print(" TIMEOUT"); }
  Serial.println();
}

void doStep(){  
  stepper.step(1);
  Serial.print("Step:");
  Serial.println(num);
  ++num;
  delay(100);
}

void loop()
{
  readDistanceAndSend();
  doStep();  
}
