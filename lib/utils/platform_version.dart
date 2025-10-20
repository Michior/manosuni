import '../src/platform/platform_io.dart'
    if (dart.library.html) '../src/platform/platform_web.dart';

String platformVersion() => getPlatformVersion();
