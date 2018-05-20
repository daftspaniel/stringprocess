// Copyright (c) 2017, daftspaniel. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:markdown/markdown.dart' as md;
import 'package:html_unescape/html_unescape.dart';

const UNIX_NEWLINE = '\n';

///String Processor - that's the theory.
class StringProcessor {
  ///Trim the supplied [String].
  String trimText(String src) {
    return src.trim();
  }

  ///Returns a [String] with each line trimmed.
  String trimLines(String text) {
    List<String> segments = getSegments(text);
    String out = "";

    for (int i = 0; i < segments.length; i++) {
      out += segments[i].trim();
      if (i < (segments.length - 1)) {
        out += '\n';
      }
    }
    return out;
  }

  ///Calculate the Word Count for the [String].
  int getWordCount(String text) {
    String workingText = text;
    workingText = workingText
      ..replaceAll('\n', ' ')
      ..replaceAll('.', ' ')
      ..replaceAll(',', ' ')
      ..replaceAll(':', ' ')
      ..replaceAll(';', ' ')
      ..replaceAll('?', ' ');
    List<String> words = workingText.split(' ');
    words.removeWhere((word) => word.length == 0 || word == " ");
    return min(words.length, text.length);
  }

  ///Count the number of lines in the [String] text.
  int getLineCount(String text) {
    return '\n'.allMatches(text).length;
  }

  ///Count the number of sentences in the [String] text.
  int getSentenceCount(String text) {
    var processedText =
        text.replaceAll('!', '.').replaceAll('?', '.').replaceAll('...', '.');
    var sentences = denumber(processedText).split('.');
    var sentenceCount = 0;
    for (int i = 0; i < sentences.length; i++) {
      if (sentences[i].trim().length > 1) sentenceCount++;
    }
    return sentenceCount;
  }

  ///Return [String] of supplied text repeated count times.
  String generateRepeatedString(String textToRepeat, num count,
      [bool newLine = false]) {
    count ??= 1;

    return newLine
        ? (textToRepeat + '\n') * count.toInt()
        : textToRepeat * count.toInt();
  }

  ///Returns a [String] made from content with all occurances of target
  ///replaced by replacement.
  String getReplaced(String content, String target, String replacement) {
    return content.replaceAll(target, replacement);
  }

  ///Returns a [String] alphabetically sorted.
  ///If multiline then split is by line.
  ///If single line then split is by space character.
  String sort(String text) {
    String delimiter;
    if (text.contains('\n')) {
      delimiter = '\n';
    } else
      delimiter = ' ';

    return sortDelimiter(text, delimiter);
  }

  ///Returns a [String] sorted after being split by the supplied delimiter.
  String sortDelimiter(String text, String delimiter) {
    List<String> segments = text.split(delimiter);
    String out = "";
    segments
      ..sort()
      ..forEach((line) => out += line + delimiter);
    return trimText(out);
  }

  ///Returns a [String] of the reverse of the supplied string.
  String reverse(String text) {
    String delimiter = text.contains('\n') ? '\n' : ' ';
    return reverseDelimiter(text, delimiter);
  }

  ///Returns a [String] reversed after being split by the supplied delimiter.
  String reverseDelimiter(String text, String delimiter) {
    List<String> segments = text.split(delimiter);
    String out = "";

    segments.reversed.forEach((line) => out += line + delimiter);
    return trimText(out);
  }

  ///Returns a [String] with each line having a prefix added.
  String prefixLines(String text, String prefix) {
    List<String> segments = getSegments(text);
    String out = "";
    for (int i = 0; i < segments.length; i++) {
      out += prefix + segments[i];
      if (i < (segments.length - 1)) {
        out += '\n';
      }
    }
    return out;
  }

  ///Returns a [String] with each line having a postfix added.
  String postfixLines(String text, String postfix) {
    List<String> segments = getSegments(text);
    String out = "";

    for (int i = 0; i < segments.length; i++) {
      out += segments[i] + postfix;
      if (i < (segments.length - 1)) {
        out += '\n';
      }
    }
    return out;
  }

  ///Returns a [String] with each line duplicated.
  String dupeLines(String text) {
    List<String> segments = getSegments(text);
    String out = "";

    for (int i = 0; i < segments.length; i++) {
      out += segments[i] * 2;
      if (i < (segments.length - 1)) {
        out += '\n';
      }
    }
    return out;
  }

  ///Returns a [String] with content with spaces instead of tabs.
  String convertTabsToSpace(String text, {int numberOfSpaces = 4}) {
    String spaces = ' ' * numberOfSpaces;
    return text.replaceAll('\t', spaces);
  }

  ///Returns a [String] with all content on a single line.
  String makeOneLine(String text) {
    return text.replaceAll('\r\n', '').replaceAll('\n', '');
  }

  ///Returns a [String] with blank lines removed.
  String removeBlankLines(String text) {
    List<String> segments = getSegments(text);
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

  ///Returns a [String] with double blank lines reduced to single blank lines.
  String removeExtraBlankLines(String text) {
    while (text.indexOf('\n\n\n') > -1) {
      text = text.replaceAll('\n\n\n', '\n\n');
    }

    return text;
  }

  ///Returns a [String] with lines double spaced.
  String doubleSpaceLines(String text) {
    return text.replaceAll('\n', '\n\n');
  }

  ///Returns a [String] with lines in a random order.
  String randomiseLines(String text) {
    List<String> segments = getSegments(text);
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

  ///Returns a [String] of a sequence of numbers each on a new line.
  String generateSequenceString(
      num startIndex, num repeatCount, num increment) {
    String out = "";
    num current = startIndex;
    for (int i = 0; i < repeatCount; i++) {
      out += current.round().toString() + '\n';
      current += increment;
    }
    return out;
  }

  ///Returns a [String] with the input lines containing a [target] string removed.
  deleteLinesContaining(String text, String target) {
    List<String> segments = getSegments(text);
    String out = "";

    for (int i = 0; i < segments.length; i++) {
      if (segments[i].length != 0 &&
          segments[i] != "\r" &&
          segments[i].indexOf(target) == -1) {
        out += segments[i];
        if (i < (segments.length - 1) && text.indexOf('\n') > -1) {
          out += '\n';
        }
      } else if (segments[i].length == 0 || segments[i] != "\r") {
        out += '\r\n';
      }
    }

    return out;
  }

  ///URI Encode a string.
  String uriEncode(String text) {
    return Uri.encodeFull(text);
  }

  ///URI Decode a string.
  String uriDecode(String text) {
    return Uri.decodeFull(text);
  }

  ///Return a [String] of the input text with each item (defined by the
  ///delimiter on new line).
  String split(String text, String delimiter) {
    String out = '';
    if (text.indexOf(delimiter) == -1) {
      return text;
    } else {
      text.split(delimiter).forEach((String item) => out += "$item\r\n");
    }
    return out;
  }

  ///Return a [String] of Unescaped HTML.
  String htmlUnescape(String text) {
    return (new HtmlUnescape()).convert(text);
  }

  ///Return a [String] of HTML converted from the input Markdown.
  String convertMarkdownToHtml(String content) {
    return md.markdownToHtml(content, extensionSet: md.ExtensionSet.commonMark);
  }

  ///Returns a [String] with the input lines containing a [target] string removed.
  String deleteLinesNotContaining(String text, String target) {
    List<String> segments = getSegments(text);
    String out = "";

    for (int i = 0; i < segments.length; i++) {
      if (segments[i].length != 0 &&
          segments[i] != "\r" &&
          segments[i].indexOf(target) > -1) {
        out += segments[i];
        if (i < (segments.length - 1) && text.indexOf('\n') > -1) {
          out += '\n';
        }
      } else if (segments[i].length == 0 || segments[i] != "\r") {
        out += '\r\n';
      }
    }

    return out;
  }

  ///Returns a [String] with the input lines with content numbered.
  String addNumbering(String text) {
    if (text.length == 0) {
      return '';
    }
    var segments = getSegments(text);
    String out = "";
    int numberingIndex = 1;
    for (int i = 0; i < segments.length; i++) {
      if (segments[i].length > 0) {
        out += '${numberingIndex}. ' + segments[i] + '\n';
        numberingIndex++;
      } else if (i + 1 != segments.length) {
        out += segments[i] + '\n';
      }
    }

    return out;
  }

  ///Break [String] into segements by line separator.
  List<String> getSegments(String text) {
    return text.split(UNIX_NEWLINE);
  }

  ///Returns a [String] with [leftTrim] characters removed for the left
  ///and [rightTrim] for the right.
  String splice(String text, int leftTrim, [int rightTrim = 0]) {
    var out = '';
    var segments = getSegments(text);

    for (int i = 0; i < segments.length; i++) {
      var line = segments[i];
      var currentLength = line.length;
      if (currentLength <= leftTrim || (line.length - rightTrim) < 1) {
        out += '\n';
      } else if (rightTrim > 0) {
        if ((line.length - rightTrim) >= leftTrim)
          out += line.substring(leftTrim, line.length - rightTrim);
        else
          out += '\n';
      } else {
        out += line.substring(leftTrim);
      }
      if (text.indexOf('\n') > -1) {
        out += '\n';
      }
    }
    return out;
  }

  ///Returns a [String] with the input multiple spaces all reduced to 1 space.
  String trimAllSpaces(String text) {
    var out = '';
    var segments = getSegments(text);

    for (int i = 0; i < segments.length; i++) {
      var line = '';
      var innerSegments = segments[i].split(' ');
      for (int j = 0; j < innerSegments.length; j++) {
        if (innerSegments[j].trim().length > 0) {
          line += innerSegments[j].trim() + ' ';
        }
      }
      out += line.trim();

      if (i < (segments.length - 1)) {
        out += '\n';
      }
    }

    return out;
  }

  ///Returns a [String] with the input lines sorted by length (ascending).
  String sortByLength(String text) {
    var out = '';
    var segments = getSegments(text);
    segments.sort((a, b) => a.length.compareTo(b.length));
    for (var i = 0; i < segments.length; i++) {
      out += segments[i] + '\n';
    }
    return out;
  }

  ///Returns a [String] with input having 0123456789 removed.
  String denumber(String text) {
    for (var i = 0; i < 10; i++) text = text.replaceAll('$i', '');
    return text;
  }

  ///Returns a [String] with the line that incorporates the index at position
  ///duplicated.
  String duplicateLine(String text, int position) {
    var start = max(text.lastIndexOf('\n', position), 0);
    var end = text.indexOf('\n', position);
    if (start + 1 < end) {
      var dupe = text.substring(start == 0 ? 0 : start + 1, end);
      text = text.substring(0, start) +
          (start == 0 ? '' : '\n') +
          dupe +
          '\n' +
          dupe +
          text.substring(end);
    }
    return text;
  }
}
