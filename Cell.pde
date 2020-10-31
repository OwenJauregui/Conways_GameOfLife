// Cell class that interacts with other cells for the 
// Conway's Game of Life simulation

class Cell {
  PVector place, // Row and column index
          pos; // X and y position on the window
  boolean alive = false, // Current state of the cell
          change = false; // State of the cell on next cicle

  // Cell constructor, giving it an x,y position and its column and row indexes
  Cell(int c_, int r_) {
    place = new PVector(c_, r_);
    pos = new PVector(c_*cellsz, r_*cellsz);
  }

  // Checks if the cell should change its state on the next cicle
  void check() {
    int neighbors = 0;
    // Looks for all its neighbours
    for (int n_r = 0; n_r < 3; n_r++) {
      for (int n_c = 0; n_c < 3; n_c++) {
        if (!(n_r == 1 && n_c == 1)) {
          // Makes sure the neighbors exists and that its not checking out of bounds
          if (indx(int(place.x + (n_c - 1)), int(place.y + (n_r - 1))) != -1) {
            // If the neighbours are alive, it increases the neighbour counter
            if (cells.get(indx(int(place.x + (n_c - 1)), int(place.y + (n_r - 1)))).alive) {
              neighbors++;
            }
          }
        }
      }
    }
    
    // Now, based on the rules from Conway's original automaton, checks if the cell
    // should change its "alive" state or not
    if ((!alive && neighbors == 3) || (alive && (neighbors < 2 || neighbors > 3))){
      change = true;
    } 
  }

  // Changes the "alive" state and makes change = false
  void change() {
    alive = !alive;
    change = false;
  }
  
  // Changes the "change" and "alive" states to the original false value
  void reset() {
    change = false;
    alive = false;
  }

  // Displays the cell on the window on its correct position
  void show() {
    // If its alive, it displays color blue, else, it displays with no fill
    if (alive) {
      fill(0, 0, 200);
    } else {
      noFill();
    }
    stroke(0);
    strokeWeight(3);
    rect(pos.x, pos.y, cellsz, cellsz);
  }
  
  // This method returns the state of "change"
  boolean getChange() {
    return (change);
  }
}
