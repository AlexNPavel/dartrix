@HtmlImport('main_app.html')
library dart_polymer.lib.main_app;

//import 'dart:async';
import 'dart:html';

import 'package:dartrix/matrix.dart';
import 'matrix_input_element.dart';

import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/paper_input.dart';
import 'package:polymer_elements/iron_input.dart';
import 'package:polymer_elements/iron_meta.dart';
import 'package:polymer_elements/iron_signals.dart';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

Matrix matrix;
PaperButton convertButton;
TableElement table;

/// Uses [PaperInput]
/// Uses [PaperButton]
@PolymerRegister('main-app')
class MainApp extends PolymerElement {
  /// Constructor used to create instance of MainApp.
  MainApp.created() : super.created();

  IronMeta meta = new IronMeta();

  Map<String, List<List<double>>> inputs =
      new Map<String, List<List<double>>>();
  Map<String, bool> complete = new Map<String, bool>();

  ready() {
    meta.key = 'input';
    meta.value = inputs;
    meta.key = 'complete';
    meta.value = complete;
    convertButton = querySelector('#button');
  }

  @reflectable
  void updateinputs(event, [_]) {
    print('caught fire');
    print(event);
  }

  @reflectable
  void createREF(event, [_]) {
//  if (inputValues.indexOf(null) != -1) {
//    return;
//  }
    matrix.convertREF();
    for (int i = 0; i < matrix.matrix.length; i++) {
      for (int h = 0; h < matrix.matrix[i].length; h++) {
        (table.rows[i].cells[h].childNodes[0] as PaperInput).value =
            '${matrix.matrix[i][h]}';
      }
    }
  }
}
