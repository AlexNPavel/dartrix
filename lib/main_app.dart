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

Matrix matrix;
PaperButton convertButton;
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

  ready() {
    convertButton = querySelector('#button');
  }

  @reflectable
  void updateinputs(event, [_]) {
    if (complete[event.detail as String] == true) {
      convertButton.disabled = false;
    } else {
      convertButton.disabled = true;
    }
  }

  @reflectable
  void createREF(event, [_]) {
//  if (inputValues.indexOf(null) != -1) {
//    return;
//  }
    matrix = new Matrix();
    for (int i = 0; i < inputs['ref'].length; i++) {
      for (int h = 0; h < inputs['ref'][i].length; h++) {
        matrix.matrix[i][h] = inputs['ref'][i][h];
      }
    }
    matrix.convertREF();
    for (int i = 0; i < matrix.matrix.length; i++) {
      ref.insert(i, []);
      for (int h = 0; h < matrix.matrix[i].length; h++) {
        ref[i].insert(h, matrix.matrix[i][h]);
      }
    }
    fire('iron-signal', detail: {'name': 'tablechange', 'data': 'ref'});
    querySelector('#refmat').hidden = false;
  }
}
