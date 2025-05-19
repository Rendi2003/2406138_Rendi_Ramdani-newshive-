import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newshive/routes/route_names.dart';
import 'package:newshive/views/utils/helper.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _numPages = 3;

  void _goToNextPage() {
    if (_currentPage < _numPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _navigateToLogin() {
    context.goNamed(RouteName.login);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: cWhite,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    // Page 1
                    Container(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: Image.asset(
                                'assets/img_intro_1.png',
                                width: screenWidth * 0.8,
                                height: screenHeight * 0.4,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          vsLarge,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'The World at Your Fingertips',
                                  style: headline4.copyWith(
                                    color: cPrimary,
                                    fontWeight: semibold,
                                  ),
                                ),
                                vsTiny,
                                Text(
                                  'Get 24/7 updates on global news – from breaking politics to cultural trends, all in one place',
                                  style: subtitle2.copyWith(color: cTextBlue),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Page 2
                    Container(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: Image.asset(
                                'assets/img_intro_2.png',
                                width: screenWidth * 0.8,
                                height: screenHeight * 0.4,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          vsLarge,
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: cPrimary,
                            margin: const EdgeInsets.only(bottom: 8),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tailored to Your Curiosity',
                                  style: headline4.copyWith(
                                    color: cPrimary,
                                    fontWeight: semibold,
                                  ),
                                ),
                                vsTiny,
                                Text(
                                  'Select your interests and receive hand‑picked stories. Technology, sports, or entertainment – we\'ve got you covered',
                                  style: subtitle2.copyWith(color: cTextBlue),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Page 3
                    Container(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: Image.asset(
                                'assets/img_intro_3.png',
                                width: screenWidth * 0.8,
                                height: screenHeight * 0.4,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          vsLarge,
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: cPrimary,
                            margin: const EdgeInsets.only(bottom: 8),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Trusted Updates in Real‑Time',
                                  style: headline4.copyWith(
                                    color: cPrimary,
                                    fontWeight: semibold,
                                  ),
                                ),
                                vsTiny,
                                Text(
                                  'Instant alerts for breaking news, rigorously fact‑checked by our editors before they reach you',
                                  style: subtitle2.copyWith(color: cTextBlue),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Page Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_numPages, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(right: 6),
                    width: _currentPage == index ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? cPrimary : cLinear,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),

              vsLarge,

              // Bottom Buttons
              _currentPage == _numPages - 1
                  ? SizedBox(
                      width: screenWidth * 0.9,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _navigateToLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cPrimary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Get Started',
                          style: subtitle1.copyWith(
                            color: cWhite,
                            fontWeight: semibold,
                          ),
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        TextButton(
                          onPressed: () => context.goNamed(RouteName.login),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Skip',
                            style: subtitle1.copyWith(
                              color: cPrimary,
                              fontWeight: medium,
                            ),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: screenWidth * 0.45,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _goToNextPage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: cPrimary,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Next',
                              style: subtitle1.copyWith(
                                color: cWhite,
                                fontWeight: semibold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
