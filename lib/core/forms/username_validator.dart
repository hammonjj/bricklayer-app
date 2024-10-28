import 'package:formz/formz.dart';

enum UsernameValidationError { empty }

class UsernameValidator extends FormzInput<String, UsernameValidationError> {
  const UsernameValidator.pure() : super.pure('');
  const UsernameValidator.dirty([super.value = '']) : super.dirty();

  @override
  UsernameValidationError? validator(String value) {
    if (value.isEmpty) {
      return UsernameValidationError.empty;
    }

    return null;
  }
}
