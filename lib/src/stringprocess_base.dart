// Copyright (c) 2017, daftspaniel. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:markdown/markdown.dart' as md;
import 'package:html_unescape/html_unescape.dart';

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

  String getRepeatedString(String textToRepeat, num count,
      [bool newLine = false]) {
    count ??= 1;

    return newLine ? (textToRepeat + '\n') * count.toInt() : textToRepeat *
        count.toInt();
  }

  String getReplaced(String content, String target, String replacement) {
    return content.replaceAll(target, replacement);
  }

  String sort(String text) {
    String delimiter;
    if (text.contains('\n')) {
      delimiter = '\n';
    }
    else
      delimiter = ' ';

    return sortDelimiter(text, delimiter);
  }

  String sortDelimiter(String text, String delimiter) {
    List<String> segments = text.split(delimiter);
    String out = "";
    segments
      ..sort()
      ..forEach((line) => out += line + delimiter);
    return trimText(out);
  }

  String reverse(String text) {
    String delimiter;
    if (text.contains('\n')) {
      delimiter = '\n';
    }
    else
      delimiter = ' ';

    return reverseDelimiter(text, delimiter);
  }

  String reverseDelimiter(String text, String delimiter) {
    List<String> segments = text.split(delimiter);
    String out = "";

    segments.reversed.forEach((line) => out += line + delimiter);
    return trimText(out);
  }

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

  String makeOneLine(String text) {
    return text.replaceAll('\r\n', '').replaceAll('\n', '');
  }

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

  String removeExtraBlankLines(String text) {
    while (text.indexOf('\n\n\n') > -1) {
      text = text.replaceAll('\n\n\n', '\n\n');
    }

    return text;
  }

  String doubleSpaceLines(String text) {
    return text.replaceAll('\n', '\n\n');
  }

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

  String getSequenceString(num startIndex, num repeatCount, num increment) {
    String out = "";
    num current = startIndex;
    for (int i = 0; i < repeatCount; i++) {
      out += current.round().toString() + "\n";
      current += increment;
    }
    return out;
  }

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

  String uriEncode(String txt) {
    return Uri.encodeFull(txt);
  }

  String uriDecode(String txt) {
    return Uri.decodeFull(txt);
  }

  String htmlUnescape(String txt) {
    return (new HtmlUnescape()).convert(txt);
  }

  String convertMarkdownToHtml(String content) {
    return md.markdownToHtml(content, extensionSet: md.ExtensionSet.commonMark);
  }

}
