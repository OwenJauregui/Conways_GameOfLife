/*/
Program of a cellular automaton "Game of Life" first 
designed by John Horton Conway in 1970. This version
allows the user to modify the cell states at any point
and pause/continue the excecution with the space bar.

Created: 04/21/2019
Modified: 08/06/2019
By: Owen Jauregui Borbon
/*/

int cellsz = 40, cl, rw; // Size of the cells, number of rows and columns
ArrayList<Cell> cells = new ArrayList<Cell> (); // Arraylist of cells
boolean time = false; // State of "Pause" or "Resume"

// Initialize the number of row and columns and creating all the cells
void setup() {
  fullScreen();
  cl = width/cellsz;
  rw = height/cellsz;
  
  //Creating a cell for each row and column
  for (int r = 0; r < rw; r++) {
    for (int c = 0; c < cl; c++) {
      cells.add(new Cell(c, r));
    }
  }
}

// Main loop of the program
void draw() {
  background(255);
  
  // Makes the cell updates every 10 frames to slow down the animation
  if (frameCount%10 == 0 && time) {
    
    // Checking which cells have to change state
    // on the next cicle
    for (Cell x : cells) {
      x.check();
    }
    
    // Changing the state of the cells that have
    // to change for the next cicle
    for (Cell x : cells) {
      if (x.getChange()){
        x.change();
      }
    }
  }
  for (Cell x : cells) {
    // Display each cell on the window
    x.show();
  }
  
  // Show the background of the "Time" label on the window
  fill(0, 200);
  // Rectangle on the top left for the label
  if (time) {
    rect(0, 0, 280, 80);
  } else {
    rect(0, 0, 300, 80);
  }
  
  // Text for the "Time" label on the window
  fill(255);
  textSize(50);
  text("Time: " + time, 15, 55);
}

// Resets the cells values to all dead and not changing 
// state on the next cicle
void reset() {
  for (Cell x : cells) {
    x.reset();
  }
}

// Get an index for a lineal arraylist by using an x and y
// value and converting it to a specific row and column
int indx(int c_, int r_) {
  int indx_ = floor (c_ + r_*cl); // Gets the linear index
  // Checks if the columns and rows are valid positions
  if (c_ >= 0 && c_ < cl && r_ >= 0 && r_ < rw) {
    return(indx_);
  } else {
    return (-1);
  }
}

// Event that checks if a key is pressed
void keyPressed() {
  if (keyCode == 32) {
    // In case the key pressed is the spacebar
    time = !time;
  } else if (keyCode == 82) {
    // In case the key pressed is "r"
    reset();
  }
}

// Changes the state of the cell clicked on the window
void mousePressed() {
  cells.get(indx(mouseX/cellsz, mouseY/cellsz)).change();
}
