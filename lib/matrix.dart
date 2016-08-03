library dartrix.matrix;

import 'dart:math' show Random;

class Matrix {
  int rowSize, colSize;
  List<List<double>> matrix = [];
  List<List<double>> ref = [];
  List<List<double>> rref = [];

  // optionally create with rowsize and colsize set
  Matrix({this.rowSize: 3, this.colSize: 3}) {
    matrix.length = rowSize;
    for (int i = 0; i < matrix.length; i++) {
      matrix[i] = [];
    }
    matrix.forEach((List l) => l.length = colSize);
  }

  bool equals(List<List<double>> other) {
    if (matrix.length != other.length || matrix[0].length != other[0].length) {
      return false;
    }
    for (int i = 0; i < matrix.length; i++) {
      for (int h = 0; h < matrix[i].length; h++) {
        if (matrix[i][h] != other[i][h]) {
          return false;
        }
      }
    }
    return true;
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

  void randomize({maxInt: 10}) {
    ref = [];
    rref = [];
    for (int i = 0; i < matrix.length; i++) {
      for (int h = 0; h < matrix[i].length; h++) {
        matrix[i][h] = new Random.secure().nextInt(10).toDouble();
      }
    }
  }

  void calculateAll() {
    convertREF();
    convertRREF();
  }

  void convertREF() {
    ref.clear();
    ref.length = matrix.length;
    for (int i = 0; i < matrix.length; i++) {
      ref[i] = [];
      ref[i].length = matrix[i].length;
      for (int h = 0; h < matrix[i].length; h++) {
        ref[i][h] = matrix[i][h];
      }
    }
    var focusRow = 0, focusCol = 0;
    top: while (focusRow < rowSize) {
      if (ref[focusRow][focusCol] == 0) {
        var scanRow;
        for (scanRow = focusRow; ref[scanRow][focusCol] == 0; scanRow++) {
          if (scanRow >= rowSize - 1) {
            focusCol++;
            if (focusCol >= colSize) {
              break top;
            }
            scanRow = focusRow;
          }
        }
        List<double> temp = ref[scanRow];
        ref[scanRow] = ref[focusRow];
        ref[focusRow] = temp;
      }
      scaleRow(ref[focusRow], ref[focusRow][focusCol]);
      for (int i = focusRow + 1; i < ref.length; i++) {
        addRow(
            ref[focusRow], ref[i], -ref[i][focusCol] / ref[focusRow][focusCol]);
      }
      focusRow++;
      focusCol++;
    }
    //end top loop
  }

  void addRow(List srcRow, List destRow, double scale) {
    for (int i = 0; i < srcRow.length; i++) {
      destRow[i] += srcRow[i] * scale;
      if (destRow[i] == 0 && destRow[i].isNegative) {
        destRow[i] = 0.toDouble();
      }
    }
  }

  void scaleRow(List<double> row, double scale) {
    if (scale == 0) {
      return;
    }
    for (int i = 0; i < row.length; i++) {
      row[i] /= scale;
      if (row[i] == 0 && row[i].isNegative) {
        row[i] = 0.toDouble();
      }
    }
  }

  void convertRREF() {
    if (ref.length != matrix.length) {
      convertREF();
    }
    rref.clear();
    rref.length = ref.length;
    for (int i = 0; i < ref.length; i++) {
      rref[i] = [];
      rref[i].length = ref[i].length;
      for (int h = 0; h < ref[i].length; h++) {
        rref[i][h] = ref[i][h];
      }
    }
    for (int i = rref.length - 1; i >= 0; i--) {
      int h;
      for (h = 0; h < rref.length - 1 && rref[i][h] == 0; h++) {}
      scaleRow(rref[i], rref[i][h]);
      int j;
      for (j = i - 1; j >= 0; j--) {
        if (rref[i][h] != 0) {
          addRow(rref[i], rref[j], -rref[j][h] / rref[i][h]);
        }
      }
    }
  }
}
