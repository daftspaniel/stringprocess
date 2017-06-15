// Copyright (c) 2017, daftspaniel. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:markdown/markdown.dart' as md;
import 'package:html_unescape/html_unescape.dart';

// String Processor - that's the theory.
class StringProcessor {

  // Trim the supplied [String].
  String trimText(String src) {
    return src.trim();
  }

  // Calculate the Word Count for the [String].
  int getWordCount(String text) {
    String workingText = text;
    workingText =
    workingText..replaceAll('\n', ' ')..replaceAll('.', ' ')..replaceAll(
        ',', ' ')..replaceAll(':', ' ')..replaceAll(';', ' ')..replaceAll(
        '?', ' ');
    List<String> words = workingText.split(' ');
    words.removeWhere((word) => word.length == 0 || word == " ");
    return min(words.length, text.length);
  }

  // Count the number of lines in the [String].
  int getLineCount(String text) {
    return '\n'
        .allMatches(text)
        .length;
  }

  // Return [String] of supplied text repeated count times.
  String getRepeatedString(String textToRepeat, num count,
      [bool newLine = false]) {
    count ??= 1;

    return newLine ? (textToRepeat + '\n') * count.toInt() : textToRepeat *
        count.toInt();
  }

  // Returns a [String] made from content with all occurances of target
  // replaced by replacement.
  String getReplaced(String content, String target, String replacement) {
    return content.replaceAll(target, replacement);
  }

  // Returns a [String] alphabetically sorted.
  // If multiline then split is by line.
  // If single line then split is by space character.
  String sort(String text) {
    String delimiter;
    if (text.contains('\n')) {
      delimiter = '\n';
    }
    else
      delimiter = ' ';

    return sortDelimiter(text, delimiter);
  }

  // Returns a [String] sorted after being split by the supplied delimiter.
  String sortDelimiter(String text, String delimiter) {
    List<String> segments = text.split(delimiter);
    String out = "";
    segments
      ..sort()
      ..forEach((line) => out += line + delimiter);
    return trimText(out);
  }

  // Returns a [String] of the reverse of the supplied string.
  String reverse(String text) {
    String delimiter;
    if (text.contains('\n')) {
      delimiter = '\n';
    }
    else
      delimiter = ' ';

    return reverseDelimiter(text, delimiter);
  }

  // Returns a [String] reversed after being split by the supplied delimiter.
  String reverseDelimiter(String text, String delimiter) {
    List<String> segments = text.split(delimiter);
    String out = "";

    segments.reversed.forEach((line) => out += line + delimiter);
    return trimText(out);
  }

  // Returns a [String] with each line having a prefix added.
  String prefixLines(String text, String prefix) {
    List<String> segments = text.split('\n');
    String out = "";
    for (int i = 0; i < segments.length; i++) {
      out += prefix + segments[i];
      if (i < (segments.length - 1)) {
        out += '\n';
      }
    }
    return out;
  }

  // Returns a [String] with each line having a postfix added.
  String postfixLines(String text, String postfix) {
    List<String> segments = text.split('\n');
    String out = "";

    for (int i = 0; i < segments.length; i++) {
      out += segments[i] + postfix;
      if (i < (segments.length - 1)) {
        out += '\n';
      }
    }
    return out;
  }

  // Returns a [String] with each line duplicated.
  String dupeLines(String text) {
    List<String> segments = text.split('\n');
    String out = "";

    for (int i = 0; i < segments.length; i++) {
      out += segments[i] * 2;
      if (i < (segments.length - 1)) {
        out += '\n';
      }
    }
    return out;
  }

  // Returns a [String] with all content on a single line.
  String makeOneLine(String text) {
    return text.replaceAll('\r\n', '').replaceAll('\n', '');
  }

  // Returns a [String] with each line trimmed.
  String trimLines(String text) {
    List<String> segments = text.split('\n');
    String out = "";

    for (int i = 0; i < segments.length; i++) {
      out += segments[i].trim();
      if (i < (segments.length - 1)) {
        out += '\n';
      }
    }
    return out;
  }

  // Returns a [String] with blank lines removed.
  String removeBlankLines(String text) {
    List<String> segments = text.split('\n');
    String out = "";

    for (int i = 0; i < segments.length; i++) {
      if (segments[i].length > 0) {
        out += segments[i];
        if (i < (segments.length - 1) && text.indexOf('\n') > -1) {
          out += '\n';
        }
      }
    }

    return out;
  }

  // Returns a [String] with double blank lines reduced to single blanks.
  String removeExtraBlankLines(String text) {
    while (text.indexOf('\n\n\n') > -1) {
      text = text.replaceAll('\n\n\n', '\n\n');
    }

    return text;
  }

  // Returns a [String] with lines double spaced.
  String doubleSpaceLines(String text) {
    return text.replaceAll('\n', '\n\n');
  }

  // Returns a [String] with lines in a random order.
  String randomiseLines(String text) {
    List<String> segments = text.split('\n');
    segments.shuffle();
    String out = "";

    for (int i = 0; i < segments.length; i++) {
      if (segments[i].length > 0) out += segments[i];
      if (i < (segments.length - 1)) {
        out += '\n';
      }
    }
    return out;
  }

  // Returns a [String] of a sequence of numbers.
  String getSequenceString(num startIndex, num repeatCount, num increment) {
    String out = "";
    num current = startIndex;
    for (int i = 0; i < repeatCount; i++) {
      out += current.round().toString() + "\n";
      current += increment;
    }
    return out;
  }

  // Returns a [String] with the input lines containing a target string removed.
  deleteLinesContaining(String text, String target) {
    List<String> segments = text.split('\n');
    String out = "";

    for (int i = 0; i < segments.length; i++) {
      if (segments[i].length != 0 && segments[i] != "\r" &&
          segments[i].indexOf(target) == -1) {
        out += segments[i];
        if (i < (segments.length - 1) && text.indexOf('\n') > -1) {
          out += '\n';
        }
      }
      else if (segments[i].length == 0 || segments[i] != "\r") {
        out += '\r\n';
      }
    }

    return out;
  }

  // URI Encode a string.
  String uriEncode(String txt) {
    return Uri.encodeFull(txt);
  }

  // URI Decode a string.
  String uriDecode(String txt) {
    return Uri.decodeFull(txt);
  }

  // Return a [String] of Unescaped HTML.
  String htmlUnescape(String txt) {
    return (new HtmlUnescape()).convert(txt);
  }

  // Return a [String] of HTML converted from the input Markdown.
  String convertMarkdownToHtml(String content) {
    return md.markdownToHtml(content, extensionSet: md.ExtensionSet.commonMark);
  }

}
