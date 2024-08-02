// ignore_for_file: deprecated_member_use

// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:task_wave/features/kanban_board/data/data_sources/local_datasource/task_datasource.dart';
import 'package:task_wave/features/kanban_board/data/models/task.dart';
import 'package:task_wave/features/kanban_board/data/models/comment.dart';

import '../../../../../core/utils/services/path_provider_test.dart';
import 'task_data_source_test.mocks.dart';

const String kTemporaryPath = 'temporaryPath';
const String kApplicationSupportPath = 'applicationSupportPath';
const String kDownloadsPath = 'downloadsPath';
const String kLibraryPath = 'libraryPath';
const String kApplicationDocumentsPath = 'applicationDocumentsPath';
const String kExternalCachePath = 'externalCachePath';
const String kExternalStoragePath = 'externalStoragePath';


@GenerateMocks([Box])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  PathProviderPlatform.instance = MockPathProviderPlatform();

  final appDocDir =  await getTemporaryDirectory();;

  // Initialize Hive
  await Hive.initFlutter();
  await Hive..init(appDocDir.path);

  // Register Hive adapters
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(CommentAdapter());

  await Hive.openBox<Task>('tasks');

  late MockBox<Task> mockTaskBox;
  late TaskDataSource taskDataSource;

  setUp(() {
    PathProviderPlatform.instance = MockPathProviderPlatform();
    disablePathProviderPlatformOverride = true;
    mockTaskBox = MockBox<Task>();
    taskDataSource = TaskDataSource(taskBox: mockTaskBox);
  });

  group('TaskDataSource Tests', () {
    test('should get tasks from the box', () async {
      final tasks = [
        Task(
          id: '1',
          name: 'Task 1',
          userId: 'user1',
          description: 'Description 1',
          createdAt: '2023-01-01',
          updatedAt: '2023-01-01',
          dueDate: '2023-01-10',
          status: 'Pending',
          sortOrder: 1,
          spentTime: 0,
          isCompleted: false,
          comments: [],
        ),
      ];

      when(mockTaskBox.values).thenReturn(tasks);

      final result = await taskDataSource.getTasks();

      expect(result, tasks);
    });

    test('should add a task to the box', () async {
      final task = Task(
        id: '1',
        name: 'Task 1',
        userId: 'user1',
        description: 'Description 1',
        createdAt: '2023-01-01',
        updatedAt: '2023-01-01',
        dueDate: '2023-01-10',
        status: 'Pending',
        sortOrder: 1,
        spentTime: 0,
        isCompleted: false,
        comments: [],
      );

      await taskDataSource.addTask(task);

      verify(mockTaskBox.put(task.id, task)).called(1);
    });

    test('should update a task in the box', () async {
      final task = Task(
        id: '1',
        name: 'Task 1',
        userId: 'user1',
        description: 'Description 1',
        createdAt: '2023-01-01',
        updatedAt: '2023-01-01',
        dueDate: '2023-01-10',
        status: 'Pending',
        sortOrder: 1,
        spentTime: 0,
        isCompleted: false,
        comments: [],
      );

      await taskDataSource.updateTask(task);

      verify(mockTaskBox.put(task.id, task)).called(1);
    });

    test('should delete a task from the box', () async {
      const taskId = '1';

      await taskDataSource.deleteTask(taskId);

      verify(mockTaskBox.delete(taskId)).called(1);
    });

    test('should add a comment to a task', () async {
      final comment = Comment(
          userId: 'user1',
          content: 'This is a comment',taskId: '1'
      );

      final task = Task(
        id: '1',
        name: 'Task 1',
        userId: 'user1',
        description: 'Description 1',
        createdAt: '2023-01-01',
        updatedAt: '2023-01-01',
        dueDate: '2023-01-10',
        status: 'Pending',
        sortOrder: 1,
        spentTime: 0,
        isCompleted: false,
        comments: [],
      );

      when(mockTaskBox.get('1')).thenReturn(task);

      await taskDataSource.addCommentToTask('1', comment);

      verify(mockTaskBox.put(task.id, task)).called(1);
    });
  });
}
