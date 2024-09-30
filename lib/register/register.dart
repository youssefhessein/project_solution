import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_solution/register/cubit/register_cubit.dart';
import 'package:project_solution/register/cubit/statues.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<RegisterCubit, RegisterStatues>(
            listener: (context, state) {
              if (state is RegisterErrorStatues) {
                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
              if (state is RegisterSuccessStatues) {
                // Navigate to another screen on success
              }
            },
            builder: (context, state) {
              var cubit = RegisterCubit.get(context);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Register new account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 50,
                    height: 3,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: cubit.emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: cubit.passwordController,
                    obscureText: cubit.isPassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          cubit.isPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          cubit.changePasswordVisibility();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: cubit.confirmPasswordController,
                    obscureText: cubit.isConfirmPassword,
                    decoration: InputDecoration(
                      labelText: 'Password Confirmation',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          cubit.isConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          cubit.changeConfirmPasswordVisibility();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    children: [
                      Checkbox(
                        value: cubit.acceptTerms,
                        onChanged: (bool? value) {
                          cubit.changeAcceptTerms(value!);
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle Terms and Conditions
                        },
                        child: const Text(
                          'By creating an account, you agree to our Terms & Conditions',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      cubit.userRegister(
                        email: cubit.emailController.text,
                        password: cubit.passwordController.text,
                        confirmPassword: cubit.confirmPasswordController.text,
                      );
                    },
                    child: const Text('Register'),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
