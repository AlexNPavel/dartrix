library dartrix.matrix;

class Matrix {
  int rowSize, colSize;
  List<List> matrix;

  // optionally create with rowsize and colsize set
  Matrix({this.rowSize: 3, this.colSize: 3}) {
    matrix = [];
    matrix.length = rowSize;
    for (int i = 0; i < matrix.length; i++) {
      matrix[i] = [];
    }
    matrix.forEach((List l) => l.length = colSize);
  }

  void setRowSize(int rows) {
    var change = -1;
    if (rows > rowSize) {
      change = rows - rowSize;
    }
    matrix.length = rows;
    if (change > 0) {
      for (int i = rows - change - 1; i < matrix.length; i++) {
        matrix[i] = [];
      }
    }
  }

  void setColSize(int columns) {
    matrix.forEach((List l) => l.length = columns);
  }

  void convertREF() {
    var focusRow = 0, focusCol = 0;
    top: while (focusRow < rowSize) {
      if (matrix[focusRow][focusCol] == 0) {
        var scanRow;
        for (scanRow = focusRow; matrix[scanRow][focusCol] == 0; scanRow++) {
          if (scanRow >= rowSize - 1) {
            focusCol++;
            if (focusCol >= colSize) {
              break top;
            }
            scanRow = focusRow;
          }
        }
        List temp = matrix[scanRow];
        matrix[scanRow] = matrix[focusRow];
        matrix[focusRow] = temp;
      }
      for (int i = focusRow + 1; i < matrix.length; i++) {
        print('focusRow: {$focusRow}, focusCol{$focusCol}');
        addRow(matrix[focusRow], matrix[i],
            -matrix[i][focusCol] / matrix[focusRow][focusCol]);
      }
      focusRow++;
      focusCol++;
    }
    //end top loop
  }

  void addRow(List srcRow, List destRow, double scale) {
    for (int i = 0; i < srcRow.length; i++) {
      destRow[i] += srcRow[i] * scale;
    }
  }
}
