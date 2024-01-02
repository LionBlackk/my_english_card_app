import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:my_english_card_app/models/english_today.dart';
import 'package:my_english_card_app/packages/quote/qoute_model.dart';
import 'package:my_english_card_app/packages/quote/quote.dart';
import 'package:my_english_card_app/pages/all_words_page.dart';
import 'package:my_english_card_app/pages/control_page.dart';
import 'package:my_english_card_app/pages/favorite_page.dart';
import 'package:my_english_card_app/values/app_colors.dart';
import 'package:my_english_card_app/values/app_fonts.dart';
import 'package:my_english_card_app/values/app_images.dart';
import 'package:my_english_card_app/values/app_keys.dart';
import 'package:my_english_card_app/values/app_styles.dart';
import 'package:my_english_card_app/widgets/app_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController;
  List<EnglishToday> words = [];
  String quoteRandom = Quotes().getRandom().content!;
  List<int> fixedListRandom({int len = 1, int max = 120, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }
    List<int> newList = [];
    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

  getEnglishToday() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int len = prefs.getInt(AppKeys.counter) ?? 5;
    List<String> newList = [];
    List<int> rans = fixedListRandom(len: len, max: nouns.length);
    for (var index in rans) {
      newList.add(nouns[index]);
    }
    setState(() {
      words = newList.map((word) => getItem(word)).toList();
    });
  }

  EnglishToday getItem(String word) {
    Quote? quote = Quotes().getByWord(word);
    return EnglishToday(noun: word, quote: quote?.content, id: quote?.id);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.9);
    super.initState();
    getEnglishToday();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        title: Text('English today',
            style: AppStyles.h3
                .copyWith(fontSize: 36, color: AppColors.textColor)),
        leading: InkWell(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Image.asset(AppImages.menu),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: size.height * 1 / 10,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(left: 24),
              alignment: Alignment.centerLeft,
              child: Text('"$quoteRandom"',
                  style: AppStyles.h5
                      .copyWith(fontSize: 12, color: AppColors.textColor)),
            ),
            SizedBox(
                height: size.height * 2 / 3,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: words.length > 5 ? 6 : words.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    String firstLetter = words[index].noun!.substring(0, 1);
                    String leftLetter = words[index].noun!.substring(1);
                    String quoteDefault =
                        'Think of all the beauty still left around you and be happy.';
                    String quote = words[index].quote ?? quoteDefault;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                offset: Offset(3, 4),
                                blurRadius: 3,
                              )
                            ]),
                        child: (index >= 5)
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              AllWordsPage(words: words)));
                                },
                                child: Center(
                                  child: Text(
                                    'Show more...',
                                    style: AppStyles.h3.copyWith(shadows: [
                                      const BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(2, 4),
                                        blurRadius: 3,
                                      ),
                                    ], fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LikeButton(
                                    onTap: (bool isLiked) async {
                                      setState(() {
                                        words[index].isFavorite = !isLiked;
                                      });
                                      return words[index].isFavorite;
                                    },
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    size: 45,
                                    isLiked: words[index].isFavorite,
                                    circleColor: const CircleColor(
                                        start: Color(0xff00ddff),
                                        end: Color(0xff0099cc)),
                                    bubblesColor: const BubblesColor(
                                      dotPrimaryColor: Color(0xff33b5e5),
                                      dotSecondaryColor: Color(0xff0099cc),
                                    ),
                                    likeBuilder: (bool isLiked) {
                                      return ImageIcon(
                                        const AssetImage(AppImages.heart),
                                        color:
                                            isLiked ? Colors.red : Colors.white,
                                        size: 45,
                                      );
                                    },
                                  ),
                                  RichText(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                          text: firstLetter,
                                          style: AppStyles.h2.copyWith(
                                              fontFamily: AppFonts.sen,
                                              fontSize: 96,
                                              fontWeight: FontWeight.bold,
                                              shadows: [
                                                const BoxShadow(
                                                    color: Colors.black38,
                                                    offset: Offset(3, 6),
                                                    blurRadius: 6)
                                              ]),
                                          children: [
                                            TextSpan(
                                                text: leftLetter,
                                                style: AppStyles.h2.copyWith(
                                                    fontFamily: AppFonts.sen,
                                                    fontSize: 60,
                                                    fontWeight: FontWeight.bold,
                                                    shadows: [
                                                      const BoxShadow(
                                                        offset: Offset(0, 0),
                                                      )
                                                    ]))
                                          ])),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: AutoSizeText(
                                      '"$quote"',
                                      style: AppStyles.h3.copyWith(
                                        color: AppColors.textColor,
                                        fontFamily: AppFonts.sen,
                                        letterSpacing: 1,
                                      ),
                                      maxFontSize: 26,
                                      maxLines: 5,
                                    ),
                                  ),
                                ],
                              ),
                        //indicator
                      ),
                    );
                  },
                )),
            SizedBox(
                height: size.height * 1 / 11,
                child: Container(
                    margin: const EdgeInsets.only(left: 24),
                    padding: const EdgeInsets.symmetric(vertical: 28),
                    alignment: Alignment.center,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return buildIndicator(index == _currentIndex, size);
                        }))),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            getEnglishToday();
          });
        },
        shape: const CircleBorder(),
        backgroundColor: AppColors.primaryColor,
        child: Image.asset(AppImages.exchange),
      ),
      drawer: Drawer(
          backgroundColor: AppColors.secondColor,
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your mind',
                      style: AppStyles.h3.copyWith(color: AppColors.textColor)),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: AppButons(
                        label: 'Favorites',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => FavoritePage(words: words)),
                          );
                        }),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: AppButons(
                          label: 'Your control',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ControlPage()),
                            );
                          })),
                ],
              ))),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: 8,
      width: isActive ? size.width * 1 / 4 : 24,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: isActive ? AppColors.lightBlue : AppColors.lightGrey,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, blurRadius: 2, offset: Offset(3, 4))
          ]),
    );
  }
}
