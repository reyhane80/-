int board[8][8]; // شطرنج هزارتو
int moves = 0; // تعداد حرکات

void setup() {
  Serial.begin(9600);
  resetBoard();
  solveHorseTour(0, 0, 1);
}

void loop() {
  // اجرای الگوریتم حل مسأله هزارتو
}

void resetBoard() {
  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      board[i][j] = -1;
    }
  }
}

bool isSafe(int x, int y) {
  return (x >= 0 && x < 8 && y >= 0 && y < 8 && board[x][y] == -1);
}

bool solveHorseTour(int x, int y, int moveCount) {
  if (moveCount == 64) {
    // مسأله حل شده است
    printSolution();
    return true;
  }

  int xMove[8] = {2, 1, -1, -2, -2, -1, 1, 2};
  int yMove[8] = {1, 2, 2, 1, -1, -2, -2, -1};

  for (int k = 0; k < 8; k++) {
    int nextX = x + xMove[k];
    int nextY = y + yMove[k];
    if (isSafe(nextX, nextY)) {
      board[nextX][nextY] = moveCount;
      if (solveHorseTour(nextX, nextY, moveCount + 1)) {
        return true;
      } else {
        board[nextX][nextY] = -1; // Backtrack
      }
    }
  }

  return false;
}

void printSolution() {
  Serial.println("Solution found:");
  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      Serial.print(board[i][j]);
      Serial.print("\t");
    }
    Serial.println();
  }
}
