import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/signUp.dart';
import 'package:food_delivery_app/widget/content_model.dart';
import 'package:food_delivery_app/widget/widget_support.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: [
                        Image.asset(
                          contents[i].image,
                          height: 450,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            contents[i].title,
                            style: Appwidget.SemiBoldTextFieldStyle(),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            contents[i].description,
                            style: Appwidget.LightTextFieldStyle(),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (currentIndex == contents.length - 1) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const Signup()));
              }
              _controller.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInCubic,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 60,
              margin: const EdgeInsets.all(40),
              width: double.infinity,
              child: Center(
                child: Text(
                  currentIndex == contents.length - 1?"Start": "Next",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext content) {
    return Container(
      height: 10.0,
      width: currentIndex == index
          ? 10
          : 6, //10 is the number for the space between the box, while 6 is the number for the size of the dot
      margin: const EdgeInsets.only(right: 4.0),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black38,
      ),
    );
  }
}
