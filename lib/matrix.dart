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
    for (int i = 0; i < matrix.length; i++) {
      for (int h = 0; h < matrix[i].length; h++) {
        matrix[i][h] = new Random.secure().nextInt(10).toDouble();
      }
    }
  }

  void convertREF() {
    ref.length = matrix.length;
    for (int i = 0; i < matrix.length; i++) {
      ref[i].length = matrix[i].length;
      for (int h = 0; h < matrix[i].length; i++) {
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
        List temp = ref[scanRow];
        ref[scanRow] = ref[focusRow];
        ref[focusRow] = temp;
      }
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
    }
  }

  void scaleRow(List row, double scale) {
    if (scale == 0) {
      print('Divide by zero on scaleRow!!');
      return;
    }
    for (int i = 0; i < row.length; i++) {
      row[i] /= scale;
    }
  }

  void convertRREF() {
    if (ref.length != matrix.length) {
      convertREF();
    }
    for (int i = 0; i < ref.length; i++) {
      rref[i].length = ref[i].length;
      for (int h = 0; h < ref[i].length; i++) {
        rref[i][h] = ref[i][h];
      }
    }
    for (int i = rref.length - 1; i >= 0; i--) {
      int h;
      for (h = 0; h < rref.length && rref[h] == 0; h++) {}
      scaleRow(rref[i], rref[i][h]);
      int j;
      for (j = i - 1; j >= 0; j--) {
        addRow(rref[i], rref[j], -rref[j][h] / rref[i][h]);
      }
    }
  }
}
