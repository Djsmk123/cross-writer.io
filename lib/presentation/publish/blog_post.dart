// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blogtools/core/enum.dart';
import 'package:blogtools/core/errors/failures.dart';
import 'package:blogtools/core/utils/dialog_box.dart';
import 'package:blogtools/core/utils/extentions.dart';
import 'package:blogtools/core/utils/json_parser.dart';
import 'package:blogtools/core/utils/rounded_button.dart';
import 'package:blogtools/presentation/widgets/api_key_input_widget.dart';
import 'package:blogtools/presentation/widgets/home_screen_background_widget.dart';
import 'package:blogtools/repo/blog_repo.dart';
import 'package:blogtools/repo/models/api_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/utils/custom_text_field.dart';

@RoutePage(
  name: "post",
)
class BlogPost extends StatefulWidget {
  const BlogPost({super.key});

  @override
  State<BlogPost> createState() => _BlogPostState();
}

class _BlogPostState extends State<BlogPost> with Validation {
  BlogApiBox? apiBox;

  final TextEditingController mediumApiKey = TextEditingController();
  final TextEditingController hashNodeApiKey = TextEditingController();
  final TextEditingController hashNodeUserApiKey = TextEditingController();
  final TextEditingController devToApiKey = TextEditingController();
  final TextEditingController articleUrl = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final ScrollController _scroll = ScrollController();
  bool isLoading = false;
  bool medium = true;
  bool hash = true;
  bool devTo = true;
  bool storeApiKey = false;
  BlogSource source = BlogSource.medium;

  @override
  void initState() {
    blogSource.addListener(() {
      source = blogSource.value;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
    initAsync();
    source = blogSource.value;
    setState(() {});
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

    return WillPopScope(
      onWillPop: () async {
        context.router.replaceNamed('/');
        return true;
      },
      child: HomeScreenBackgroundWidget(
          child: !isLoading
              ? Scrollbar(
                  thickness: 0,
                  trackVisibility: false,
                  thumbVisibility: false,
                  controller: _scroll,
                  child: SingleChildScrollView(
                    controller: _scroll,
                    child: Form(
                      key: _form,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: isWeb ? 60.w : 20.w, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Article url",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isWeb ? 24.sp : 18.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(source.getLogo(),
                                    color: Colors.white,
                                    height: source != BlogSource.medium
                                        ? 50.h
                                        : 10.h,
                                    width: 30.w),
                                SizedBox(
                                  width: 10.h,
                                ),
                                Flexible(
                                  child: CustomTextField(
                                    controller: articleUrl,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "url cannot empty";
                                      }
                                      if (!isUrl(value)) {
                                        return "should be valid url";
                                      }
                                      return null;
                                    },
                                    //labelText: "Article url",
                                    hintText:
                                        "Enter ${source.getName()}'s link",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            const Divider(
                              color: Colors.white,
                              height: 5,
                              thickness: 2,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              "Configurations",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isWeb ? 24.sp : 18.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            devToApiWidget(source == BlogSource.devTo),
                            mediumApiWidget(source == BlogSource.medium),
                            hashNodeWidget(source == BlogSource.hashNode),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Remember keys?",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.h,
                                ),
                                Switch(
                                    value: storeApiKey,
                                    onChanged: (value) {
                                      setState(() {
                                        storeApiKey = value;
                                      });
                                    }),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RoundedButton(
                                  width: isWeb ? 60 : 120.w,
                                  height: 40.h,
                                  onTap: () {
                                    context.router.replaceNamed('/');
                                  },
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: isWeb ? 16 : 14),
                                  ),
                                ),
                                RoundedButton(
                                  width: isWeb ? 60 : 120.w,
                                  height: 40.h,
                                  onTap: () {
                                    onSubmit();
                                  },
                                  backgroundColor: Colors.green,
                                  child: Text(
                                    "Publish",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: isWeb ? 16 : 14),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )),
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

  onSubmit() async {
    if (_form.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final res = await BlogRepo.crossPostHelper(
          articleUrl: articleUrl.text,
          source: source,
          mediumApiKey: mediumApiKey.text,
          hashApiKey: hashNodeApiKey.text,
          hashUserKey: hashNodeUserApiKey.text,
          devApiKey: devToApiKey.text,
          isDevTo: devTo,
          isHashNode: hash,
          isMedium: medium);
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
          "Blog has been posted successfully but you might have to publish it manually from draft section.",
          DialogType.success, onTap: () {
        if (storeApiKey) {
          updateApiKey();
        }
      });
    }
  }

  updateApiKey() async {
    bool isNew = apiBox == null;
    if (isNew) {
      apiBox = BlogApiBox(null, null, null, null);
    }
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
  }
}
