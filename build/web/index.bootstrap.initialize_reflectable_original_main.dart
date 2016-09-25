import 'package:initialize/src/static_loader.dart';
import 'package:initialize/initialize.dart';
import 'index.bootstrap.dart' as i0;
import 'package:polymer_interop/src/convert.dart' as i1;
import 'package:web_components/html_import_annotation.dart' as i2;
import 'package:polymer_interop/polymer_interop.dart' as i3;
import 'package:polymer_elements/roboto.dart' as i4;
import 'package:polymer_elements/iron_form_element_behavior.dart' as i5;
import 'package:polymer_elements/iron_control_state.dart' as i6;
import 'package:polymer_elements/iron_a11y_keys_behavior.dart' as i7;
import 'package:polymer_elements/paper_input_behavior.dart' as i8;
import 'package:polymer_elements/iron_meta.dart' as i9;
import 'package:web_components/custom_element_proxy.dart' as i10;
import 'package:polymer_elements/iron_validatable_behavior.dart' as i11;
import 'package:polymer_elements/iron_a11y_announcer.dart' as i12;
import 'package:polymer_elements/iron_input.dart' as i13;
import 'package:polymer_elements/paper_input_addon_behavior.dart' as i14;
import 'package:polymer_elements/typography.dart' as i15;
import 'package:polymer_elements/paper_input_char_counter.dart' as i16;
import 'package:polymer_elements/iron_flex_layout.dart' as i17;
import 'package:polymer_elements/color.dart' as i18;
import 'package:polymer_elements/default_theme.dart' as i19;
import 'package:polymer_elements/paper_input_container.dart' as i20;
import 'package:polymer_elements/paper_input_error.dart' as i21;
import 'package:polymer_elements/paper_input.dart' as i22;
import 'package:polymer_elements/iron_signals.dart' as i23;
import 'package:polymer/polymer_micro.dart' as i24;
import 'package:polymer/polymer_mini.dart' as i25;
import 'package:polymer/src/template/array_selector.dart' as i26;
import 'package:polymer/src/template/dom_bind.dart' as i27;
import 'package:polymer/src/template/dom_if.dart' as i28;
import 'package:polymer/src/template/dom_repeat.dart' as i29;
import 'package:polymer/polymer.dart' as i30;
import 'package:dartrix/matrix_input_element.dart' as i31;
import 'package:polymer/src/common/polymer_register.dart' as i32;
import 'package:dartrix/matrix_element.dart' as i33;
import 'package:polymer_elements/iron_button_state.dart' as i34;
import 'package:polymer_elements/paper_ripple.dart' as i35;
import 'package:polymer_elements/paper_ripple_behavior.dart' as i36;
import 'package:polymer_elements/paper_button_behavior.dart' as i37;
import 'package:polymer_elements/shadow.dart' as i38;
import 'package:polymer_elements/paper_material_shared_styles.dart' as i39;
import 'package:polymer_elements/paper_material.dart' as i40;
import 'package:polymer_elements/paper_button.dart' as i41;
import 'package:polymer_elements/paper_inky_focus_behavior.dart' as i42;
import 'package:polymer_elements/iron_checked_element_behavior.dart' as i43;
import 'package:polymer_elements/paper_checked_element_behavior.dart' as i44;
import 'package:polymer_elements/paper_checkbox.dart' as i45;
import 'package:dartrix/main_app.dart' as i46;

main() {
  initializers.addAll([
    new InitEntry(const i10.CustomElementProxy('iron-meta'), i9.IronMeta),
    new InitEntry(
        const i10.CustomElementProxy('iron-meta-query'), i9.IronMetaQuery),
    new InitEntry(const i10.CustomElementProxy('iron-a11y-announcer'),
        i12.IronA11yAnnouncer),
    new InitEntry(
        const i10.CustomElementProxy('iron-input', extendsTag: 'input'),
        i13.IronInput),
    new InitEntry(const i10.CustomElementProxy('paper-input-char-counter'),
        i16.PaperInputCharCounter),
    new InitEntry(const i10.CustomElementProxy('paper-input-container'),
        i20.PaperInputContainer),
    new InitEntry(
        const i10.CustomElementProxy('paper-input-error'), i21.PaperInputError),
    new InitEntry(const i10.CustomElementProxy('paper-input'), i22.PaperInput),
    new InitEntry(
        const i10.CustomElementProxy('iron-signals'), i23.IronSignals),
    new InitEntry(
        const i10.CustomElementProxy('array-selector'), i26.ArraySelector),
    new InitEntry(
        const i10.CustomElementProxy('dom-bind', extendsTag: 'template'),
        i27.DomBind),
    new InitEntry(
        const i10.CustomElementProxy('dom-if', extendsTag: 'template'),
        i28.DomIf),
    new InitEntry(
        const i10.CustomElementProxy('dom-repeat', extendsTag: 'template'),
        i29.DomRepeat),
    new InitEntry(const i32.PolymerRegister('matrix-input-element'),
        i31.MatrixInputElement),
    new InitEntry(
        const i32.PolymerRegister('matrix-element'), i33.MatrixElement),
    new InitEntry(
        const i10.CustomElementProxy('paper-ripple'), i35.PaperRipple),
    new InitEntry(
        const i10.CustomElementProxy('paper-material'), i40.PaperMaterial),
    new InitEntry(
        const i10.CustomElementProxy('paper-button'), i41.PaperButton),
    new InitEntry(
        const i10.CustomElementProxy('paper-checkbox'), i45.PaperCheckbox),
    new InitEntry(const i32.PolymerRegister('main-app'), i46.MainApp),
  ]);

  return i0.main();
}
