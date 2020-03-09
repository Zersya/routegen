import 'package:source_gen/source_gen.dart';
import 'src/routes_generator.dart';
import 'package:build/build.dart';

Builder routgen(BuilderOptions options) =>
    SharedPartBuilder([RoutesGenerator()], 'routgen');