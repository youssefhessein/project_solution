import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_solution/login/cubit/login_cubit.dart';
import 'package:project_solution/login/cubit/statues.dart';
import 'package:project_solution/register/register.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<LoginCubit, LoginStatues>(
            listener: (context, state) {
              if (state is LoginErrorStatues) {
                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
              if (state is LoginSuccessStatues) {
                // Navigate to another screen on success
              }
            },
            builder: (context, state) {
              var cubit = LoginCubit.get(context);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login to your account',
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
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: cubit.rememberMe,
                        onChanged: (bool? value) {
                          cubit.changeRememberMe(value!);
                        },
                      ),
                      const Text('Remember me'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      cubit.userLogin(
                        email: cubit.emailController.text,
                        password: cubit.passwordController.text,
                      );
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 20),

                  // OR in the center of a line
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.grey),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.login, color: Colors.grey),
                        SizedBox(width: 10),
                        Text(
                          'Login with Google',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()),
                          );
                        },
                        child: const Text('Register'),
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
