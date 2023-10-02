import 'package:auto_route/auto_route.dart';
import 'package:blogtools/core/enum.dart';
import 'package:blogtools/core/utils/extentions.dart';
import 'package:blogtools/presentation/widgets/home_screen_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/rounded_button.dart';
import '../../gen/assets.gen.dart';

@RoutePage(name: "homepage")
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isWeb = context.isWeb();
    return HomeScreenBackgroundWidget(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Center(
              child: Text(
                "Cross-Writer.io",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isWeb ? 40 : 30,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: isWeb ? 30.w : 20.w, vertical: 20.h),
                child: const Text(
                  "Cross-Writer.io is the renewed and revamped version of the previously known 'Integrate.io' project, which had been left dormant for some time.The primary aim of Cross-Writer.io is to simplify and streamline the process of cross-posting your blog content across various blogging platforms,making it easier than ever to reach a wider audience and increase your online presence.",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Center(
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: isWeb ? 30.w : 20.w, vertical: 20.h),
                    child: InkWell(
                        onTap: () async {
                          if (await canLaunchUrl(Uri.parse(
                              "https://github.com/Djsmk123/integrate-io"))) {
                            launchUrl(Uri.parse(
                                "https://github.com/Djsmk123/integrate-io"));
                          }
                        },
                        child: Container(
                          height: 50.h,
                          width: isWeb ? 50.w : 100.w,
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(32.r)),
                          child: Assets.images.github.image(),
                        )))),
            Center(
              child: Text(
                "Choose your blog source",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: isWeb ? 30 : 20,
                ),
              ),
            ),
            Center(
                child: RoundedButton(
              width: isWeb ? 100 : 200,
              backgroundColor: Colors.deepPurple,
              onTap: () {
                onPublish(BlogSource.devTo, context);
              },
              child: Text(
                "DEV.TO",
                style: TextStyle(color: Colors.white, fontSize: 24.sp),
              ),
            )),
            Center(
                child: RoundedButton(
              width: isWeb ? 100 : 200,
              backgroundColor: Colors.pink,
              onTap: () {
                onPublish(BlogSource.medium, context);
              },
              child: Text(
                "Medium",
                style: TextStyle(color: Colors.white, fontSize: 24.sp),
              ),
            )),
            Center(
                child: RoundedButton(
              width: isWeb ? 100 : 200,
              backgroundColor: Colors.lightBlue,
              onTap: () {
                onPublish(BlogSource.hashNode, context);
              },
              child: Text(
                "HashNode",
                style: TextStyle(color: Colors.white, fontSize: 24.sp),
              ),
            )),
          ],
        ),
      ),
    );
  }

  onPublish(BlogSource source, BuildContext context) {
    context.navigateNamedTo('/publish/${source.name}');
  }
}
