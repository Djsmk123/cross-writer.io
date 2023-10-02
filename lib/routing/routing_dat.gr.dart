// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:blogtools/presentation/api__keys/api_keys.dart' as _i1;
import 'package:blogtools/presentation/home_screen/home_screen.dart' as _i2;
import 'package:blogtools/presentation/publish/blog_post.dart' as _i3;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    ApisKeyPage.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ApiKeys(),
      );
    },
    Homepage.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreen(),
      );
    },
    Post.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.BlogPost(),
      );
    },
  };
}

/// generated route for
/// [_i1.ApiKeys]
class ApisKeyPage extends _i4.PageRouteInfo<void> {
  const ApisKeyPage({List<_i4.PageRouteInfo>? children})
      : super(
          ApisKeyPage.name,
          initialChildren: children,
        );

  static const String name = 'ApisKeyPage';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeScreen]
class Homepage extends _i4.PageRouteInfo<void> {
  const Homepage({List<_i4.PageRouteInfo>? children})
      : super(
          Homepage.name,
          initialChildren: children,
        );

  static const String name = 'Homepage';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.BlogPost]
class Post extends _i4.PageRouteInfo<void> {
  const Post({List<_i4.PageRouteInfo>? children})
      : super(
          Post.name,
          initialChildren: children,
        );

  static const String name = 'Post';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
