import 'package:formz/formz.dart';

enum NameValidationError { empty }

class Name extends FormzInput<String, NameValidationError> {
 const Name.pure([String value = '']) : super.pure(value);
  const Name.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : NameValidationError.empty;
  }
}

extension on NameValidationError {
  String? text() {
    switch (this) {
      case NameValidationError.empty:
        return 'Please ensure the email entered is valid';
    }
  }
}
