import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dart_style/dart_style.dart';

import 'package:build/build.dart';
import 'package:path/path.dart' as p;

import 'model.dart';

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
          import 'package:routgen_generator/src/model.dart';""");

    for (Routes route in config.routes) {
      classBuffer.writeln(
          "import 'package:${config.app_name}/modules/${route.route}/${route.route}_screen.dart';");
    }

    classBuffer.writeln("final routesHandlers = [");

    for (Routes route in config.routes) {
      classBuffer.writeln("Routes(name: '${route.name}', handler:Handler(");
      classBuffer.writeln(
          "handlerFunc: (BuildContext context, Map<String, List<String>> params) =>");
      classBuffer.writeln("${route.classDt}()");
      classBuffer.writeln(",),),");
    }
    classBuffer.writeln("];");

    final file = File('lib/config/routes_handler.dart');
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
