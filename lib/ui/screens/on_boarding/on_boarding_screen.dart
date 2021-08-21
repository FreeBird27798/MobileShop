import 'package:connect_store/utils/size_config.dart';
import 'package:connect_store/ui/widgets/app_elevated_button.dart';
import 'package:connect_store/ui/widgets/on_boarding_content.dart';
import 'package:connect_store/ui/widgets/on_boarding_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _isNotLastPage = _currentPage != 2;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig().scaleWidth(25)),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (int selectedPage) {
                setState(() {
                  _currentPage = selectedPage;
                });
              },
              children: [
                OnBoardingContent(
                  image: 'on_boarding_01',
                  title: AppLocalizations.of(context)!.on_boarding_title_01,
                  message: AppLocalizations.of(context)!.on_boarding_message_01,
                ),
                OnBoardingContent(
                  image: 'on_boarding_02',
                  title: AppLocalizations.of(context)!.on_boarding_title_02,
                  message: AppLocalizations.of(context)!.on_boarding_message_02,
                ),
                OnBoardingContent(
                  image: 'on_boarding_03',
                  title: AppLocalizations.of(context)!.on_boarding_title_03,
                  message: AppLocalizations.of(context)!.on_boarding_message_03,
                ),
              ],
            ),
            PositionedDirectional(
              bottom: SizeConfig().scaleHeight(309),
              end: 0,
              start: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  OnBoardingIndicator(
                    selected: _currentPage == 0,
                    marginEnd: 10,
                  ),
                  OnBoardingIndicator(
                    selected: _currentPage == 1,
                    marginEnd: 10,
                  ),
                  OnBoardingIndicator(
                    selected: _currentPage == 2,
                  ),
                ],
              ),
            ),
            PositionedDirectional(
              bottom: SizeConfig().scaleHeight(80),
              // end: 0,
              // start: 0,
              // height: SizeConfig().scaleHeight(44),
              width: _isNotLastPage
                  ? SizeConfig().scaleWidth(44)
                  : SizeConfig().scaleWidth(136),
              child: AppElevatedButton(
                hasIcon: _isNotLastPage,
                text: _isNotLastPage
                    ? null
                    : AppLocalizations.of(context)!.get_started,
                enabled: true,
                borderRadius: SizeConfig().scaleWidth(22),
                onPressed: () {
                  setState(() {
                    if (_isNotLastPage) {
                      _pageController.nextPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.linear);
                    } else {
                      Navigator.pushReplacementNamed(context, '/register_screen');
                      //       AppPrefController().setIsFirstTime(false);
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
