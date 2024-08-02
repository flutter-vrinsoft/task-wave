import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:task_wave/core/theme/bloc/theme_cubit.dart';
import 'package:task_wave/core/util/services/shared_preference_service.dart';
import 'package:task_wave/features/kanban_board/data/data_sources/local_datasource/task_datasource.dart';
import 'package:task_wave/features/kanban_board/data/models/task.dart';
import 'package:task_wave/features/kanban_board/data/repositories/task_repository_impl.dart';
import 'package:task_wave/features/kanban_board/domain/repositories/task_repository.dart';
import 'package:task_wave/features/kanban_board/domain/usecases/task_use_case.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/task/bloc/task_bloc.dart';

import 'core/network/network_info.dart';
import 'core/util/services/network_service.dart';

GetIt getIt = GetIt.instance;

GlobalKey<NavigatorState> get navigatorKey =>
    getIt.get<GlobalKey<NavigatorState>>();

appSetup() async {
  await SharedPreferencesService.getInstance();
  final networkService = NetworkService();
  networkService.init();
  await Hive.initFlutter();
  final taskBox = await Hive.openBox<Task>('taskBox');

  // Register Hive Box
  getIt.registerSingleton<Box<Task>>(taskBox);

  //lazy singletons
  getIt.registerLazySingleton(() => networkService);
  getIt.registerLazySingleton(() => InternetConnectionChecker());
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  getIt.registerFactory(
    () => ThemeCubit(),
  );

  // Register Data Source
  getIt.registerLazySingleton<TaskDataSource>(
      () => TaskDataSource(taskBox: getIt<Box<Task>>()));


  // Register Repository
  getIt.registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImpl(dataSource: getIt<TaskDataSource>()));

  // Register Use Cases
  getIt
      .registerLazySingleton<GetTasks>(() => GetTasks(getIt<TaskRepository>()));
  getIt.registerLazySingleton<AddTask>(() => AddTask(getIt<TaskRepository>()));
  getIt.registerLazySingleton<UpdateTask>(
      () => UpdateTask(getIt<TaskRepository>()));
  getIt.registerLazySingleton<DeleteTask>(
      () => DeleteTask(getIt<TaskRepository>()));
  getIt.registerLazySingleton<AddCommentToTask>(
      () => AddCommentToTask(getIt<TaskRepository>()));

  // Register Bloc
  getIt.registerFactory(() => TaskBloc(
        getTasks: getIt<GetTasks>(),
        addTask: getIt<AddTask>(),
        updateTask: getIt<UpdateTask>(),
        deleteTask: getIt<DeleteTask>(),
        addCommentToTask: getIt<AddCommentToTask>(),
      ));
}
