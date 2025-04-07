part of 'passwords_generator_bloc.dart';

sealed class PasswordsGeneratorState {}

final class PasswordsGeneratorInitial extends PasswordsGeneratorState {}

final class PasswordsGeneratorLoadSuccess extends PasswordsGeneratorState {
  final PasswordData passwordData;

  PasswordsGeneratorLoadSuccess({required this.passwordData});
}
