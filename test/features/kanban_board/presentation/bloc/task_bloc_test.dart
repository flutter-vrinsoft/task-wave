import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_wave/core/util/constants/app_strings.dart';
import 'package:task_wave/features/kanban_board/data/models/task.dart';
import 'package:task_wave/features/kanban_board/domain/usecases/task_use_case.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/task/bloc/task_bloc.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/task/bloc/task_event.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/task/bloc/task_state.dart';

class MockGetTasks extends Mock implements GetTasks {}

class MockAddTask extends Mock implements AddTask {}

class MockUpdateTask extends Mock implements UpdateTask {}

class MockDeleteTask extends Mock implements DeleteTask {}

class MockAddCommentToTask extends Mock implements AddCommentToTask {}

class MockAddTimeLogToTask extends Mock implements AddTimeLogToTask {}

void main() {
  late TaskBloc bloc;
  late MockGetTasks mockGetTasks;
  late MockAddTask mockAddTask;
  late MockUpdateTask mockUpdateTask;
  late MockDeleteTask mockDeleteTask;
  late MockAddCommentToTask mockAddCommentToTask;
  late MockAddTimeLogToTask mockAddTimeLogToTask;

  setUp(() {
    mockGetTasks = MockGetTasks();
    mockAddTask = MockAddTask();
    mockUpdateTask = MockUpdateTask();
    mockDeleteTask = MockDeleteTask();
    mockAddCommentToTask = MockAddCommentToTask();
    mockAddTimeLogToTask = MockAddTimeLogToTask();

    bloc = TaskBloc(
      getTasks: mockGetTasks,
      addTask: mockAddTask,
      updateTask: mockUpdateTask,
      deleteTask: mockDeleteTask,
      addCommentToTask: mockAddCommentToTask,
      addTimeLogToTask: mockAddTimeLogToTask,
    );
  });

  group('TaskBloc Tests', () {
    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TaskLoaded] when getTasks is successful',
      build: () {
        when(mockGetTasks()).thenAnswer((_) async => [
              Task(
                id: '1',
                name: 'flutter1',
                userId: AppStrings.userId,
                description: 'this is unit test',
                createdAt: '2024-07-23T02:59:26Z',
                updatedAt: '2024-07-23T02:59:26Z',
                dueDate: '2024-07-24T02:59:26Z',
                status: 'todo',
                sortOrder: 0,
                spentTime: 0,
                isCompleted: false,
                comments: [],
                timeLogs: [],
              ),
              Task(
                id: '2',
                name: 'flutter2',
                userId: AppStrings.userId,
                description: 'this is unit test',
                createdAt: '2024-07-23T02:59:26Z',
                updatedAt: '2024-07-23T02:59:26Z',
                dueDate: '2024-07-24T02:59:26Z',
                status: 'todo',
                sortOrder: 0,
                spentTime: 0,
                isCompleted: false,
                comments: [],
                timeLogs: [],
              ),
            ]);
        return bloc;
      },
      act: (bloc) => bloc.add(LoadTasks()),
      expect: () => [
        TaskLoading(),
        TaskLoaded([
          Task(
            id: '1',
            name: 'flutter1',
            userId: AppStrings.userId,
            description: 'this is unit test',
            createdAt: '2024-07-23T02:59:26Z',
            updatedAt: '2024-07-23T02:59:26Z',
            dueDate: '2024-07-24T02:59:26Z',
            status: 'todo',
            sortOrder: 0,
            spentTime: 0,
            isCompleted: false,
            comments: [],
            timeLogs: [],
          ),
          Task(
            id: '2',
            name: 'flutter2',
            userId: AppStrings.userId,
            description: 'this is unit test',
            createdAt: '2024-07-23T02:59:26Z',
            updatedAt: '2024-07-23T02:59:26Z',
            dueDate: '2024-07-24T02:59:26Z',
            status: 'todo',
            sortOrder: 0,
            spentTime: 0,
            isCompleted: false,
            comments: [],
            timeLogs: [],
          ),
        ]),
      ],
    );
  });
}
