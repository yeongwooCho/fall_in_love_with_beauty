import 'package:fall_in_love_with_beauty/ai/view/ai_screen.dart';
import 'package:fall_in_love_with_beauty/ai/view/input_recommand_screen.dart';
import 'package:fall_in_love_with_beauty/ai/view/result_prefer_screen.dart';
import 'package:fall_in_love_with_beauty/common/view/scaffold_with_nav.dart';
import 'package:fall_in_love_with_beauty/home/view/home_screen.dart';
import 'package:fall_in_love_with_beauty/notification/view/notification_detail_screen.dart';
import 'package:fall_in_love_with_beauty/notification/view/notification_screen.dart';
import 'package:fall_in_love_with_beauty/product/view/designer_detail_screen.dart';
import 'package:fall_in_love_with_beauty/product/view/like_list_screen.dart';
import 'package:fall_in_love_with_beauty/product/view/product_detail_screen.dart';
import 'package:fall_in_love_with_beauty/product/view/product_screen.dart';
import 'package:fall_in_love_with_beauty/reserve/view/select_kind_of_result_screen.dart';
import 'package:fall_in_love_with_beauty/user/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../home/view/map_screen.dart';
import '../../reserve/view/create_reservation_screen.dart';
import '../../reserve/view/management_reservation_screen.dart';
import '../../reserve/view/reservation_detail_screen.dart';
import '../../user/view/certification_screen.dart';
import '../../user/view/custom_sns_screen.dart';
import '../../user/view/edit_profile_screen.dart';
import '../../user/view/email_login_screen.dart';
import '../../user/view/find_id_screen.dart';
import '../../user/view/find_password_input_screen.dart';
import '../../user/view/find_password_screen.dart';
import '../../user/view/input_info_screen.dart';
import '../../user/view/login_screen.dart';
import '../../user/view/term_detail_screen.dart';
import '../../user/view/term_screen.dart';
import '../view/completion_screen.dart';
import '../view/completion_screen_to_email_login.dart';
import '../view/error_screen.dart';
import '../view/splash_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  redirect: null,
  initialLocation: '/splash',
  routes: routes,
  errorBuilder: (context, state) => ErrorScreen(
    error: state.error.toString(),
  ),
  debugLogDiagnostics: true,
);

List<RouteBase> get routes => [
      StatefulShellRoute.indexedStack(
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/home",
                name: HomeScreen.routeName,
                builder: (context, state) => HomeScreen(),
                routes: [
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: "map",
                    name: MapScreen.routeName,
                    builder: (context, state) => MapScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/ai",
                name: AIScreen.routeName,
                builder: (context, state) => AIScreen(),
                routes: [
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'input_recommend',
                    name: InputRecommendScreen.routeName,
                    builder: (context, state) => InputRecommendScreen(),
                    routes: [
                      GoRoute(
                        parentNavigatorKey: _rootNavigatorKey,
                        path: 'result_prefer',
                        name: ResultPreferScreen.routeName,
                        builder: (context, state) => ResultPreferScreen(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/product",
                name: ProductScreen.routeName,
                builder: (context, state) => ProductScreen(),
                routes: [
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: "designer/:id",
                    name: DesignerDetailScreen.routeName,
                    builder: (context, state) {
                      final String id = state.pathParameters['id']!;

                      return DesignerDetailScreen(id: id);
                    },
                  ),
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: ":id",
                    name: ProductDetailScreen.routeName,
                    builder: (context, state) {
                      final String id = state.pathParameters['id']!;

                      return ProductDetailScreen(id: id);
                    },
                  ),

                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                name: ProfileScreen.routeName,
                builder: (context, state) => ProfileScreen(),
                routes: [
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'edit',
                    name: EditProfileScreen.routeName,
                    builder: (context, state) => EditProfileScreen(),
                  ),
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'like_list',
                    name: LikeListScreen.routeName,
                    builder: (context, state) => LikeListScreen(),
                  ),
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'management_reserve',
                    name: ManagementReservationScreen.routeName,
                    builder: (context, state) => ManagementReservationScreen(),
                    routes: [
                      GoRoute(
                        parentNavigatorKey: _rootNavigatorKey,
                        path: ':id',
                        name: ReservationDetailScreen.routeName,
                        builder: (context, state) {
                          final id = state.pathParameters['id']!;

                          return ReservationDetailScreen(id: id);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          return ScaffoldWithNav(navigationShell: navigationShell);
        },
      ),

      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/create_reserve/:id',
        name: CreateReservationScreen.routeName,
        builder: (context, state) {
          final id = state.pathParameters["id"]!;

          return CreateReservationScreen(id: id);
        },
        routes: [
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: ':rid',
            name: SelectKindOfResultScreen.routeName,
            builder: (context, state) {
              final rid = state.pathParameters["rid"]!;

              return SelectKindOfResultScreen(rid: rid);
            },
          ),
        ],
      ),

      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/splash',
        name: SplashScreen.routeName,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: '/completion/:title',
        name: CompletionScreen.routeName,
        builder: (context, state) {
          final String title = state.pathParameters['title']!;

          return CompletionScreen(title: title);
        },
      ),
      GoRoute(
        path: '/completion_find/:title',
        name: CompletionScreenToEmailLogin.routeName,
        builder: (context, state) {
          final parameters = GoRouterState.of(context).pathParameters;

          return CompletionScreenToEmailLogin(title: parameters['title']!);
        },
      ),
      GoRoute(
        path: '/sns/:title',
        name: CustomSnsScreen.routeName,
        builder: (context, state) => CustomSnsScreen(),
      ),
      GoRoute(
        path: '/login',
        name: LoginScreen.routeName,
        builder: (context, state) => LoginScreen(),
        routes: [
          GoRoute(
            path: 'email_login',
            name: EmailLoginScreen.routeName,
            builder: (context, state) => EmailLoginScreen(),
            routes: [
              GoRoute(
                path: 'term',
                name: TermScreen.routeName,
                builder: (context, state) => TermScreen(),
                routes: [
                  GoRoute(
                    path: 'detail/:id',
                    name: TermDetailScreen.routeName,
                    builder: (context, state) => TermDetailScreen(),
                  ),
                ],
              ),
              GoRoute(
                path: 'certification',
                name: CertificationScreen.routeName,
                builder: (context, state) => CertificationScreen(),
                routes: [
                  GoRoute(
                    path: 'input_info',
                    name: InputInfoScreen.routeName,
                    builder: (context, state) => InputInfoScreen(),
                  ),
                ],
              ),
              GoRoute(
                path: 'find_id',
                name: FindIdScreen.routeName,
                builder: (context, state) => FindIdScreen(),
              ),
              GoRoute(
                path: 'find_password',
                name: FindPasswordScreen.routeName,
                builder: (context, state) => FindPasswordScreen(),
                routes: [
                  GoRoute(
                    path: 'input',
                    name: FindPasswordInputScreen.routeName,
                    builder: (context, state) => FindPasswordInputScreen(),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/notification',
        name: NotificationScreen.routeName,
        builder: (context, state) => NotificationScreen(),
        routes: [
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: ':id',
            name: NotificationDetailScreen.routeName,
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return NotificationDetailScreen(id: id);
            },
          ),
        ],
      ),

      // GoRoute(
      //   parentNavigatorKey: _rootNavigatorKey,
      //   path: '/cart',
      //   name: CartScreen.routeName,
      //   builder: (context, state) => CartScreen(),
      // ),
      // GoRoute(
      //   parentNavigatorKey: _rootNavigatorKey,
      //   path: '/create_order',
      //   name: CreateOrderScreen.routeName,
      //   builder: (context, state) => CreateOrderScreen(),
      // ),
      // GoRoute(
      //   parentNavigatorKey: _rootNavigatorKey,
      //   path: '/order_list',
      //   name: OrderListScreen.routeName,
      //   builder: (context, state) => OrderListScreen(),
      //   routes: [
      //     GoRoute(
      //       parentNavigatorKey: _rootNavigatorKey,
      //       path: ':id',
      //       name: OrderDetailScreen.routeName,
      //       builder: (context, state) {
      //         String id = state.pathParameters['id']!;
      //         return OrderDetailScreen(id: id);
      //       },
      //     ),
      //   ],
      // ),
    ];
