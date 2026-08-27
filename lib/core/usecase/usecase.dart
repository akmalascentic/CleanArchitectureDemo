import 'package:fpdart/fpdart.dart';

import '../error/failures.dart';

/// Base contract for domain use cases.
///
/// [DataType] represents the successful result, while [Params] represents
/// the input required to execute the use case.
abstract class UseCase<DataType, Params> {
  Future<Either<Failure, DataType>> call(Params params);
}

/// Use when a usecase needs no parameters
class NoParams {
  const NoParams();
}
