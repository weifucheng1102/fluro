/*
 * fluro
 * Created by Yakka
 * https://theyakka.com
 * 
 * Copyright (c) 2019 Yakka, LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/widgets.dart';

///
enum HandlerType { route, function, future }

///
class Handler {
  Handler({this.type = HandlerType.route, this.handlerFunc});
  final HandlerType type;
  final HandlerFunc handlerFunc;
}

///
typedef Route<T> RouteCreator<T>(
    RouteSettings route, Map<String, List<String>> parameters);

///
typedef Widget HandlerFunc(
    BuildContext context, Map<String, List<String>> parameters,
    [dynamic object]);

///
class AppRoute {
  String route;
  dynamic handler;
  TransitionType transitionType;
  AppRoute(this.route, this.handler, {this.transitionType});
}

enum TransitionType {
  native,
  nativeModal,
  inFromLeft,
  inFromRight,
  inFromBottom,
  fadeIn,
  custom, // if using custom then you must also provide a transition
  material,
  materialFullScreenDialog,
  cupertino,
  cupertinoFullScreenDialog,
}

enum RouteMatchType {
  visual,
  nonVisual,
  noMatch,
}

///
class RouteMatch {
  RouteMatch({
    this.matchType = RouteMatchType.noMatch,
    this.route,
    this.errorMessage = "Unable to match route. Please check the logs.",
    this.handler,
    this.parameters,
    this.object,
  });
  final Route<dynamic> route;
  final RouteMatchType matchType;
  final String errorMessage;
  final Handler handler;
  final Map<String, List<String>> parameters;
  final dynamic object;
}

class RouteNotFoundException implements Exception {
  final String message;
  final String path;
  RouteNotFoundException(this.message, this.path);

  @override
  String toString() {
    return "No registered route was found to handle '$path'";
  }
}
