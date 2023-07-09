abstract class Failure implements Exception {}

class DefaultError extends Failure {
  String msg;
  DefaultError(this.msg);

  @override
  String toString() {
    return msg;
  }
}

class UserInvalidEmail extends Failure {
  String msg;
  UserInvalidEmail(this.msg);

  @override
  String toString() {
    return msg;
  }
}

class UserDisabled extends Failure {
  String msg;
  UserDisabled(this.msg);

  @override
  String toString() {
    return msg;
  }
}

class UserNotFound extends Failure {
  String msg;
  UserNotFound(this.msg);

  @override
  String toString() {
    return msg;
  }
}

class UserWrongPassword extends Failure {
  String msg;
  UserWrongPassword(this.msg);

  @override
  String toString() {
    return msg;
  }
}

class EmailAlreadyInUse extends Failure {
  String msg;
  EmailAlreadyInUse(this.msg);

  @override
  String toString() {
    return msg;
  }
}

class InvalidEmail extends Failure {
  String msg;
  InvalidEmail(this.msg);

  @override
  String toString() {
    return msg;
  }
}

class EmailOperationNotAllowed extends Failure {
  String msg;
  EmailOperationNotAllowed(this.msg);

  @override
  String toString() {
    return msg;
  }
}

class EmailWeakPassword extends Failure {
  String msg;
  EmailWeakPassword(this.msg);

  @override
  String toString() {
    return msg;
  }
}

class UserSharedPrefencesError extends Failure {
  String msg;
  UserSharedPrefencesError(this.msg);

  @override
  String toString() {
    return msg;
  }
}
