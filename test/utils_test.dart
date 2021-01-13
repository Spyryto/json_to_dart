import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('getScriptPath', () {
    test('returns path from encoded URI', () {
      var uri =
          'data:application/dart;charset=utf-8,%20%20%20%20//%20@dart=2.0%0A%20%20%20%20import%20%22dart:isolate%22;%0A%0A%20%20%20%20import%20%22package:stream_channel/isolate_channel.dart%22;%0A%0A%20%20%20%20import%20%22package:test_core/src/runner/plugin/remote_platform_helpers.dart%22;%0A%0A%20%20%20%20import%20%22file:///C:/repos/dart/json_to_dart/test/model_generator_test.dart%22%20as%20test;%0A%0A%20%20%20%20void%20main(_,%20SendPort%20message)%20%7B%0A%20%20%20%20%20%20var%20channel%20=%20serializeSuite(()%20=%3E%20test.main);%0A%20%20%20%20%20%20IsolateChannel.connectSend(message).pipe(channel);%0A%20%20%20%20%7D%0A%20%20';
      expect(scriptPath(uri),
          'C:/repos/dart/json_to_dart/test/model_generator_test.dart');
    });
  });
}
