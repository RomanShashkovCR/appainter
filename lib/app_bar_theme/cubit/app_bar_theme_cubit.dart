import 'dart:async';

import 'package:appainter/abstract_icon_theme/abstract_icon_theme.dart';
import 'package:appainter/abstract_text_style/abstract_text_style.dart';
import 'package:appainter/app_bar_theme/app_bar_theme.dart';
import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:appainter/models/models.dart';

part 'app_bar_theme_cubit.g.dart';
part 'app_bar_theme_state.dart';

class AppBarThemeCubit extends Cubit<AppBarThemeState> {
  final AppBarActionsIconThemeCubit actionsIconThemeCubit;
  final AppBarIconThemeCubit iconThemeCubit;
  final AppBarTitleTextStyleCubit titleTextStyleCubit;
  final AppBarToolbarTextStyleCubit toolbarTextStyleCubit;

  late final StreamSubscription actionsIconThemeCubitSubscription;
  late final StreamSubscription iconThemeCubitSubscription;
  late final StreamSubscription titleTextStyleCubitSubscription;
  late final StreamSubscription toolbarTextStyleCubitSubscription;

  AppBarThemeCubit({
    required this.actionsIconThemeCubit,
    required this.iconThemeCubit,
    required this.titleTextStyleCubit,
    required this.toolbarTextStyleCubit,
  }) : super(const AppBarThemeState()) {
    actionsIconThemeCubitSubscription = actionsIconThemeCubit.stream.listen(
      (otherState) {
        final theme = state.theme.copyWith(actionsIconTheme: otherState.theme);
        emit(state.copyWith(theme: theme));
      },
    );
    iconThemeCubitSubscription = iconThemeCubit.stream.listen(
      (otherState) {
        final theme = state.theme.copyWith(iconTheme: otherState.theme);
        emit(state.copyWith(theme: theme));
      },
    );
    titleTextStyleCubitSubscription = titleTextStyleCubit.stream.listen(
      (otherState) {
        final theme = state.theme.copyWith(titleTextStyle: otherState.style);
        emit(state.copyWith(theme: theme));
      },
    );
    toolbarTextStyleCubitSubscription = toolbarTextStyleCubit.stream.listen(
      (otherState) {
        final theme = state.theme.copyWith(toolbarTextStyle: otherState.style);
        emit(state.copyWith(theme: theme));
      },
    );
  }

  @override
  Future<void> close() {
    actionsIconThemeCubitSubscription.cancel();
    iconThemeCubitSubscription.cancel();
    titleTextStyleCubitSubscription.cancel();
    toolbarTextStyleCubitSubscription.cancel();
    return super.close();
  }

  void themeChanged(AppBarTheme theme) {
    actionsIconThemeCubit.themeChanged(
      theme.actionsIconTheme ?? kAppBarIconTheme,
    );
    iconThemeCubit.themeChanged(
      theme.actionsIconTheme ?? kAppBarIconTheme,
    );
    titleTextStyleCubit.styleChanged(
      theme.titleTextStyle ?? kAppBarTitleTextStyle,
    );
    toolbarTextStyleCubit.styleChanged(
      theme.toolbarTextStyle ?? kAppBarToolbarTextStyle,
    );
    emit(state.copyWith(theme: theme));
  }

  void backgroundColorChanged(Color color) {
    final theme = state.theme.copyWith(backgroundColor: color);
    emit(state.copyWith(theme: theme));
  }

  void foregroundColorChanged(Color color) {
    final theme = state.theme.copyWith(foregroundColor: color);
    emit(state.copyWith(theme: theme));
  }

  void elevationChanged(String value) {
    final elevation = double.tryParse(value);
    if (elevation != null) {
      final theme = state.theme.copyWith(elevation: elevation);
      emit(state.copyWith(theme: theme));
    }
  }

  void shadowColorChanged(Color color) {
    final theme = state.theme.copyWith(shadowColor: color);
    emit(state.copyWith(theme: theme));
  }

  void centerTitleChanged(bool isCenter) {
    final theme = state.theme.copyWith(centerTitle: isCenter);
    emit(state.copyWith(theme: theme));
  }

  void titleSpacingChanged(String value) {
    final spacing = double.tryParse(value);
    if (spacing != null) {
      final theme = state.theme.copyWith(titleSpacing: spacing);
      emit(state.copyWith(theme: theme));
    }
  }

  void toolBarHeightChanged(String value) {
    final height = double.tryParse(value);
    if (height != null) {
      final theme = state.theme.copyWith(toolbarHeight: height);
      emit(state.copyWith(theme: theme));
    }
  }

  void systemUiOverlayStyleChanged(String value) {
    final style = MySystemUiOverlayStyle().fromString(value);
    if (style != null) {
      final theme = state.theme.copyWith(systemOverlayStyle: style);
      emit(state.copyWith(theme: theme));
    }
  }
}

class AppBarActionsIconThemeCubit extends AbstractIconThemeCubit {}

class AppBarIconThemeCubit extends AbstractIconThemeCubit {}

class AppBarTitleTextStyleCubit extends AbstractTextStyleCubit {
  AppBarTitleTextStyleCubit() : super(defaultStyle: kAppBarTitleTextStyle);
}

class AppBarToolbarTextStyleCubit extends AbstractTextStyleCubit {
  AppBarToolbarTextStyleCubit() : super(defaultStyle: kAppBarToolbarTextStyle);
}
