import 'dart:math';

import 'qoute_model.dart';
import 'quotes.dart';

class Quotes {
  /// The line `static final Quotes _instance = Quotes._internal();` is creating a private static instance
  /// of the `Quotes` class called `_instance`. This instance is initialized with the private constructor
  /// `_internal()` of the `Quotes` class. This is a common implementation of the Singleton design pattern
  /// in Dart, where only one instance of the class can be created and accessed globally.
  static final Quotes _instance = Quotes._internal();
  static List<Quote> datas = [];
  Quotes._internal();

  /// The `factory` keyword in Dart is used to create a factory constructor. A factory constructor is a
  /// special type of constructor that can return an instance of a class. In the case of the `Quotes`
  /// class, the factory constructor is used to create and return the singleton instance of the class.
  factory Quotes() => _instance;
  getAll() {
    // datas = await compute(convert, allquotes);
    datas = allquotes.map((e) => Quote.fromJson(e)).toList();
  }

  static List<Quote> convert(List<dynamic> quotes) {
    return quotes.map((e) => Quote.fromJson(e)).toList();
  }

  Quote? getByWord(String word) {
    List<Quote> quotes = datas.where((element) {
      String content = element.getContent() ?? " ";
      return content.contains(word);
    }).toList();
    Random ran = Random();
    return quotes.isEmpty ? null : quotes[ran.nextInt(quotes.length)];
  }

  int _getRandomIndex() {
    return Random.secure().nextInt(allquotes.length);
  }

  // //Returns first quote

  // static Quote getFirst() {
  //   return new Quote.fromJson(allquotes[0]);
  // }

  // //Returns last quote

  // static Quote getLast() {
  //   return new Quote.fromJson(allquotes[allquotes.length - 1]);
  // }

  // //Returns random quote

  Quote getRandom() {
    return datas[_getRandomIndex()];
  }
}
