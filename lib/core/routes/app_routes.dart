import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:task_wave/features/kanban_board/data/models/task.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/home_screen.dart/home_screen.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/on_boarding_screen.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/splash_screen/splash_screen.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/task/task_form_screen.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/task/task_list_screen.dart';

class AppRoutes {
  static const splashScreenRoute = '/splash_screen';
  static const homeRoute = '/home_screen';
  static const enterUserDetailRoute = '/enter_user_detail_route';
  static const onBoardingRoute = '/on_boarding_route';
  static const taskRoute = '/task_screen';
  static const createTaskRoute = '/create_task_route';

  static taskDetailParam([Task? task]) => '/task_detail_route/${task ?? ':id'}';

  static Widget _splashRouteBuilder(BuildContext context, GoRouterState state) => const SplashScreen();
  static Widget _homeRouteBuilder(BuildContext context, GoRouterState state) => HomeScreen();
  static Widget _taskRouteBuilder(BuildContext context, GoRouterState state) => TaskScreen();
  static Widget _onBoardingRouteBuilder(BuildContext context, GoRouterState state) => OnBoardingScreen();
  static Widget _createTaskRouteBuilder(BuildContext context, GoRouterState state) => TaskFormScreen();

  static final GoRouter _router = GoRouter(
    initialLocation: splashScreenRoute,
    routes: [
      GoRoute(path: splashScreenRoute, builder: _splashRouteBuilder),
      GoRoute(path: homeRoute, builder: _homeRouteBuilder),
      GoRoute(path: taskRoute, builder: _taskRouteBuilder),
      GoRoute(path: onBoardingRoute, builder: _onBoardingRouteBuilder),
      GoRoute(path: createTaskRoute, builder: _createTaskRouteBuilder),
    ],
  );

  static GoRouter get router => _router;
}
