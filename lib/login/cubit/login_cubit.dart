import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_solution/components/components.dart';
import 'package:project_solution/login/cubit/statues.dart';

class AppCubit extends Cubit<AppStatues>{
  AppCubit(super.initialState);
  static AppCubit get(context) => BlocProvider.of(context);
  void UserLogin({
    required String email ,
    required String password ,})async{
    emit(LoginLoadingStatues());
    try{
      UserCredential  userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection("users").doc(userCredential.user!.uid).get();
      emit(LoginSuccessStatues());
    }on FirebaseException catch(e){
      showToast(text: e.toString(), state: ToastStates.ERROR);
          } catch(e){
      emit(LoginErrorStatues(e.toString()));
    }

  }
}