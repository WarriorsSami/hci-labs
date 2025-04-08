import 'package:credentials_generator/features/passwords_generator/bloc/passwords_generator_bloc.dart';
import 'package:credentials_generator/features/passwords_generator/models/password_settings.dart'
    show PasswordSettings;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordsGeneratorPage extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();

  PasswordsGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.password),
            SizedBox(width: 10),
            Text(
              "Passwords Generator",
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
        SizedBox(height: 20),
        BlocConsumer<PasswordsGeneratorBloc, PasswordsGeneratorState>(
          listener: (context, state) {
            if (state is PasswordsGeneratorLoadSuccess) {
              passwordController.text = state.passwordData.password;
            }
          },
          builder:
              (context, state) => SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: TextField(
                            maxLines: 1,
                            decoration: InputDecoration(
                              labelText: "Generated Password",
                              border: OutlineInputBorder(),
                            ),
                            controller: passwordController,
                            readOnly: true,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.copy),
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: passwordController.text),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Flexible(
                          child: Slider(
                            value:
                                state is PasswordsGeneratorLoadSuccess
                                    ? state.passwordData.settings.length
                                        .toDouble()
                                    : 12,
                            min: 8,
                            max: 32,
                            divisions: 24,
                            label:
                                state is PasswordsGeneratorLoadSuccess
                                    ? state.passwordData.settings.length
                                        .toString()
                                    : "12",
                            onChanged: (value) {
                              if (state is PasswordsGeneratorLoadSuccess) {
                                context.read<PasswordsGeneratorBloc>().add(
                                  PasswordsGeneratorSettingsChanged(
                                    passwordSettings: state
                                        .passwordData
                                        .settings
                                        .copyWith(length: value.toInt()),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value:
                                      state is PasswordsGeneratorLoadSuccess
                                          ? state
                                              .passwordData
                                              .settings
                                              .includeUppercase
                                          : true,
                                  onChanged: (value) {
                                    if (state
                                        is PasswordsGeneratorLoadSuccess) {
                                      context
                                          .read<PasswordsGeneratorBloc>()
                                          .add(
                                            PasswordsGeneratorSettingsChanged(
                                              passwordSettings: state
                                                  .passwordData
                                                  .settings
                                                  .copyWith(
                                                    includeUppercase:
                                                        value ?? false,
                                                  ),
                                            ),
                                          );
                                    }
                                  },
                                ),
                                Text("Include Uppercase"),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value:
                                      state is PasswordsGeneratorLoadSuccess
                                          ? state
                                              .passwordData
                                              .settings
                                              .includeNumbers
                                          : true,
                                  onChanged: (value) {
                                    if (state
                                        is PasswordsGeneratorLoadSuccess) {
                                      context
                                          .read<PasswordsGeneratorBloc>()
                                          .add(
                                            PasswordsGeneratorSettingsChanged(
                                              passwordSettings: state
                                                  .passwordData
                                                  .settings
                                                  .copyWith(
                                                    includeNumbers:
                                                        value ?? false,
                                                  ),
                                            ),
                                          );
                                    }
                                  },
                                ),
                                Text("Include Numbers"),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value:
                                      state is PasswordsGeneratorLoadSuccess
                                          ? state
                                              .passwordData
                                              .settings
                                              .includeSpecialCharacters
                                          : true,
                                  onChanged: (value) {
                                    if (state
                                        is PasswordsGeneratorLoadSuccess) {
                                      context
                                          .read<PasswordsGeneratorBloc>()
                                          .add(
                                            PasswordsGeneratorSettingsChanged(
                                              passwordSettings: state
                                                  .passwordData
                                                  .settings
                                                  .copyWith(
                                                    includeSpecialCharacters:
                                                        value ?? false,
                                                  ),
                                            ),
                                          );
                                    }
                                  },
                                ),
                                Text("Include Special Characters"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        final passwordSettings =
                            state is PasswordsGeneratorLoadSuccess
                                ? state.passwordData.settings
                                : PasswordSettings(
                                  length: 12,
                                  includeUppercase: true,
                                  includeNumbers: true,
                                  includeSpecialCharacters: true,
                                );

                        context.read<PasswordsGeneratorBloc>().add(
                          PasswordsGeneratorSettingsChanged(
                            passwordSettings: passwordSettings,
                          ),
                        );
                      },
                      style: Theme.of(context).elevatedButtonTheme.style,
                      child: Text("Generate Password"),
                    ),
                  ],
                ),
              ),
        ),
      ],
    );
  }
}
