@HtmlImport('main_app.html')
library dart_polymer.lib.main_app;

//import 'dart:async';
import 'dart:html';

import 'package:dartrix/matrix.dart';
import 'matrix_input_element.dart';
import 'matrix_element.dart';

import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/paper_input.dart';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

Matrix matrixA;
PaperButton refButton, rrefButton;
TableElement table;

/// Uses [PaperButton]
@PolymerRegister('main-app')
class MainApp extends PolymerElement {
  /// Constructor used to create instance of MainApp.
  MainApp.created() : super.created();

  @property
  Map<String, List<List<double>>> inputs =
      new Map<String, List<List<double>>>();

  @property
  Map<String, bool> complete = new Map<String, bool>();

  @property
  List<List<double>> ref = [];

  @property
  List<List<double>> rref = [];

  Map<String, PaperButton> buttons = new Map<String, PaperButton>();

  ready() {
    refButton = querySelector('#refbutton');
    buttons['ref'] = refButton;
    rrefButton = querySelector('#rrefbutton');
    buttons['rref'] = rrefButton;
    matrixA = new Matrix();
  }

  @reflectable
  void updateinputs(event, [_]) {
    if (complete[event.detail as String] == true) {
      buttons[event.detail as String].disabled = false;
    } else {
      buttons[event.detail as String].disabled = true;
    }
  }

  @reflectable
  void createREF(event, [_]) {
//  if (inputValues.indexOf(null) != -1) {
//    return;
//  }
    for (int i = 0; i < inputs['ref'].length; i++) {
      for (int h = 0; h < inputs['ref'][i].length; h++) {
        matrixA.matrix[i][h] = inputs['ref'][i][h];
      }
    }
    matrixA.convertREF();
    ref.clear();
    for (int i = 0; i < matrixA.matrix.length; i++) {
      ref.insert(i, []);
      for (int h = 0; h < matrixA.matrix[i].length; h++) {
        ref[i].insert(h, matrixA.ref[i][h]);
      }
    }
    fire('iron-signal', detail: {'name': 'tablechange', 'data': 'ref'});
    querySelector('#refmat').hidden = false;
  }

  @reflectable
  void createRREF(event, [_]) {
//  if (inputValues.indexOf(null) != -1) {
//    return;
//  }
    for (int i = 0; i < inputs['rref'].length; i++) {
      for (int h = 0; h < inputs['rref'][i].length; h++) {
        matrixA.matrix[i][h] = inputs['rref'][i][h];
      }
    }
    matrixA.convertRREF();
    rref.clear();
    for (int i = 0; i < matrixA.matrix.length; i++) {
      rref.insert(i, []);
      for (int h = 0; h < matrixA.rref[i].length; h++) {
        rref[i].insert(h, matrixA.rref[i][h]);
      }
    }
    fire('iron-signal', detail: {'name': 'tablechange', 'data': 'rref'});
    querySelector('#rrefmat').hidden = false;
  }
}
