// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blogtools/core/enum.dart';
import 'package:blogtools/core/errors/failures.dart';
import 'package:blogtools/core/utils/dialog_box.dart';
import 'package:blogtools/core/utils/extentions.dart';
import 'package:blogtools/presentation/widgets/api_key_input_widget.dart';
import 'package:blogtools/presentation/widgets/home_screen_background_widget.dart';
import 'package:blogtools/repo/blog_repo.dart';
import 'package:blogtools/repo/models/api_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/utils/rounded_button.dart';

@RoutePage(name: 'ApisKeyPage')
class ApiKeys extends StatefulWidget {
  const ApiKeys({super.key});

  @override
  State<ApiKeys> createState() => _ApiKeysState();
}

class _ApiKeysState extends State<ApiKeys> {
  BlogApiBox? apiBox;

  final TextEditingController mediumApiKey = TextEditingController();
  final TextEditingController hashNodeApiKey = TextEditingController();
  final TextEditingController hashNodeUserApiKey = TextEditingController();
  final TextEditingController devToApiKey = TextEditingController();
  final TextEditingController articleUrl = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool isLoading = false;
  bool medium = true;
  bool devTo = true;
  bool hash = true;
  @override
  void initState() {
    super.initState();
    initAsync();
  }

  initAsync() async {
    setState(() {
      isLoading = true;
    });
    final res = await BlogRepo.fetchAPIKeys();

    if (res.$1 == null && res.$2 != null) {
      mediumApiKey.text = res.$2?.mediumApiKey ?? "";
      hashNodeApiKey.text = res.$2?.hashApiKey ?? "";
      hashNodeUserApiKey.text = res.$2?.hashUserId ?? "";
      devToApiKey.text = res.$2?.devToApiKey ?? "";
      apiBox = res.$2;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    hashNodeApiKey.dispose();
    mediumApiKey.dispose();
    devToApiKey.dispose();
    hashNodeUserApiKey.dispose();
    articleUrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isWeb = context.isWeb();
    return HomeScreenBackgroundWidget(
        child: !isLoading
            ? Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),
                      Center(
                        child: Text(
                          "APIs Key Configurations",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: isWeb ? 24.sp : 18.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: isWeb ? 30.w : 20.w, vertical: 20.h),
                          child: const Text(
                            "Welcome to our API Key Manager! Securely store and remember your API keys. Simply enter your key and click 'Save' to access your favorite services effortlessly.",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                      //dev.to API
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: isWeb ? 60.w : 20.w, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            apiWidget(BlogSource.devTo),
                            apiWidget(BlogSource.medium),
                            apiWidget(BlogSource.hashNode),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: isWeb ? 60.w : 20.w, vertical: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RoundedButton(
                              width: isWeb ? 30 : 100,
                              height: 50,
                              onTap: onSubmit,
                              backgroundColor: Colors.blueAccent,
                              child: const Text(
                                "Save",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ));
  }

  void onSubmit() async {
    if (_form.currentState!.validate()) {
      updateApiKey();
    }
  }

  updateApiKey() async {
    bool isNew = apiBox == null;
    setState(() {
      isLoading = true;
    });
    if (devTo && devToApiKey.text.isNotEmpty) {
      apiBox = apiBox?.copyWith(devToApiKey: devToApiKey.text);
      //devToApiKey.clear();
    }
    if (medium && mediumApiKey.text.isNotEmpty) {
      apiBox = apiBox?.copyWith(mediumApiKey: mediumApiKey.text);
      // mediumApiKey.clear();
    }
    if (hash) {
      if (hashNodeUserApiKey.text.isNotEmpty) {
        apiBox = apiBox?.copyWith(hashUserId: hashNodeUserApiKey.text);
      }
      if (hashNodeApiKey.text.isNotEmpty) {
        apiBox = apiBox?.copyWith(hashApiKey: hashNodeApiKey.text);
      }
    }
    final res = isNew
        ? await BlogRepo.addAPIKey(apiBox!)
        : (await BlogRepo.updateApiKey(apiBox!));
    setState(() {
      isLoading = false;
    });
    if (res != null) {
      showDialogCustom(
        context,
        "Failed",
        getErrorMessage(res),
        DialogType.error,
      );
      return;
    }
    showDialogCustom(
      context,
      "Success",
      "API keys has been successfully saved",
      DialogType.success,
    );
  }

  Widget apiWidget(BlogSource source) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(source.getLogo(),
              color: Colors.white,
              height: source != BlogSource.medium ? 50.h : 30.h,
              width: 40.w),
          SizedBox(
            height: 10.h,
          ),
          Divider(
            color: Colors.white,
            thickness: 1,
            height: 5.h,
          ),
          SizedBox(
            height: 20.h,
          ),
          if (source == BlogSource.devTo) devToApiWidget(true),
          if (source == BlogSource.medium) mediumApiWidget(true),
          if (source == BlogSource.hashNode) hashNodeWidget(true),
        ],
      ),
    );
  }

  Widget devToApiWidget(bool isRequired) {
    return ApiInputWidget(
      isRequired: isRequired,
      controller: devToApiKey,
      isActive: devTo,
      validator: (value) {
        if (isRequired && value!.isEmpty && devTo) {
          return "Key is required";
        }
        return null;
      },
      onChangeAction: (value) {
        devTo = !value;
        setState(() {});
      },
      hintText: 'dev.to API key',
    );
  }

  Widget mediumApiWidget(bool isRequired) {
    return ApiInputWidget(
      isRequired: isRequired,
      controller: mediumApiKey,
      hintText: 'medium API key',
      isActive: medium,
      validator: (value) {
        if (value!.isEmpty && medium) {
          return "Key is required";
        }
        return null;
      },
      onChangeAction: (value) {
        medium = !value;
        setState(() {});
      },
    );
  }

  Widget hashNodeWidget(bool isRequired) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ApiInputWidget(
          isRequired: isRequired,
          controller: hashNodeApiKey,
          hintText: 'hashnode API key',
          validator: (value) {
            if (value!.isEmpty && hash) {
              return "Key is required";
            }
            return null;
          },
          isActive: hash,
          onChangeAction: (value) {
            hash = !value;
            setState(() {});
          },
        ),
        SizedBox(
          height: 20.h,
        ),
        ApiInputWidget(
          isRequired: isRequired,
          controller: hashNodeUserApiKey,
          hintText: 'hashnode user_id key',
          validator: (value) {
            if (value!.isEmpty && hash) {
              return "Key is required";
            }
            return null;
          },
          isActive: hash,
          onChangeAction: (value) {
            hash = !value;
            setState(() {});
          },
        ),
      ],
    );
  }
}
