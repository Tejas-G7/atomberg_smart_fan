import 'package:atomberg_smart_fan_controller/core/navigation/app_routes.dart';
import 'package:atomberg_smart_fan_controller/feature/auth_creds/presentation/bloc/auth_creds_bloc.dart';
import 'package:atomberg_smart_fan_controller/feature/auth_creds/presentation/bloc/auth_creds_event.dart';
import 'package:atomberg_smart_fan_controller/feature/auth_creds/presentation/bloc/auth_creds_state.dart';
import 'package:atomberg_smart_fan_controller/feature/auth_creds/view/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInputScreen extends StatefulWidget {
  const UserInputScreen({super.key});

  @override
  State<UserInputScreen> createState() => _UserInputScreenState();
}

class _UserInputScreenState extends State<UserInputScreen> {
  final TextEditingController _apiKeyController = TextEditingController();
  final TextEditingController _refreshTokenController = TextEditingController();

  @override
  void dispose() {
    _apiKeyController.dispose();
    _refreshTokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: PopScope(
        canPop: false,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: BlocConsumer<AuthCredsBloc, AuthCredsState>(
                      listener: (context, state) {
                        if (state is AuthCredsSuccessState) {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.smartFanScreen,
                          );
                        }
                        if(state is AuthCredsErrorState){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                        }
                      },
                      builder: (context, state) {
                        String? apiKeyError;
                        String? refreshTokenError;

                        if (state is AuthCredsFieldErrorState) {
                          apiKeyError = state.apiKeyError;
                          refreshTokenError = state.refreshTokenError;
                        }
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "ATOMBERG",
                              style: theme.textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 32),

                            CustomTextField(
                              controller: _apiKeyController,
                              label: "API Key",
                              errorText: apiKeyError,
                              onChanged: (value) {
                                context.read<AuthCredsBloc>().add(
                                  AuthCredsApiKey(value),
                                );
                              },
                            ),

                            const SizedBox(height: 16),

                            CustomTextField(
                              controller: _refreshTokenController,
                              label: "Refresh Token",
                              obscureText: true,
                              errorText: refreshTokenError,
                              onChanged: (value) {
                                context.read<AuthCredsBloc>().add(
                                  AuthCredsRefreshToken(value),
                                );
                              },
                            ),

                            const SizedBox(height: 32),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: state is AuthCredsLoadingState
                                    ? null
                                    : () {
                                        context.read<AuthCredsBloc>().add(
                                          AuthCredsSubmit(
                                            apiKey: _apiKeyController.text,
                                            refreshToken:
                                                _refreshTokenController.text,
                                          ),
                                        );
                                      },
                                child: state is AuthCredsLoadingState
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text("Proceed"),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
