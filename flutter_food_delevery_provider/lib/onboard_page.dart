import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delevery_provider/consts.dart';
import 'package:flutter_food_delevery_provider/model/onborad_model.dart';

class AppOnboardPage extends StatefulWidget {
  const AppOnboardPage({super.key});
  @override
  State<AppOnboardPage> createState() => _AppOnboardPageState();
}

class _AppOnboardPageState extends State<AppOnboardPage> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kblack,
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            itemCount: onboards.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Positioned(
                    top: -70,
                    left: 0,
                    right: 0,
                    child: FadeInDown(
                      delay: Duration(milliseconds: 500),
                      child:Image.asset(
                        onboards[index].image,
                        width: 600,
                        height: 600,
                        fit: BoxFit.contain,
                      )),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
