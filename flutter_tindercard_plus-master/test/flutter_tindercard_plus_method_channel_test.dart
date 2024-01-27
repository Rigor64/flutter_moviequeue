import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tindercard_plus/flutter_tindercard_plus_method_channel.dart';

void main() {
  MethodChannelFlutterTindercardPlus platform = MethodChannelFlutterTindercardPlus();
  const MethodChannel channel = MethodChannel('flutter_tindercard_plus');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
