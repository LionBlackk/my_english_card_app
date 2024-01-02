import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:my_english_card_app/models/english_today.dart';
import 'package:my_english_card_app/values/app_colors.dart';
import 'package:my_english_card_app/values/app_images.dart';
import 'package:my_english_card_app/values/app_styles.dart';

class AllWordsPage extends StatefulWidget {
  final List<EnglishToday> words;
  const AllWordsPage({super.key, required this.words});

  @override
  State<AllWordsPage> createState() => _AllWordsPageState();
}

class _AllWordsPageState extends State<AllWordsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text('English today',
              style: AppStyles.h3
                  .copyWith(fontSize: 36, color: AppColors.textColor)),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(AppImages.leftArrow),
          ),
        ),
        body: ListView.builder(
            itemCount: widget.words.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: (index % 2 == 1) ? AppColors.lightBlue : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(widget.words[index].noun!,
                      style: AppStyles.h4.copyWith(color: AppColors.textColor)),
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width *
                          0.1, // for example, 15% of screen width
                    ),
                    child: LikeButton(
                      onTap: (bool isLiked) async {
                        setState(() {
                          widget.words[index].isFavorite = !isLiked;
                        });
                        return widget.words[index].isFavorite;
                      },
                      mainAxisAlignment: MainAxisAlignment.end,
                      size: 35,
                      isLiked: widget.words[index].isFavorite,
                      circleColor: const CircleColor(
                          start: Color(0xff00ddff), end: Color(0xff0099cc)),
                      bubblesColor: const BubblesColor(
                        dotPrimaryColor: Color(0xff33b5e5),
                        dotSecondaryColor: Color(0xff0099cc),
                      ),
                      likeBuilder: (bool isLiked) {
                        return ImageIcon(
                          const AssetImage(AppImages.heart),
                          color: isLiked ? Colors.red : Colors.grey,
                          size: 35,
                        );
                      },
                    ),
                  ),
                  subtitle: Text(widget.words[index].quote ??
                      '"Think of all the beauty still left around you and be happy."'),
                ),
              );
            }));
  }
}
