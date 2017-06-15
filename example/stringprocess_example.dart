// Copyright (c) 2017, daftspaniel. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:stringprocess/stringprocess.dart';

main() {
  // A few simple examples.
  StringProcessor tps = new StringProcessor();

  // Print the numbers 1 to 10.
  print(tps.getSequenceString(1, 10, 1));

  // Repeat Something!
  print(tps.getRepeatedString("Mine!", 42));

  // Word count.
  print(tps.getWordCount("Dart is Awesome and cool!"));

  // Line count.
  print(tps.getLineCount("hello\ngood\nevening\nwelcome!\n"));
}
