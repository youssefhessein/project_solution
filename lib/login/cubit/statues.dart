abstract class LoginStatues {}

class LoginInitialStatues extends LoginStatues {}

class LoginLoadingStatues extends LoginStatues {}

class LoginSuccessStatues extends LoginStatues {}

class LoginErrorStatues extends LoginStatues {
  final String error;
  LoginErrorStatues(this.error);
}

class ChangePasswordStatue extends LoginStatues {}
class ChangeRememberMeStatue extends LoginStatues {}

