@HtmlImport('main_app.html')
library dart_polymer.lib.main_app;

//import 'dart:async';
import 'dart:html';

import 'package:dartrix/matrix.dart';
import 'matrix_input_element.dart';
import 'matrix_element.dart';

import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/paper_checkbox.dart';

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

  Map<String, PaperCheckbox> checkboxes = new Map<String, PaperCheckbox>();

  static final List<String> options = ['ref', 'rref'];
  static final List<String> longOptions = [
    'Row Echelon Form',
    'Reduced Row Echelon Form'
  ];

  final NodeValidatorBuilder _htmlValidator = new NodeValidatorBuilder.common()
    ..allowElement('paper-checkbox', attributes: [
      'checked',
      'style',
      'aria-disabled',
      'aria-checked',
      'toggles',
      'tabIndex',
      'role'
    ]);

  void ready() {
    refButton = querySelector('#refbutton');
    buttons['ref'] = refButton;
    rrefButton = querySelector('#rrefbutton');
    buttons['rref'] = rrefButton;
    for (int i = 0; i < options.length; i++) {
      String opt = '${options[i]}-check';
      // I'm manually creating this html because .text seems to break the checkbox...
      checkboxes[opt] = new Element.html(
          '<paper-checkbox style="margin: 0.1em" id="$opt">${longOptions[i]}</paper-checkbox>',
          validator: _htmlValidator) as PaperCheckbox;
      querySelector('#checkboxes').append(checkboxes[opt]);
      querySelector('#checkboxes').append(new Element.br());
      checkboxes[opt].checked = true;
    }
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

  @Listen('iron-change')
  void changeOpt(event, [_]) {
    //window.console.log(event);
    String opt = event.target.id;
    String id = opt.substring(0, (opt.length - 6));
    Element opel = querySelector('#$id-element');
    opel.hidden = !checkboxes[opt].checked;
  }

  @reflectable
  void updateinputs(event, [_]) {
    buttons[event.detail as String].disabled = !complete[event.detail as String];
  }

  @reflectable
  void checkREF(event, [_]) {
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
  void checkRREF(event, [_]) {
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
