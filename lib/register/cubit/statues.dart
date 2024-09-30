abstract class RegisterStatues {}

class RegisterInitialStatues extends RegisterStatues {}

class RegisterLoadingStatues extends RegisterStatues {}

class RegisterSuccessStatues extends RegisterStatues {}

class RegisterErrorStatues extends RegisterStatues {
  final String error;
  RegisterErrorStatues(this.error);
}

class ChangePasswordStatue extends RegisterStatues {}

class ChangeAcceptTermsStatue extends RegisterStatues {}
