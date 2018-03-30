# stringprocess

A string library for common string operations and general text helper functions.

## Status

[![Build Status](https://travis-ci.org/daftspaniel/stringprocess.svg?branch=master)](https://travis-ci.org/daftspaniel/stringprocess)

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

## Unit Testing

  + pub run test

## Check source code formatting:
  + dartfmt -n .

## Acknowledgements
This package makes use of the following Dart packages:

  + html_unescape
  + markdown

## Features and bugs

Please file feature requests and bugs!
