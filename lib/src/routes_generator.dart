import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dart_style/dart_style.dart';

import 'package:build/build.dart';
import 'package:path/path.dart' as p;

import '../model.dart';

class RoutesGenerator implements Builder {
  const RoutesGenerator();

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final Config config = _loadData();

    var classBuffer = StringBuffer();

    // Trying to import lib    // //   ¯\_(ツ)_/¯ \\ \\
    classBuffer.write("""
          import 'package:fluro/fluro.dart';
          import 'package:flutter/material.dart';
          import 'package:routgen_generator/model.dart';""");

    for (Modules module in config.modules) {
      classBuffer.writeln(
          "import 'package:${config.appName}/modules/${module.route}/${module.route}_screen.dart';");
    }

    classBuffer.writeln("final routesHandlers = [");

    for (Modules module in config.modules) {
      classBuffer.writeln("Routes(name: '${module.nameEn}', handler:Handler(");
      classBuffer.writeln(
          "handlerFunc: (BuildContext context, Map<String, List<String>> params) =>");
      classBuffer.writeln("${module.className}()");
      classBuffer.writeln(",),),");
    }
    classBuffer.writeln("];");

    final file = File('lib/config/routes_handler.g.dart');
    String outputString =
        DartFormatter().format(classBuffer.toString()).toString();

    file.writeAsStringSync(outputString);
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        '': ['.dart']
      };

  _loadData() {
    final jsonPath = p.join(p.current, 'config/config.json');
    final file = File(jsonPath);

    final jsonStr = file.readAsStringSync();
    Config config = Config.fromJson(json.decode(jsonStr));
    return config;
  }
}
