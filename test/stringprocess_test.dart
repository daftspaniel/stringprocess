// Copyright (c) 2017, daftspaniel. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:stringprocess/stringprocess.dart';
import 'package:test/test.dart';

void main() {
  StringProcessor tps = new StringProcessor();

  group('Modify', () {
    test('convertTabsToSpace', () {
      expect(
          tps.convertTabsToSpace('this\tis\tTABBED.'), 'this    is    TABBED.');
    });
    test('convertTabsToSpace - custom length', () {
      expect(tps.convertTabsToSpace('this\tis\tTABBED.', numberOfSpaces: 2),
          'this  is  TABBED.');
    });
  });

  group('Generate:', () {
    test('getSequenceString', () {
      expect(tps.generateSequenceString(1, 10, 1),
          "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n");
      expect(tps.generateSequenceString(5, 5, 1), "5\n6\n7\n8\n9\n");
      expect(tps.generateSequenceString(1, 10, 10),
          "1\n11\n21\n31\n41\n51\n61\n71\n81\n91\n");
      expect(tps.generateSequenceString(10, 5, -1), "10\n9\n8\n7\n6\n");
    });

    test('getRepeatedString', () {
      expect(tps.generateRepeatedString("Moo", 4), "MooMooMooMoo");
      expect(tps.generateRepeatedString("Moo", 0), "");
    });

    test('getRepeatedString with newline', () {
      expect(
          tps.generateRepeatedString("Moo", 4, true), "Moo\nMoo\nMoo\nMoo\n");
      expect(tps.generateRepeatedString("Moo", 0, true), "");
    });
  });

  group('Core :', () {
    test('trim', () {
      expect(tps.trimText(" hello "), "hello");
    });

    test('getWordCount', () {
      expect(tps.getWordCount(" hello "), 1);
      expect(tps.getWordCount(" hello world. "), 2);
      expect(tps.getWordCount("Dart is Awesome and cool!"), 5);
      expect(tps.getWordCount("Count ALL the words!"), 4);
    });

    test('getLineCount', () {
      expect(tps.getLineCount(""), 0);
      expect(tps.getLineCount("hello"), 0);
      expect(tps.getLineCount("hello\n"), 1);
      expect(tps.getLineCount("hello\nthere\nare\napples\nin\nhere."), 5);
    });

    test('getSentenceCount', () {
      expect(tps.getSentenceCount(""), 0);
      expect(tps.getSentenceCount("hello to you."), 1);
      expect(tps.getSentenceCount("hello to you"), 1);
      expect(tps.getSentenceCount("23. hello to you."), 1);
      expect(tps.getSentenceCount("""
      1. turnip
      23. hello to you.
      3. Hmm
      4. Hope this works!
      """), 4);
      expect(tps.getSentenceCount("hello.\n"), 1);
      expect(
          tps.getSentenceCount(
              "hello there are monkeys. Yes, there is. No! I don't know? hmmm"),
          5);
    });

    test('dupeLines', () {
      expect(tps.dupeLines(""), "");
      expect(tps.dupeLines("hello"), "hellohello");
      expect(tps.dupeLines("hello\n"), "hellohello\n");
      expect(tps.dupeLines("hello\nthere\nare\napples\nin\nhere."),
          "hellohello\ntherethere\nareare\napplesapples\ninin\nhere.here.");
    });

    test('prefixLines', () {
      expect(tps.prefixLines("", "TEST"), "TEST");
      expect(tps.prefixLines("\n\n", "TEST"), "TEST\nTEST\nTEST");
      expect(tps.prefixLines("asdf\nxyzz\n", "  "), "  asdf\n  xyzz\n  ");
      expect(tps.prefixLines("Cup", ""), "Cup");
    });

    test('trimLines', () {
      expect(tps.trimLines(""), "");
      expect(tps.trimLines("       asdf  \n"), "asdf\n");
      expect(tps.trimLines("       asdf  \nsss\n ooo "), "asdf\nsss\nooo");
      expect(tps.trimLines("       asdf  \n sss  \n ooo "), "asdf\nsss\nooo");
    });

    test('postfixLines', () {
      expect(tps.postfixLines("", "TEST"), "TEST");
      expect(tps.postfixLines("a\nb\n", "TEST"), "aTEST\nbTEST\nTEST");
      expect(tps.postfixLines("asdf\nxyzz\n", "12345"),
          "asdf12345\nxyzz12345\n12345");
      expect(tps.postfixLines("Coffee", "Cup"), "CoffeeCup");
    });

    test('doubleSpaceLines', () {
      expect(tps.doubleSpaceLines(""), "");
      expect(tps.doubleSpaceLines("Moo\n"), "Moo\n\n");
      expect(tps.doubleSpaceLines("Moo\nBaa"), "Moo\n\nBaa");
      expect(tps.doubleSpaceLines("Moo\nBaa\n"), "Moo\n\nBaa\n\n");
      expect(tps.doubleSpaceLines("Moo\n\nBaa\n"), "Moo\n\n\n\nBaa\n\n");
    });

    test('removeBlankLines', () {
      expect(tps.removeBlankLines(""), "");
      expect(tps.removeBlankLines("\n\n\n\n\nhello"), "hello");
      expect(tps.removeBlankLines("hello\n\n\n"), "hello\n");
      expect(tps.removeBlankLines("hello\nthere\nare\napples\nin\nhere.\n"),
          "hello\nthere\nare\napples\nin\nhere.\n");
      expect(
          tps.removeBlankLines("hello\nthere\nare\napples\n\n\n\nin\nhere.\n"),
          "hello\nthere\nare\napples\nin\nhere.\n");
    });

    test('removeExtraBlankLines', () {
      expect(tps.removeExtraBlankLines(""), "");
      expect(tps.removeExtraBlankLines("\n\n\n\n\nhello"), "\n\nhello");
      expect(tps.removeExtraBlankLines("hello\n\n\n"), "hello\n\n");
      expect(
          tps.removeExtraBlankLines("hello\n\n\nthere\n"), "hello\n\nthere\n");
    });

    test('convertMarkdownToHtml', () {
      expect(tps.convertMarkdownToHtml("# Moo"), "<h1>Moo</h1>\n");
    });

    test('sort - single line', () {
      expect(tps.sort("Dogs are the best!"), "Dogs are best! the");
    });

    test('sort - multi lines', () {
      expect(
          tps.sort("Zebras are cool!\nMonkeys are okay!\nDogs are the best!"),
          "Dogs are the best!\nMonkeys are okay!\nZebras are cool!");
    });

    test('reverse - single line', () {
      expect(tps.reverse("Dogs are the best!"), "best! the are Dogs");
    });

    test('reverse - multi line', () {
      expect(
          tps.reverse(
              "Zebras are cool!\nMonkeys are okay!\nDogs are the best!\n"),
          "Dogs are the best!\nMonkeys are okay!\nZebras are cool!");
    });

    test('replace', () {
      expect(tps.getReplaced("The cat sat on the mat", "cat", "dog"),
          "The dog sat on the mat");
    });

    test('makeOneLine', () {
      expect(tps.makeOneLine("\nThe cat sat\n on the mat\n"),
          "The cat sat on the mat");
    });

    test('makeOneLine', () {
      expect(tps.makeOneLine("\r\nThe cat sat\r\n on the mat\r\n"),
          "The cat sat on the mat");
    });

    test('remove lines containing', () {
      String txt = "\r\nThe cat sat\r\n";
      txt = txt + txt + 'MOO' + txt;
      expect(tps.deleteLinesContaining(txt, "cat"), "\r\n\r\nMOO\r\n\r\n\r\n");
    });

    test('remove lines NOT containing', () {
      String txt =
          "\r\n\r\nThe cat sat\r\ndog\r\ndog zebra mouse\r\nThe cat sat\r\n\dog\r\nThe cat sat\r\n";
      expect(tps.deleteLinesNotContaining(txt, "cat"),
          'The cat sat\r\n\r\n\r\nThe cat sat\r\n\r\nThe cat sat\r\n\r\n');
    });

    test('encode', () {
      String txt = "The cat sat on the mat";
      expect(tps.uriEncode(txt), 'The%20cat%20sat%20on%20the%20mat');
    });

    test('decode', () {
      String txt = "The%20cat%20sat%20on%20the%20mat";
      expect(tps.uriDecode(txt), "The cat sat on the mat");
    });

    test('split - delimiter present', () {
      String txt = "1,35,55,33,64";
      expect(tps.split(txt, ","), "1\r\n35\r\n55\r\n33\r\n64\r\n");
    });

    test('split - delimiter not present', () {
      const String txt = "1,35,55,33,64";
      expect(tps.split(txt, "X"), txt);
    });

    test('htmlEscape', () {
      expect(tps.htmlUnescape(""), "");
      expect(tps.htmlUnescape("&lt;HTML&gt;"), "<HTML>");
    });

    test('addNumbering', () {
      expect(tps.addNumbering(""), "");
      expect(tps.addNumbering("Hello"), "1. Hello\n");
      expect(tps.addNumbering("Hello\nWorld\n"), "1. Hello\n2. World\n");
      expect(tps.addNumbering("Hello\nWorld\nWorms\n"),
          "1. Hello\n2. World\n3. Worms\n");
      expect(tps.addNumbering("Hello\n\nWorld\nWorms\n"),
          "1. Hello\n\n2. World\n3. Worms\n");
    });

    test('trimAllSpaces', () {
      expect(tps.trimAllSpaces("           "), "");
      expect(tps.trimAllSpaces(""), "");
      expect(tps.trimAllSpaces("\n"), "\n");
      expect(tps.trimAllSpaces(" the    monkey  "), "the monkey");
      expect(tps.trimAllSpaces(" the    monkey  \n    ffff jjjjj    SSS"),
          "the monkey\nffff jjjjj SSS");
    });

    test('sortByLength', () {
      expect(tps.sortByLength("the red fish"), "the red fish\n");
      expect(
          tps.sortByLength("the red fish\na\nmeee"), "a\nmeee\nthe red fish\n");
    });

    test('denumber', () {
      expect(tps.denumber("012the34 red 6789fish"), "the red fish");
      expect(
          tps.denumber("012the34 road 6789fish98798743989887438798347939739"),
          "the road fish");
    });

    test('duplicateLine', () {
      expect(tps.duplicateLine('This is and intro\ntrouble\nclosing words', 20),
          'This is and intro\ntrouble\ntrouble\nclosing words');
      expect(tps.duplicateLine('\nmouse', 0), '\nmouse');
      expect(tps.duplicateLine('mouse\n', 0), 'mouse\nmouse\n');
      expect(tps.duplicateLine('mouse\n', 3), 'mouse\nmouse\n');
    });

    test('splice', () {
      expect(tps.splice("the red fish", 4), "red fish");
      expect(tps.splice("the red fish", 4, 2), "red fi");

      expect(tps.splice("the red fishes\nthe blue dogz", 4),
          "red fishes\nblue dogz\n");

      expect(tps.splice("the red fishes!!\nthe blue dogz", 4, 2),
          "red fishes\nblue do\n");

      expect(tps.splice("the red fish\ndog\nthisi\n", 4, 2),
          'red fi\n\n\n\n\n\n\n');

      expect(tps.splice("this\nthisis", 4, 2), '\n\n\n');

      expect(tps.splice("this\nthis*is", 4, 2), '\n\n*\n');

      expect(tps.splice("dog", 2, 2), '\n');
    });
  });
}
