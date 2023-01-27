// ignore_for_file: camel_case_types
library file_service;

import 'dart:io';

const String SAVE_PATH = "./words_generated.txt";

void write_save({required String content, String filePath = SAVE_PATH}) {
  var file = File(filePath);
  var sink = file.openWrite(mode: FileMode.append);
  sink.write(content);
  sink.close();
}
