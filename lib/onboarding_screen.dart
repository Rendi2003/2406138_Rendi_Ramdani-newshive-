import 'package:flutter/material.dart';
import 'package:newshive/views/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "The World at Your Fingertips",
      "description":
          "Get 24/7 updates on global news – from breaking politics to cultural trends, all in one place",
      "image": "assets/img_intro_1.png",
    },
    {
      "title": "Tailored to Your Curiosity",
      "description":
          "Select your interests and receive handpicked stories. Technology, sports, or entertainment – we've got you covered",
      "image": "assets/img_intro_2.png",
    },
    {
      "title": "Trusted Updates in Real-Time",
      "description":
          "Instant alerts for breaking news, rigorously fact-checked by our editors before they reach you",
      "image": "assets/img_intro_3.png",
    },
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboardingData.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          Image.asset(
                            onboardingData[index]["image"]!,
                            height: 300,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            onboardingData[index]["title"]!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            onboardingData[index]["description"]!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black87),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // INDICATOR
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingData.length,
                  (index) => buildDot(index: index),
                ),
              ),

              const SizedBox(height: 24),

              // BUTTONS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: _currentPage == onboardingData.length - 1
                    ? Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: ElevatedButton(
                            onPressed: _goToLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Get Started',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                _pageController
                                    .jumpToPage(onboardingData.length - 1);
                              },
                              child: const Text(
                                "Skip",
                                style: TextStyle(color: Colors.indigo),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _nextPage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Next',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // Dot indicator
  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 6),
      height: 8,
      width: _currentPage == index ? 20 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? Colors.indigo
            : Colors.indigo.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
