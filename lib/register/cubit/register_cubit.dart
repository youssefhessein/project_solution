import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_solution/register/cubit/statues.dart';

class RegisterCubit extends Cubit<RegisterStatues> {
  RegisterCubit() : super(RegisterInitialStatues());

  static RegisterCubit get(context) => BlocProvider.of(context);

  // Controllers for the register form fields
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  // Password visibility toggles
  bool isPassword = true;
  bool isConfirmPassword = true;
  bool acceptTerms = false;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    emit(ChangePasswordStatue());
  }

  void changeConfirmPasswordVisibility() {
    isConfirmPassword = !isConfirmPassword;
    emit(ChangePasswordStatue());
  }

  void changeAcceptTerms(bool value) {
    acceptTerms = value;
    emit(ChangeAcceptTermsStatue());
  }

  // Register function
  void userRegister({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(RegisterLoadingStatues());

    if (password != confirmPassword) {
      emit(RegisterErrorStatues("Passwords do not match"));
      return;
    }

    if (!acceptTerms) {
      emit(RegisterErrorStatues("You must accept the terms and conditions"));
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
      });

      emit(RegisterSuccessStatues());
    } catch (error) {
      emit(RegisterErrorStatues(error.toString()));
    }
  }
}
