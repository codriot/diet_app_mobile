import 'dart:async';

import 'package:diet_app_mobile/API/services/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

/// This class is responsible for initializing the project
@immutable
final class InitProject {
  /// This method is used to initialize the project

  /// This method is used to initialize the project bussiness logic
  Future<void> initProject() async {
    WidgetsFlutterBinding.ensureInitialized();
    await GetStorage.init();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

    /// This method is used to handle the error
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);

      ///  custom logger
      Logger().e(details.exception.toString());
    };
    // Environment setup
    /// app environment  product or dev olarak iki ayrı şekilde çalıştırılabilir loggerla bilgi ver
    // AppEnvironment();
  }
}