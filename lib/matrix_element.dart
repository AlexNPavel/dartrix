@HtmlImport('matrix_element.html')
library dart_polymer.lib.matrix_element;

import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_input.dart';
import 'package:web_components/web_components.dart';

TableElement table;

/// Uses [PaperInput]
@PolymerRegister('matrix-element')
class MatrixElement extends PolymerElement {
  MatrixElement.created() : super.created();

  @property
  List<List<double>> data;

  @property
  String name;

  ready() {
    table = new TableElement();
    table.classes.add('matrix');
    for (int i = 0; i < 3; i++) {
      table.addRow();
    }
    for (int i = 0; i < 3; i++) {
      for (int h = 0; h < 3; h++) {
        table.rows[i].addCell();
        PaperInput node = new PaperInput();
        node.value = '';
        node.readonly = true;
        table.rows[i].cells[h].append(node);
      }
    }
    // Polymer keeps stuff in the shadow dom, so we need to look in there
    $['matrix'].append(table);
  }

  @reflectable
  void updateMatrix(event, [_]) {
    if (event.detail != name) {
      return;
    }
    for (int i = 0; i < data.length; i++) {
      for (int h = 0; h < data[i].length; h++) {
        (table.rows[i].cells[h].firstChild as PaperInput).value =
            '${data[i][h]}';
      }
    }
  }
}
