import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_wave/features/kanban_board/data/data_sources/local_datasource/task_datasource.dart';
// ignore: unused_import
import 'package:task_wave/features/kanban_board/data/models/comment.dart';
import 'package:task_wave/features/kanban_board/data/models/task.dart';
import 'package:task_wave/features/kanban_board/data/repositories/task_repository_impl.dart';
import 'package:task_wave/features/kanban_board/domain/repositories/task_repository.dart';
import 'package:task_wave/core/util/constants/app_strings.dart';

class MockTaskDataSource extends Mock implements TaskDataSource {}

void main() {
  late TaskRepository repository;
  late MockTaskDataSource mockTaskDataSource;

  setUp(() {
    mockTaskDataSource = MockTaskDataSource();
    repository = TaskRepositoryImpl(dataSource: mockTaskDataSource);
  });

  final task = Task(
    id: '1',
    name: 'flutter1',
    userId: AppStrings.userId,
    description: 'this is a unit test',
    createdAt: '2024-07-23T02:59:26Z',
    updatedAt: '2024-07-23T02:59:26Z',
    dueDate: '2024-07-24T02:59:26Z',
    status: 'todo',
    sortOrder: 0,
    spentTime: 0,
    isCompleted: false,
    comments: [],
  );

  group('TaskRepositoryImpl Tests', () {
    test('should return list of tasks when getTasks is called', () async {
      // Arrange
      when(mockTaskDataSource.getTasks()).thenAnswer((_) async => [task]);

      // Act
      final result = await repository.getTasks();

      // Assert
      expect(result, [task]);
      verify(mockTaskDataSource.getTasks()).called(1);
    });

    test('should add a task when addTask is called', () async {
      // Act
      await repository.addTask(task);

      // Assert
      verify(mockTaskDataSource.addTask(task)).called(1);
    });

    test('should update a task when updateTask is called', () async {
      // Act
      await repository.updateTask(task);

      // Assert
      verify(mockTaskDataSource.updateTask(task)).called(1);
    });


  });
}
