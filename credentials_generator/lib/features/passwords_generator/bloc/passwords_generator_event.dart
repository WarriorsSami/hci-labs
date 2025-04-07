part of 'passwords_generator_bloc.dart';

sealed class PasswordsGeneratorEvent {}

final class PasswordsGeneratorSettingsChanged extends PasswordsGeneratorEvent {
  final PasswordSettings passwordSettings;

  PasswordsGeneratorSettingsChanged({required this.passwordSettings});
}
