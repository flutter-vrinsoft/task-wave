import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';
import 'package:task_wave/core/routes/app_routes.dart';
import 'package:task_wave/core/theme/app_sizes.dart';
import 'package:task_wave/core/util/constants/app_image.dart';
import 'package:task_wave/core/util/constants/app_strings.dart';
import 'package:task_wave/core/util/helper_functions/extension_functions.dart';
import 'package:task_wave/core/util/helper_functions/helper_functions.dart';
import 'package:task_wave/core/util/services/shared_preference_service.dart';
import 'package:task_wave/features/kanban_board/presentation/widgets/on_boarding_page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnBoardingScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: AppStrings.welcomeToTaskWave,
      description: AppStrings.thisIsAwesomeApp,
      image: AppImages.onBoarding1,
    ),
    OnboardingPage(
      title: AppStrings.exploreFeatures,
      description: AppStrings.discoverManyFeatures,
      image: AppImages.onBoarding2,
    ),
    OnboardingPage(
      title: AppStrings.getStarted,
      description: AppStrings.letsGetStarted,
      image: AppImages.onBoarding3,
    ),
  ];

  int _currentPage = 0;
  List colors = const [
    Color(0xffDAD3C8),
    Color(0xffFFE5DE),
    Color(0xffDCF6E6),
  ];

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: Color(0xFF000000),
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors[_currentPage],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _controller,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: _pages.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Image.asset(
                          _pages[i].image,
                          height: 350.h,
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        _pages[i].title.toTextWidget(
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 30.sp,
                              ),
                            ),
                        context.vGap16,
                        _pages[i].description.toTextWidget(
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 17.sp,
                              ),
                              textAlign: TextAlign.center,
                            )
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (int index) => _buildDots(
                        index: index,
                      ),
                    ),
                  ),
                  _currentPage + 1 == _pages.length
                      ? Padding(
                          padding: const EdgeInsets.all(30),
                          child: ElevatedButton(
                            onPressed: () {
                              SharedPreferencesService.instance!.isFirstTime = false;
                              replacePage(context, AppRoutes.homeRoute);
                            },
                            child: AppStrings.start.toTextWidget(
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp, color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                              textStyle: TextStyle(fontSize: 13),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  _controller.jumpToPage(2);
                                },
                                child: AppStrings.skip.toTextWidget(
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: TextButton.styleFrom(
                                  elevation: 0,
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _controller.nextPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                },
                                child: AppStrings.next.toTextWidget(
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp, color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                                  textStyle: TextStyle(fontSize: 1),
                                ),
                              ),
                            ],
                          ),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
