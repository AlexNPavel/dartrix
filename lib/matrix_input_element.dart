@HtmlImport('matrix_input_element.html')
library dart_polymer.lib.matrix_input_element;

//import 'dart:async';
import 'dart:html';

import 'package:polymer_elements/paper_input.dart';
import 'package:polymer_elements/iron_input.dart';
import 'package:polymer_elements/iron_signals.dart';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

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
    inputs[name] = [];
    inputs[name].length = 3;
    table = new TableElement();
    table.classes.add('matrix');
    for (int i = 0; i < 3; i++) {
      table.addRow();
      inputs[name][i] = [];
      inputs[name][i].length = 3;
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
      inputs[name][row][col] = null;
      print('firing');
      complete[name] = false;
      fire('iron-signal', detail: {'name': 'minputchange', 'data': name});
      return;
    }
    double input;
    try {
      input = double.parse(inputS);
    } catch (exception) {
      inputs[name][row][col] = null;
      print('firing');
      complete[name] = false;
      fire('iron-signal', detail: {'name': 'minputchange', 'data': name});
      return;
    }
    inputs[name][row][col] = input;
    for (int i = 0; i < inputs[name].length; i++) {
      for (int h = 0; h < inputs[name][i].length; h++) {
        if (inputs[name][i][h] == null) {
          return;
        }
      }
    }
    print('firing');
    complete[name] = true;
    fire('iron-signal', detail: {'name': 'minputchange', 'data': name});
  }
}
