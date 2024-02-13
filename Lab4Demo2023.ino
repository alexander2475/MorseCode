extern byte val;
extern byte width;
extern byte ascii;

extern "C" { 
  void decode_morse();
}

//
// function to read a 2-digit decimal value from user
//
byte read2DigitValue()
{
  byte inch; int val;
  Serial.println("Enter a 2-digit decimal value:");
  while (!Serial.available()) delay(100);
  inch = Serial.read();
  val = (inch - '0') * 10;
  while (!Serial.available()) delay(100);
  inch = Serial.read();
  val += (inch - '0');
  Serial.print("The value entered is ");
  Serial.println(val,DEC);
  return (byte) val;
}

void flashEureka() 
{
  // Add you code here

  // You will call the Eureka() function in assembly
}

void decodeMorse(const String & string, char message[])
{
  int sIndex = 0; //current location in string
  int mIndex = 0; //the current location in the message
  val = 0; 
  width = 0; 

  while (string[sIndex] != NULL){
    if (string[sIndex] == ' '){
      //process the val and width
      decode_morse();
      message[mIndex] = ascii;
      mIndex++;
      message[mIndex] = ' ';
      mIndex++;
      val = 0;
      width = 0;
    } else {
      val = val * 2 + (string[sIndex] - '0');
      width++;
      decode_morse();
    }
    sIndex++;
  }

  //what if val/index are non zerio, the process
  if (width > 0){
    message[mIndex] = ascii;
    mIndex++;
    message[mIndex] = ' ';
    mIndex++;
  }

  message[mIndex] = NULL;

}

void decodeMorse() 
{
  Serial.println("Input a Morse code string (separate the code for characters by a space):");

  while (!Serial.available()) delay(100);
  String string = Serial.readString();

  Serial.print("The Morse code string is: ");
  Serial.println(string);

  string = "1000 100 0"; // "01 1000";
  char message[100];

  decodeMorse(string, message);

  if(strlen(message) > 0) {
    Serial.print("The decoded message is: ");
    Serial.println(message);
  } else {
    Serial.print("Failure in decoding the input Morse code\n");
  }  
}

void setup() {
  //
  // Initialize serial communications
  //
  Serial.begin(9600);

  flashEureka();
  decodeMorse();
  
}

void loop() {
  // put your main code here, to run repeatedly:
  delay(20000); // 20,000 millisecs == 20 seconds
  Serial.println("*");
}
