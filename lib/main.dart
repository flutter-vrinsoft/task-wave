import 'package:appcenter_sdk_flutter/appcenter_sdk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:size_config/size_config.dart';
import 'package:task_wave/core/routes/app_routes.dart';
import 'package:task_wave/core/theme/app_sizes.dart';
import 'package:task_wave/core/theme/bloc/theme_cubit.dart';
import 'package:task_wave/core/util/services/notification_service.dart';
import 'package:task_wave/features/kanban_board/data/models/comment.dart';
import 'package:task_wave/features/kanban_board/data/models/task.dart';
import 'package:task_wave/features/kanban_board/data/models/time_log.dart';
import 'package:task_wave/features/kanban_board/data/models/user.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/task/bloc/task_bloc.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/task/bloc/task_event.dart';
import 'package:task_wave/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(CommentAdapter());
  Hive.registerAdapter(TimeLogAdapter());
  await AppCenter.start(secret: "c54ebafe-45dd-482d-99d8-edbcd88dbc78");
  await AppCenter.enable();
  await Hive.openBox<Task>('tasks');
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
    ),
  );
  NotificationService().init();
  await appSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);

    return SizeConfigInit(
      referenceHeight: 800,
      referenceWidth: 360,
      builder: (BuildContext context, Orientation orientation) {
        return Builder(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<ThemeCubit>()),
              BlocProvider(create: (_) => getIt<TaskBloc>()..add(LoadTasks())),
            ],
            child: BlocBuilder<ThemeCubit, ThemeData>(builder: (context, theme) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routerConfig: AppRoutes.router,
                theme: theme,
                themeMode: ThemeMode.system,
              );
            }),
          ),
        );
      },
    );
  }
}
