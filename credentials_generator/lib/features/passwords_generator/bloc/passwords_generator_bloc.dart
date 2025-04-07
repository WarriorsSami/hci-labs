import 'package:credentials_generator/features/passwords_generator/models/password_data.dart';
import 'package:credentials_generator/features/passwords_generator/models/password_settings.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:random_string_generator/random_string_generator.dart';

part 'passwords_generator_event.dart';
part 'passwords_generator_state.dart';

class PasswordsGeneratorBloc
    extends Bloc<PasswordsGeneratorEvent, PasswordsGeneratorState>
    with HydratedMixin<PasswordsGeneratorState> {
  PasswordsGeneratorBloc() : super(PasswordsGeneratorInitial()) {
    hydrate();
    on<PasswordsGeneratorSettingsChanged>(_onSettingsChanged);
  }

  void _onSettingsChanged(
    PasswordsGeneratorSettingsChanged event,
    Emitter<PasswordsGeneratorState> emit,
  ) {
    final passwordData = PasswordData(
      password: _generatePassword(event.passwordSettings),
      settings: event.passwordSettings,
    );

    emit(PasswordsGeneratorLoadSuccess(passwordData: passwordData));
  }

  String _generatePassword(PasswordSettings settings) {
    final generator = RandomStringGenerator(
      hasAlpha: true,
      alphaCase:
          settings.includeUppercase
              ? AlphaCase.MIXED_CASE
              : AlphaCase.LOWERCASE_ONLY,
      hasDigits: settings.includeNumbers,
      hasSymbols: settings.includeSpecialCharacters,
      fixedLength: settings.length,
      mustHaveAtLeastOneOfEach: true,
    );

    return generator.generate();
  }

  @override
  PasswordsGeneratorState? fromJson(Map<String, dynamic> json) {
    try {
      return PasswordsGeneratorLoadSuccess(
        passwordData: PasswordData.fromJson(json),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(PasswordsGeneratorState state) {
    if (state is PasswordsGeneratorLoadSuccess) {
      return state.passwordData.toJson();
    }
    return null;
  }
}
