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

PaperButton refButton, rrefButton;
TableElement table;

/// Uses [PaperButton]
@PolymerRegister('main-app')
class MainApp extends PolymerElement {
  /// Constructor used to create instance of MainApp.
  MainApp.created() : super.created();

  Matrix matrixA = new Matrix();

  @property
  Map<String, List<List<double>>> inputs =
      new Map<String, List<List<double>>>();

  @property
  Map<String, bool> complete = new Map<String, bool>();

  @property
  List<List<double>> mainA = [];

  @property
  List<List<double>> ref = [];

  @property
  List<List<double>> rref = [];

  Map<String, PaperButton> buttons = new Map<String, PaperButton>();

  void ready() {
    refButton = querySelector('#refbutton');
    buttons['ref'] = refButton;
    rrefButton = querySelector('#rrefbutton');
    buttons['rref'] = rrefButton;
    matrixA.randomize();
//    matrixA.calculateAll();
    for (int i = 0; i < matrixA.matrix.length; i++) {
      mainA.insert(i, []);
      for (int h = 0; h < matrixA.matrix[i].length; h++) {
        mainA[i].insert(h, matrixA.matrix[i][h]);
      }
    }
    fire('iron-signal', detail: {'name': 'tablechange', 'data': 'mainA'});
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
    matrixA.convertREF();
    ref.clear();
    for (int i = 0; i < inputs['ref'].length; i++) {
      ref.insert(i, []);
      for (int h = 0; h < inputs['ref'][i].length; h++) {
        ref[i].insert(h, inputs['ref'][i][h]);
      }
    }
    if (Matrix.equals(matrixA.ref, ref)) {
      querySelector('#ref-correct').text = 'Correct!';
      querySelector('#ref-correct').style.color = 'green';
    } else {
      querySelector('#ref-correct').text = 'Incorrect!';
      querySelector('#ref-correct').style.color = 'red';
    }
    querySelector('#ref-correct').classes.toggle('fade-in', true);
  }

  @reflectable
  void createRREF(event, [_]) {
    matrixA.convertRREF();
    rref.clear();
    for (int i = 0; i < inputs['rref'].length; i++) {
      rref.insert(i, []);
      for (int h = 0; h < inputs['rref'][i].length; h++) {
        rref[i].insert(h, inputs['rref'][i][h]);
      }
    }
    if (Matrix.equals(matrixA.rref, rref)) {
      querySelector('#rref-correct').text = 'Correct!';
      querySelector('#rref-correct').style.color = 'green';
    } else {
      querySelector('#rref-correct').text = 'Incorrect!';
      querySelector('#rref-correct').style.color = 'red';
    }
    querySelector('#rref-correct').classes.toggle('fade-in', true);
  }
}