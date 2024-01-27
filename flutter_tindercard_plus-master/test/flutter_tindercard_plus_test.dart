import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tindercard_plus/flutter_tindercard_plus.dart';
import 'package:flutter_tindercard_plus/flutter_tindercard_plus_platform_interface.dart';
import 'package:flutter_tindercard_plus/flutter_tindercard_plus_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterTindercardPlusPlatform 
    with MockPlatformInterfaceMixin
    implements FlutterTindercardPlusPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterTindercardPlusPlatform initialPlatform = FlutterTindercardPlusPlatform.instance;

  test('$MethodChannelFlutterTindercardPlus is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterTindercardPlus>());
  });

  test('getPlatformVersion', () async {
    FlutterTindercardPlus flutterTindercardPlusPlugin = FlutterTindercardPlus();
    MockFlutterTindercardPlusPlatform fakePlatform = MockFlutterTindercardPlusPlatform();
    FlutterTindercardPlusPlatform.instance = fakePlatform;
  
    expect(await flutterTindercardPlusPlugin.getPlatformVersion(), '42');
  });
}
