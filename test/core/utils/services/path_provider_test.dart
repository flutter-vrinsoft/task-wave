// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

const String kTemporaryPath = 'temporaryPath';
const String kApplicationSupportPath = 'applicationSupportPath';
const String kDownloadsPath = 'downloadsPath';
const String kLibraryPath = 'libraryPath';
const String kApplicationDocumentsPath = 'applicationDocumentsPath';
const String kExternalCachePath = 'externalCachePath';
const String kExternalStoragePath = 'externalStoragePath';

class MockPathProviderPlatform extends Mock with MockPlatformInterfaceMixin implements PathProviderPlatform {
  Future<String> getTemporaryPath() async {
    return kTemporaryPath;
  }

  Future<String> getApplicationSupportPath() async {
    return kApplicationSupportPath;
  }

  Future<String> getLibraryPath() async {
    return kLibraryPath;
  }

  Future<String> getApplicationDocumentsPath() async {
    return kApplicationDocumentsPath;
  }

  Future<String> getExternalStoragePath() async {
    return kExternalStoragePath;
  }

  Future<List<String>> getExternalCachePaths() async {
    return <String>[kExternalCachePath];
  }

  Future<List<String>> getExternalStoragePaths({
    StorageDirectory? type,
  }) async {
    return <String>[kExternalStoragePath];
  }

  Future<String> getDownloadsPath() async {
    return kDownloadsPath;
  }
}

void main() {
  group('PathProvider', () {
    TestWidgetsFlutterBinding.ensureInitialized();

    setUp(() async {
      PathProviderPlatform.instance = MockPathProviderPlatform();

      disablePathProviderPlatformOverride = true;
    });

    test('getTemporaryDirectory', () async {
      Directory result = await getTemporaryDirectory();
      expect(result.path, kTemporaryPath);
    });
  });
}
