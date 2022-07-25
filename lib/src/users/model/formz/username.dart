import 'package:formz/formz.dart';

enum UsernameValidationError { empty }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : UsernameValidationError.empty;
  }
}

extension on UsernameValidationError {
  String? text() {
    switch (this) {
      case UsernameValidationError.empty:
        return 'Username tidak boleh kosong!';
      default:
        return null;
    }
  }
}
