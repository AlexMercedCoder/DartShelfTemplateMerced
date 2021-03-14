// Ensure that the build script itself is not opted in to null safety,
// instead of taking the language version from the current package.
//
// @dart=2.9
//
// ignore_for_file: directives_ordering

import 'package:build_runner_core/build_runner_core.dart' as _i1;
import 'package:build_test/builder.dart' as _i2;
import 'package:build_config/build_config.dart' as _i3;
import 'package:build_modules/builders.dart' as _i4;
import 'package:build_web_compilers/builders.dart' as _i5;
import 'package:build/build.dart' as _i6;
import 'dart:isolate' as _i7;
import 'package:build_runner/build_runner.dart' as _i8;
import 'dart:io' as _i9;

final _builders = <_i1.BuilderApplication>[
  _i1.apply(
      r'build_test:test_bootstrap',
      [_i2.debugIndexBuilder, _i2.debugTestBuilder, _i2.testBootstrapBuilder],
      _i1.toRoot(),
      hideOutput: true,
      defaultGenerateFor:
          const _i3.InputSet(include: [r'$package$', r'test/**'])),
  _i1.apply(r'build_modules:module_library', [_i4.moduleLibraryBuilder],
      _i1.toAllPackages(),
      isOptional: true,
      hideOutput: true,
      appliesBuilders: const [r'build_modules:module_cleanup']),
  _i1.apply(
      r'build_web_compilers:dart2js_modules',
      [
        _i5.dart2jsMetaModuleBuilder,
        _i5.dart2jsMetaModuleCleanBuilder,
        _i5.dart2jsModuleBuilder
      ],
      _i1.toNoneByDefault(),
      isOptional: true,
      hideOutput: true,
      appliesBuilders: const [r'build_modules:module_cleanup']),
  _i1.apply(
      r'build_web_compilers:ddc_modules',
      [
        _i5.ddcMetaModuleBuilder,
        _i5.ddcMetaModuleCleanBuilder,
        _i5.ddcModuleBuilder
      ],
      _i1.toNoneByDefault(),
      isOptional: true,
      hideOutput: true,
      appliesBuilders: const [r'build_modules:module_cleanup']),
  _i1.apply(
      r'build_web_compilers:ddc',
      [
        _i5.ddcKernelBuilderUnsound,
        _i5.ddcBuilderUnsound,
        _i5.ddcKernelBuilderSound,
        _i5.ddcBuilderSound
      ],
      _i1.toAllPackages(),
      isOptional: true,
      hideOutput: true,
      appliesBuilders: const [
        r'build_web_compilers:ddc_modules',
        r'build_web_compilers:dart2js_modules',
        r'build_web_compilers:dart_source_cleanup'
      ]),
  _i1.apply(
      r'build_web_compilers:sdk_js',
      [_i5.sdkJsCompileUnsound, _i5.sdkJsCompileSound, _i5.sdkJsCopyRequirejs],
      _i1.toNoneByDefault(),
      isOptional: true,
      hideOutput: true),
  _i1.apply(r'build_web_compilers:entrypoint', [_i5.webEntrypointBuilder],
      _i1.toRoot(),
      hideOutput: true,
      defaultGenerateFor: const _i3.InputSet(include: [
        r'web/**',
        r'test/**.dart.browser_test.dart',
        r'example/**',
        r'benchmark/**'
      ], exclude: [
        r'test/**.node_test.dart',
        r'test/**.vm_test.dart'
      ]),
      defaultOptions: _i6.BuilderOptions({
        'dart2js_args': ['--minify']
      }),
      defaultDevOptions: _i6.BuilderOptions({
        'dart2js_args': ['--enable-asserts']
      }),
      defaultReleaseOptions: _i6.BuilderOptions({'compiler': 'dart2js'}),
      appliesBuilders: const [
        r'build_web_compilers:dart2js_archive_extractor'
      ]),
  _i1.applyPostProcess(r'build_modules:module_cleanup', _i4.moduleCleanup),
  _i1.applyPostProcess(r'build_web_compilers:dart2js_archive_extractor',
      _i5.dart2jsArchiveExtractor,
      defaultReleaseOptions: _i6.BuilderOptions({'filter_outputs': true})),
  _i1.applyPostProcess(
      r'build_web_compilers:dart_source_cleanup', _i5.dartSourceCleanup,
      defaultReleaseOptions: _i6.BuilderOptions({'enabled': true}))
];
void main(List<String> args, [_i7.SendPort sendPort]) async {
  var result = await _i8.run(args, _builders);
  sendPort?.send(result);
  _i9.exitCode = result;
}
