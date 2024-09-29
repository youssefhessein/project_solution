abstract class AppStatues {}


class LoginInitialStatues extends AppStatues{}
class LoginLoadingStatues extends AppStatues{}
class LoginSuccessStatues extends AppStatues{}
class LoginErrorStatues extends AppStatues{
  final String error ;
  LoginErrorStatues(this.error);
}