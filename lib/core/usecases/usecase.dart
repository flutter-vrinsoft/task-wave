import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_wave/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class DatabaseParamUseCase<Type, Request> {
  Future<Type> call(Request params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => <Object>[];
}
