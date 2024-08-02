/*
// Helper Functions

// Assuming helper functions are located in lib/core/util/helper_functions/helper_functions.dart and lib/core/util/helper_functions/extension_functions.dart.


import 'package:flutter_test/flutter_test.dart';
import 'package:your_project/core/util/helper_functions.dart';
import 'package:your_project/core/util/extension_functions.dart';

void main() {
  group('Helper Functions Tests', () {
    test('FunctionName should return expected result', () {
      // Arrange
      final input = 'testInput';
      final expectedResult = 'expectedResult';

      // Act
      final result = functionName(input);

      // Assert
      expect(result, expectedResult);
    });

    // Add more tests for each helper function
  });

  group('Extension Functions Tests', () {
    test('ExtensionFunctionName should return expected result', () {
      // Arrange
      final input = 'testInput';
      final expectedResult = 'expectedResult';

      // Act
      final result = input.extensionFunctionName();

      // Assert
      expect(result, expectedResult);
    });

    // Add more tests for each extension function
  });
}




// models


import 'package:flutter_test/flutter_test.dart';
import 'package:your_project/features/kanban_board/data/models/user.dart';
import 'package:your_project/features/kanban_board/data/models/task.dart';
import 'package:your_project/features/kanban_board/data/models/comment.dart';

void main() {
  group('User Model Tests', () {
    test('User model fromJson should return valid object', () {
      // Arrange
      final json = {
        'id': '123',
        'name': 'Test User',
        'email': 'test@example.com',
      };

      // Act
      final user = User.fromJson(json);

      // Assert
      expect(user.id, '123');
      expect(user.name, 'Test User');
      expect(user.email, 'test@example.com');
    });

    // Add more tests for User model
  });

  group('Task Model Tests', () {
    test('Task model fromJson should return valid object', () {
      // Arrange
      final json = {
        'id': '456',
        'title': 'Test Task',
        'description': 'Task Description',
      };

      // Act
      final task = Task.fromJson(json);

      // Assert
      expect(task.id, '456');
      expect(task.title, 'Test Task');
      expect(task.description, 'Task Description');
    });

    // Add more tests for Task model
  });

  group('Comment Model Tests', () {
    test('Comment model fromJson should return valid object', () {
      // Arrange
      final json = {
        'id': '789',
        'text': 'Test Comment',
      };

      // Act
      final comment = Comment.fromJson(json);

      // Assert
      expect(comment.id, '789');
      expect(comment.text, 'Test Comment');
    });

    // Add more tests for Comment model
  });
}




// Widget Tests
// Task List Widget
//
// Assuming the Task List Widget is located in lib/features/kanban_board/presentation/widgets/task_list_widget.dart.




// custom button


// data text widget




// Integration Tests

// home screen




//user detail screen








*/
