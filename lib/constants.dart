final startingProgram = """
DATA 0 43; # Starting register to store output in RAM
DATA 1 42; # Location of next register to write to
ST   1  0; # Store the next output register value in RAM
XOR  0  0; # Zero Register 0
DATA 1  1; # Store "1" in 1
XOR  2  2; # START LOOP(Loc 22) Zero Register 2
ADD  0  2; # Reg 2 <- 0 + (Reg 0)
ADD  1  2; # Reg 2 <- (Reg 0) + (Reg 1)  [r2 = r0 + r1]
XOR  0  0; # Zero Reg 0
ADD  1  0; # Reg 0 <- 0 + (Reg 1)   [r0 = r1]
XOR  1  1; # Zero Reg 1
ADD  2  1; # Reg 1 <- 0 + Reg 2   [r1 = (old r0) + (old r1)]
OUT  1   ; # Put Result on OUTPUT
DATA 3 42; # Load where to find next register address into 3
LD   3  3; # Load the actual next register address into 3
ST   3  1; # Store Reg 1 in the next output register
DATA 2  1; # Set Reg 2 to 1
ADD  2  3; # Add 1 to next register address
DATA 2 42; # Load Address where to store next output address into Reg 2
ST   2  3; # Replace next register address w/ same value + 1
JMP  22  ; # END LOOP(Loc 22)
    """;

final double padding = 5;

final int nSteps = 6;
final String socketAddress = 'https://koutavi.appspot.com/test';
final String parseAddress = 'https://koutavi.appspot.com/parse';
// final String socketAddress = 'http://localhost:5000/test';
// final String parseAddress = 'http://localhost:5000/parse';