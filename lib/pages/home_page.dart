import 'package:flutter/material.dart';
import 'package:my_english_card_app/values/app_colors.dart';
import 'package:my_english_card_app/values/app_fonts.dart';
import 'package:my_english_card_app/values/app_images.dart';
import 'package:my_english_card_app/values/app_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.9);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        title: Text('English today',
            style: AppStyles.h3
                .copyWith(fontSize: 36, color: AppColors.textColor)),
        leading: InkWell(
          onTap: () {},
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
              child: Text(
                  '"It is amazing how complete is the delusion that beauty is goodness"',
                  style: AppStyles.h5
                      .copyWith(fontSize: 12, color: AppColors.textColor)),
            ),
            SizedBox(
                height: size.height * 2 / 3,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 5,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                alignment: Alignment.centerRight,
                                child: Image.asset(AppImages.heart)),
                            RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                    text: 'B',
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
                                          text: 'eautiful',
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
                              child: Text(
                                  '"Think of all the beauty still left around you and be happy."',
                                  style: AppStyles.h3.copyWith(
                                    color: AppColors.textColor,
                                    fontFamily: AppFonts.sen,
                                    fontSize: 28,
                                    letterSpacing: 1,
                                  )),
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
        onPressed: () {},
        shape: const CircleBorder(),
        backgroundColor: AppColors.primaryColor,
        child: Image.asset(AppImages.exchange),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return Container(
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
