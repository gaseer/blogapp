import 'package:blogui/other/constants.dart';
import 'package:blogui/other/style.dart';
import 'package:flutter/material.dart';
class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kHomeBGColor,
      body: Stack(children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
              padding: const EdgeInsets.only(left: 24),
              height: size.height / 4,
              width: size.width,
              decoration: const BoxDecoration(
                  color: Colors.purple,
                  image: DecorationImage(
                      image: AssetImage('assets/images/Image2.jpg'),
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.cover)),
              child: SafeArea(
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [

                            Text('Category', style: MyStyles.maw)
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Ready to learn?',
                          style: MyStyles.mab,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Choose your category',
                          style: MyStyles.mabla,
                        )
                      ],
                    ),),
              ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.only(top: 35.0,bottom: 0.0,left: 24.0,right: 24.0),
            height: size.height - (size.height / 5),
            width: size.width,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(34)),
            child: Column(children: [
              Row(
                children: [
                  Text(
                    'All',
                    style: MyStyles.mab
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text('Favourite', style: MyStyles.mab),
                  const SizedBox(
                    width: 30,
                  ),
                  Text('Recommended', style: MyStyles.mab)
                ],
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 7.0, vertical: 21.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: const [
                        LongCourseCard(
                            background: Colors.cyan,
                            title: 'All',
                            subtitle: '10 Course',
                            image: 'assets/images/education.png'),
                        LongCourseCard(
                            background: Colors.cyan,
                            title: 'Educational',
                            subtitle: '10 Course',
                            image: 'assets/images/education.png'),
                        LongCourseCard(
                            background: Colors.orange,
                            title: 'Exam',
                            subtitle: '15 Course',
                            image: 'assets/images/exam-results.png'),
                        ShortBottomCourseCard(
                            background: Colors.purple,
                            title: 'Health',
                            subtitle: '12 Course',
                            image: 'assets/images/healthcare.png'),
                      ],
                    ),
                    Column(
                      children: const [
                        InkWell(
                          child: ShortTopCourseCard(
                              background: Colors.green,
                              title: 'Sports',
                              subtitle: '110 Course',
                              image: 'assets/images/sports.png'),
                        ),
                        ShortBottomCourseCard(
                            background: Colors.green,
                            title: 'University',
                            subtitle: '20 Course',
                            image: 'assets/images/graduation-hat.png'),
                        ShortTopCourseCard(
                            background: Colors.green,
                            title: 'Sports',
                            subtitle: '110 Course',
                            image: 'assets/images/sports.png'),
                      ],
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ]),
    );
  }
}
class LongCourseCard extends StatelessWidget {
  final Color background;
  final String title;
  final String subtitle;
  final String image;
  const LongCourseCard(
      {Key? key,
        required this.background,
        required this.title,
        required this.subtitle,
        required this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      width: 155,
      height: 192,
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(34),
          border: Border.all(color: Colors.white, width: 10),
          boxShadow: [
            BoxShadow(
                blurRadius: 50,
                color: const Color(0xFF0B0C2A).withOpacity(.09),
                offset: const Offset(10, 10))
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(height: 16),
        Text(title, style: MyStyles.mab),
        Text(subtitle, style: MyStyles.mab),
        Expanded(child: Image.asset(image)),
      ]),
    );
  }
}
class ShortTopCourseCard extends StatelessWidget {
  final Color background;
  final String title;
  final String subtitle;
  final String image;
  const ShortTopCourseCard(
      {Key? key,
        required this.background,
        required this.title,
        required this.subtitle,
        required this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      width: 155,
      height: 163,
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(34),
          border: Border.all(color: Colors.white, width: 10),
          boxShadow: [
            BoxShadow(
                blurRadius: 50,
                color: const Color(0xFF0B0C2A).withOpacity(.09),
                offset: const Offset(10, 10))
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(height: 16),
        Text(title, style: MyStyles.mab),
        Text(subtitle, style: MyStyles.mab),
        Expanded(child: Image.asset(image)),
      ]),
    );
  }
}
class ShortBottomCourseCard extends StatelessWidget {
  final Color background;
  final String title;
  final String subtitle;
  final String image;
  const ShortBottomCourseCard(
      {Key? key,
        required this.background,
        required this.title,
        required this.subtitle,
        required this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      width: 155,
      height: 163,
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(34),
          border: Border.all(color: Colors.white, width: 10),
          boxShadow: [
            BoxShadow(
                blurRadius: 50,
                color: const Color(0xFF0B0C2A).withOpacity(.09),
                offset: const Offset(10, 10))
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(height: 8),
        Expanded(child: Image.asset(image)),
        Text(title, style: MyStyles.mab),
        Text(subtitle, style: MyStyles.mab),
        const SizedBox(height: 12),
      ]),
    );
  }
}
