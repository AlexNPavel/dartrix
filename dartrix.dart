//import 'dart:async';
import 'dart:html';

main() {
  // We need to determine if the client is using http or https
  // and use the same protocol for the client stub requests
  // (the protocol includes the ':').
  var protocol = window.location.protocol;
  if (!['http:', 'https:'].contains(protocol)) {
    // Default to http if unknown protocol.
    protocol = 'http:';
  }

  InputElement inputField1 = querySelector('#inputName1');
  InputElement inputField2 = querySelector('#inputName2');
  InputElement inputField3 = querySelector('#inputName3');
  InputElement inputField4 = querySelector('#inputName4');
  InputElement inputField5 = querySelector('#inputName5');
  InputElement inputField6 = querySelector('#inputName6');
  InputElement inputField7 = querySelector('#inputName7');
  InputElement inputField8 = querySelector('#inputName8');
  InputElement inputField9 = querySelector('#inputName9');
  inputField1.disabled = false; //enable
  inputField2.disabled = false; //enable
  inputField3.disabled = false; //enable
  inputField4.disabled = false; //enable
  inputField5.disabled = false; //enable
  inputField6.disabled = false; //enable
  inputField7.disabled = false; //enable
  inputField8.disabled = false; //enable
  inputField9.disabled = false; //enable
}
