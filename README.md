# stringprocess

A library for string manipulation.

## Usage

A simple usage example:

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

## Testing

pub run test test/stringprocess_test.dart -p chrome

## Features and bugs

Please file feature requests and bugs!
