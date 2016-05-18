//import 'dart:async';
import 'dart:html';

List<double> inputValues;
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

  //initialize input list
  inputValues = new List(9);

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
    inputValues[index] = null;
    convertButton.disabled = true;
    return;
  }
  var input = double.parse(inputS);
  inputValues[index] = input;
  if (inputValues.indexOf(null) == -1) {
    convertButton.disabled = false;
  }
}

void createREF(Event e) {
//  if (inputValues.indexOf(null) != -1) {
//    return;
//  }
  var subVal1 = inputValues[3] / inputValues[0];
  var subVal2 = inputValues[6] / inputValues[0];
  inputValues[3] += inputValues[0] * -subVal1;
  inputValues[4] += inputValues[1] * -subVal1;
  inputValues[5] += inputValues[2] * -subVal1;
  inputValues[6] += inputValues[0] * -subVal2;
  inputValues[7] += inputValues[1] * -subVal2;
  inputValues[8] += inputValues[2] * -subVal2;
  if (inputValues[4] == 0 && inputValues[7] != 0) {
    var in4 = inputValues[4];
    var in5 = inputValues[5];
    inputValues[4] = inputValues[7];
    inputValues[5] = inputValues[8];
    inputValues[7] = in4;
    inputValues[8] = in5;
  }
  if (inputValues[4] != 0) {
    var subVal3 = inputValues[7] / inputValues[4];
    inputValues[7] += inputValues[4] * -subVal3;
    inputValues[8] += inputValues[5] * -subVal3;
  }
  inputField1.value = '${inputValues[0]}';
  inputField2.value = '${inputValues[1]}';
  inputField3.value = '${inputValues[2]}';
  inputField4.value = '${inputValues[3]}';
  inputField5.value = '${inputValues[4]}';
  inputField6.value = '${inputValues[5]}';
  inputField7.value = '${inputValues[6]}';
  inputField8.value = '${inputValues[7]}';
  inputField9.value = '${inputValues[8]}';
}
