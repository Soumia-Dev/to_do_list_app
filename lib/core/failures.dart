abstract class Failures {
  final String message;
  const Failures(this.message);
}

class CacheFailure extends Failures {
  const CacheFailure(super.message);
}

class DatabaseFailure extends Failures {
  const DatabaseFailure(super.message);
}

class NotFoundFailure extends Failures {
  const NotFoundFailure(super.message);
}

class UnexpectedFailure extends Failures {
  const UnexpectedFailure(super.message);
}
