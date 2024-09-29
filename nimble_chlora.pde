import processing.serial.*;  // Import the Serial library

Serial myPort;               // Variable to hold the serial port
String myString = null;      // Variable to store the received data
int[] rgb = {0, 0, 0};       // Array to hold the RGB values

void setup() {
  size(200, 200);            // Set the window size (200x200 pixels)
  
  // List all available serial ports for debugging
  println(Serial.list());  
  // Open the serial port. Adjust the port index (0) if necessary.
  myPort = new Serial(this, Serial.list()[2], 115200);  
  myPort.bufferUntil('\n');  // Wait for a newline character before parsing
}

void draw() {
  // Fill the background with the RGB color read from the serial port
  background(rgb[0], rgb[1], rgb[2]);  

  // Optionally, print the RGB values to the Processing console for debugging
  println("RGB Color: " + rgb[0] + ", " + rgb[1] + ", " + rgb[2]);
}

void serialEvent(Serial myPort) {
  // Read the data from the serial port until a newline character is received
  myString = myPort.readStringUntil('\n');

  if (myString != null) {  // Ensure the received string is not null
    myString = trim(myString);  // Remove any extra spaces or newlines
    String[] values = split(myString, ',');  // Split the string by commas

    // Parse the RGB values if the length is correct
    if (values.length == 3) {
      rgb[0] = int(values[0]);  // Convert the first value to an integer (Red)
      rgb[1] = int(values[1]);  // Convert the second value to an integer (Green)
      rgb[2] = int(values[2]);  // Convert the third value to an integer (Blue)
    }
  }
}
