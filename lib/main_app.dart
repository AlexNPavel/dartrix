@HtmlImport('main_app.html')
library dart_polymer.lib.main_app;

//import 'dart:async';
import 'dart:html';

import 'package:dartrix/matrix.dart';

import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/paper_input.dart';
import 'package:polymer_elements/iron_input.dart';
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

  ready() {
    matrix = new Matrix(rowSize: 3, colSize: 3);
    table = new TableElement();
    table.classes.add('matrix');
    for (int i = 0; i < 3; i++) {
      table.addRow();
    }
    for (int i = 0; i < 3; i++) {
      for (int h = 0; h < 3; h++) {
        table.rows[i].addCell();
        PaperInput node = new PaperInput();
        node.onInput.listen((Event e) => updateREF(e, i, h));
        table.rows[i].cells[h].append(node);
      }
    }
    querySelector('#matrix').append(table);
    convertButton = querySelector('#button');
  }

  void updateREF(Event e, int row, int col) {
    String inputS = (e.target as IronInput).value.trim();
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
