import 'package:auto_route/auto_route.dart';
import 'package:blogtools/core/enum.dart';
import 'package:blogtools/routing/routing_dat.gr.dart';
import 'package:flutter/material.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => RouteType.custom(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ); //.cupertino, .adaptive ..etc

  @override
  final List<AutoRoute> routes = <CustomRoute>[
    CustomRoute(path: '/', initial: true, page: Homepage.page),
    CustomRoute(
      path: '/publish/:type',
      page: Post.page,
      keepHistory: true,
      guards: [PublishBlogGuard()],
    ),
    CustomRoute(
      path: '/api-keys',
      page: ApisKeyPage.page,
    )
  ];
}

class PublishBlogGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (resolver.route.pathParams.optString('type')?.toLowerCase() ==
        BlogSource.medium.name.toLowerCase()) {
      blogSource.value = BlogSource.medium;
    } else if (resolver.route.pathParams.optString('type')?.toLowerCase() ==
        BlogSource.hashNode.name.toLowerCase()) {
      blogSource.value = BlogSource.hashNode;
    } else if (resolver.route.pathParams.optString('type')?.toLowerCase() ==
        BlogSource.devTo.name.toLowerCase()) {
      blogSource.value = BlogSource.devTo;
    }
    resolver.next(true);
  }
}
