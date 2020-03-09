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
    final listConfig = _loadData();
    
    var classBuffer = StringBuffer();

    // Trying to import lib    // //   ¯\_(ツ)_/¯ \\ \\
    classBuffer.write("""
          import 'package:fluro/fluro.dart';
          import 'package:flutter/material.dart';
          import 'package:routgen_generator/src/model.dart';""");

    for (Config dt in listConfig) {
      classBuffer.writeln(
          "import 'package:test_simak/modules/${dt.route}/${dt.route}_screen.dart';");
    }

    classBuffer.writeln("final routesHandlers = [");

    for (Config dt in listConfig) {
      classBuffer.writeln("Routes(name: '${dt.name}', handler:Handler(");
      classBuffer.writeln(
          "handlerFunc: (BuildContext context, Map<String, List<String>> params) =>");
      classBuffer.writeln("${dt.classDt}()");
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
    final List listData = json.decode(jsonStr);
    List<Config> listConfig =
        listData.map((val) => Config.fromJson(val)).toList();
    return listConfig;
  }
}
