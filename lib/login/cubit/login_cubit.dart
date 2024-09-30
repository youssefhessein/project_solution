import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_solution/login/cubit/statues.dart';

class LoginCubit extends Cubit<LoginStatues> {
  LoginCubit() : super(LoginInitialStatues());

  static LoginCubit get(context) => BlocProvider.of(context);

  // Controllers for the login form fields
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // Password visibility toggle
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    emit(ChangePasswordStatue());
  }

  // "Remember Me" feature
  bool rememberMe = false;

  void changeRememberMe(bool value) {
    rememberMe = value;
    emit(ChangeRememberMeStatue());
  }

  // Login function
  void userLogin({required String email, required String password}) async {
    emit(LoginLoadingStatues());

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccessStatues());
    } catch (error) {
      emit(LoginErrorStatues(error.toString()));
    }
  }
}
