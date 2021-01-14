import 'dart:developer';
import 'dart:io';

String thisScriptPath() {
  var uri = Platform.script.toString();
  return scriptPath(uri);
}

String scriptPath(String uri) {
  String path;
  if (uri.startsWith('data:application/dart;')) {
    const startToken = 'file:///';
    const endToken = '%22%20as%20test;';
    final startIndex = uri.indexOf(startToken) + startToken.length;
    final endIndex = uri.indexOf(endToken);
    path = uri.substring(startIndex, endIndex);
  } else if (uri.startsWith('file:///')) {
    path = uri.substring(8);
  } else if (uri.startsWith('file://')) {
    path = uri.substring(7);
  } else {
    final idx = uri.indexOf('file:/');
    path = uri.substring(idx + 5);
  }
  return path;
}

String currentDirectory() {
  return Directory('.').absolute.toString();
}
