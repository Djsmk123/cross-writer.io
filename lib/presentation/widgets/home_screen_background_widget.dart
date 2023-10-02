import 'package:auto_route/auto_route.dart';
import 'package:blogtools/core/utils/extentions.dart';
import 'package:blogtools/routing/routing_dat.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

class HomeScreenBackgroundWidget extends StatelessWidget {
  final Widget child;
  const HomeScreenBackgroundWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    bool isWeb = context.isWeb();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(
          Icons.account_tree_rounded,
          color: Colors.white,
          size: 30,
        ),
        title: Text(
          "Cross-Writer.io",
          style:
              TextStyle(color: Colors.white, fontSize: isWeb ? 24.sp : 16.sp),
        ),
        actions: [
          TextButton(
              onPressed: () {
                context.navigateTo(const Homepage());
              },
              child: Text(
                "Home",
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              )),
          TextButton(
              onPressed: () {
                context.navigateTo(const ApisKeyPage());
              },
              child: Text(
                "API Keys",
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              )),
        ],
      ),
      backgroundColor: const Color(0XFF1E2430),
      body: FooterView(
        flex: 9,
        footer: Footer(
            backgroundColor: Colors.black,
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                const Icon(
                  Icons.account_tree_rounded,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: Text(
                    "Cross-Writer.io",
                    style: TextStyle(
                        color: Colors.white, fontSize: isWeb ? 24.sp : 16.sp),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Made by Smk-Winner with ",
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      ),
                      Text(
                        "❤️",
                        style: TextStyle(color: Colors.red, fontSize: 18.sp),
                      )
                    ],
                  ),
                )
              ],
            )),
        children: [child],
      ),
    );
  }
}
