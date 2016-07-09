@HtmlImport('matrix_input_element.html')
library dart_polymer.lib.matrix_input_element;

//import 'dart:async';
import 'dart:html';

import 'package:dartrix/matrix.dart';

import 'package:polymer_elements/paper_input.dart';
import 'package:polymer_elements/iron_input.dart';
import 'package:polymer_elements/iron_signals.dart';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

Matrix matrix;
TableElement table;

/// Uses [PaperInput]
@PolymerRegister('matrix-input-element')
class MatrixInputElement extends PolymerElement {
  MatrixInputElement.created() : super.created();

  @property
  Map<String, List<List<double>>> inputs;

  @property
  Map<String, bool> complete;

  @property
  String name;

  ready() {
    print("$runtimeType::ready()");
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
        node.onInput.listen((Event e) => updateMVal(e, i, h));
        table.rows[i].cells[h].append(node);
      }
    }
    // Polymer keeps stuff in the shadow dom, so we need to look in there
    $['matrix'].append(table);
  }

  void updateMVal(Event e, int row, int col) {
    String inputS = (e.target as IronInput).value.trim();
    if (inputS.length == 0) {
      matrix.matrix[row][col] = null;
      print('firing');
      complete[name] = false;
      fire('iron-signal', detail: {'name': 'minputchange', 'data': name});
      return;
    }
    double input;
    try {
      input = double.parse(inputS);
    } catch (exception) {
      matrix.matrix[row][col] = null;
      print('firing');
      complete[name] = false;
      fire('iron-signal', detail: {'name': 'minputchange', 'data': name});
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
    print('firing');
    complete[name] = true;
    fire('iron-signal', detail: {'name': 'minputchange', 'data': name});
  }
}
