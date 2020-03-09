import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:build/build.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:path/path.dart' as p;

import 'model.dart';


class RoutesGenerator extends GeneratorForAnnotation<Routes> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    return _generateFunctionSource(element);
  }

  _loadData() {
    final jsonPath = p.join(p.current, 'config/config.json');
    final file = File(jsonPath);

    final  jsonStr = file.readAsStringSync();

    final List listData = json.decode(jsonStr);
    List<Config> listConfig = listData.map((val) => Config.fromJson(val)).toList();
    return listConfig;
  }

  _generateFunctionSource(Element element) {
    final listConfig = _loadData();

    var visitor = ModelVisitor();
    element.visitChildren(visitor);

    var classBuffer = StringBuffer();

    for (Config dt in listConfig){
      classBuffer.writeln("import 'package:test_simak/modules/${dt.route}/${dt.route}_screen.dart';");
    }

    classBuffer.writeln("final routesHandlers = [");

    for (Config dt in listConfig){
      classBuffer.writeln("Routes(name: '${dt.name}', handler:Handler(");
      classBuffer.writeln("handlerFunc: (BuildContext context, Map<String, List<String>> params) =>");
      classBuffer.writeln("${dt.classDt}()");
      classBuffer.writeln(",),),");
    }
    classBuffer.writeln("];");

    return classBuffer.toString();

  }
}

class ModelVisitor extends SimpleElementVisitor {
  DartType className;
  Map<String, DartType> fields = {};

  @override
  visitConstructorElement(ConstructorElement element) {
    assert(className == null);
    className = element.type.returnType;
  }

  @override
  visitFieldElement(FieldElement element) {
    fields[element.name] = element.type;
  }
}
