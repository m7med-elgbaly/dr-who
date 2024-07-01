import 'package:flutter/material.dart';
import 'package:heathly/constants.dart';
import 'package:heathly/screens/firebaseAuth.dart';
import 'package:heathly/screens/onboarding/components/main_button.dart';
import 'package:heathly/screens/onboarding/components/skip_button.dart';
import 'package:heathly/screens/onboarding/components/slider_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int selectedSlider = 0;
  // Slider Data
  List<Map<String, String>> sliders = [
    {
      "title": "Search Doctors",
      "text":
          "The application helps to search for popular doctors near you and know the reviews of the latter and the location of the doctor",
      "image": "assets/vector-doc.jpg"
    },
    {
      "title": "Doctor Appointments",
      "text":
          "Helps to book an appointment at any time with the desired good at the right time from anywhere",
      "image": "assets/appointment.jpg"
    },
    {
      "title": "The Diseases",
      "text":
          "Helps in identifying diseases, how they spread, and what medications cause debilitation and risk in case of infection with this disease",
      "image": "assets/414-bg.png"
    },
  ];

  PageController sliderController =
      PageController(initialPage: 0, keepPage: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SkipButton(
                tapEvent: () => _pushPage(context, const FireBaseAuth()),
              ),
              Expanded(
                flex: 2,
                child: PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        selectedSlider = index;
                      });
                    },
                    controller: sliderController,
                    itemCount: sliders.length,
                    itemBuilder: (context, index) => SliderContent(
                          image: sliders[index]['image'],
                          title: sliders[index]['title'],
                          text: sliders[index]['text'],
                        )),
              ),
              const SizedBox(height: kDefaultPadding),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        sliders.length,
                        (index) => buildSliderNav(index: index),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: Row(
                        children: [
                          const Spacer(),
                          MainButton(
                            tapEvent: () {
                              if (selectedSlider != (sliders.length - 1)) {
                                sliderController.animateToPage(
                                    selectedSlider + 1,
                                    duration: Duration(milliseconds: 40),
                                    curve: Curves.linear);
                              }
                              if (selectedSlider == (sliders.length - 1)) {
                                _pushPage(context, const FireBaseAuth());
                              }
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildSliderNav({int? index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 20),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color:
              selectedSlider == index ? kPrimaryColor : const Color(0xFFD7D7D7),
          borderRadius: BorderRadius.circular(5)),
    );
  }
}

void _pushPage(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => page),
  );
}
