import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

const NUMBER_VALIDATOR =  Provider(NG_VALIDATORS,
                                        useExisting: NumberValidator,
                                        multi: true);

@Directive(
  selector: "[type=number]",
  providers: [NUMBER_VALIDATOR]
)
class NumberValidator implements Validator {
  static Map<String, String> errorMsg = {"value_error": "Enter a number"};

  Map<String, String> validate(AbstractControl control) {

    final value = control.value;
    if (value == null || num.tryParse(value) == null) {
      return errorMsg;
    }
    return null;
  }
}
