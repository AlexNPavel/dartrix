//import 'dart:async';
import 'dart:html';

import 'package:dartrix/matrix.dart';

Matrix matrix;
ButtonElement convertButton;
TableElement table;
InputElement inputField1;
InputElement inputField2;
InputElement inputField3;
InputElement inputField4;
InputElement inputField5;
InputElement inputField6;
InputElement inputField7;
InputElement inputField8;
InputElement inputField9;

main() {
  // We need to determine if the client is using http or https
  // and use the same protocol for the client stub requests
  // (the protocol includes the ':').
  var protocol = window.location.protocol;
  if (!['http:', 'https:'].contains(protocol)) {
    // Default to http if unknown protocol.
    protocol = 'http:';
  }

  matrix = new Matrix(rowSize: 3, colSize: 3);
  table = new TableElement();
  table.classes.add('matrix');
  for (int i = 0; i < 3; i++) {
    table.addRow();
  }
  for (int i = 0; i < 3; i++) {
    for (int h = 0; h < 3; h++) {
      table.rows[i].addCell();
      InputElement node = new InputElement(type: 'text');
      node.classes.add('input');
      node.onInput.listen((Event e) => updateREF(e, i, h));
      table.rows[i].cells[h].append(node);
      table.rows[i].cells[h].append(new SpanElement());
    }
  }
  querySelector('#matrix').append(table);

  convertButton = querySelector('#convertButton');
  convertButton.onClick.listen(createREF);
}

void updateREF(Event e, int row, int col) {
  String inputS = (e.target as InputElement).value.trim();
  if (inputS.length == 0) {
    matrix.matrix[row][col] = null;
    convertButton.disabled = true;
    return;
  }
  var input;
  try {
    input = double.parse(inputS);
  } catch (exception) {
    matrix.matrix[row][col] = null;
    convertButton.disabled = true;
    return;
  }
  matrix.matrix[row][col] = input;
  for (int i = 0; i < matrix.matrix.length; i++) {
    for (int h = 0; h < matrix.matrix[i].length; h++) {
      if (matrix.matrix[i][h] == null) {
        return;
      }
    }
  }
  // if no values are null, enable convertButton
  convertButton.disabled = false;
}

void createREF(Event e) {
//  if (inputValues.indexOf(null) != -1) {
//    return;
//  }
  matrix.convertREF();
  for (int i = 0; i < matrix.matrix.length; i++) {
    for (int h = 0; h < matrix.matrix[i].length; h++) {
      (table.rows[i].cells[h].childNodes[0] as InputElement).value =
          '${matrix.matrix[i][h]}';
    }
  }
}
