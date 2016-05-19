//import 'dart:async';
import 'dart:html';

import 'package:dartrix/matrix.dart';

Matrix matrix;
ButtonElement convertButton;
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

  // initialize the input fields
  inputField1 = querySelector('#inputName1');
  inputField2 = querySelector('#inputName2');
  inputField3 = querySelector('#inputName3');
  inputField4 = querySelector('#inputName4');
  inputField5 = querySelector('#inputName5');
  inputField6 = querySelector('#inputName6');
  inputField7 = querySelector('#inputName7');
  inputField8 = querySelector('#inputName8');
  inputField9 = querySelector('#inputName9');
  // activate the input listeners
  inputField1.onInput.listen((Event e) => updateREF(e, 0));
  inputField2.onInput.listen((Event e) => updateREF(e, 1));
  inputField3.onInput.listen((Event e) => updateREF(e, 2));
  inputField4.onInput.listen((Event e) => updateREF(e, 3));
  inputField5.onInput.listen((Event e) => updateREF(e, 4));
  inputField6.onInput.listen((Event e) => updateREF(e, 5));
  inputField7.onInput.listen((Event e) => updateREF(e, 6));
  inputField8.onInput.listen((Event e) => updateREF(e, 7));
  inputField9.onInput.listen((Event e) => updateREF(e, 8));
  // enable the input fields
  inputField1.disabled = false; //enable
  inputField2.disabled = false; //enable
  inputField3.disabled = false; //enable
  inputField4.disabled = false; //enable
  inputField5.disabled = false; //enable
  inputField6.disabled = false; //enable
  inputField7.disabled = false; //enable
  inputField8.disabled = false; //enable
  inputField9.disabled = false; //enable

  convertButton = querySelector('#convertButton');
  convertButton.onClick.listen(createREF);
}

void updateREF(Event e, int index) {
  String inputS = (e.target as InputElement).value.trim();
  if (inputS.length == 0) {
    matrix.matrix[index ~/ 3][index%3] = null;
    convertButton.disabled = true;
    return;
  }
  var input;
  try {
    input = double.parse(inputS);
  } catch(exception) {
    matrix.matrix[index ~/ 3][index%3] = null;
    convertButton.disabled = true;
    return;
  }
  matrix.matrix[index ~/ 3][index%3] = input;
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
  inputField1.value = '${matrix.matrix[0][0]}';
  inputField2.value = '${matrix.matrix[0][1]}';
  inputField3.value = '${matrix.matrix[0][2]}';
  inputField4.value = '${matrix.matrix[1][0]}';
  inputField5.value = '${matrix.matrix[1][1]}';
  inputField6.value = '${matrix.matrix[1][2]}';
  inputField7.value = '${matrix.matrix[2][0]}';
  inputField8.value = '${matrix.matrix[2][1]}';
  inputField9.value = '${matrix.matrix[2][2]}';
}
