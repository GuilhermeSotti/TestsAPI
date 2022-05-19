enum RunningRequest {
  pause,
  isolate,
  transferable,
  generate,
}

class Constant {
  static const int countNumber = 1000000;
}

class Credentials {
  final String username;
  final String password;

  Credentials(
    this.username,
    this.password,
  );
}
