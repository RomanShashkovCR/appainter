import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appainter/checkbox_theme/checkbox_theme.dart';
import 'package:appainter/services/services.dart';
import 'package:random_color_scheme/random_color_scheme.dart';

import '../utils.dart';

void main() {
  late CheckboxThemeCubit cubit;
  late CheckboxThemeData theme;
  late Color color;
  late double doubleValue;

  late Color fillDefaultColor;
  late Color fillSelectedColor;
  late Color fillDisabledColor;

  late Color overlayPressedColor;
  late Color overlayHoveredColor;
  late Color overlayFocusedColor;

  setUpAll(() {
    final themeData = ThemeData();

    fillDefaultColor = themeData.unselectedWidgetColor;
    fillSelectedColor = themeData.toggleableActiveColor;
    fillDisabledColor = themeData.disabledColor;

    overlayPressedColor = fillSelectedColor.withAlpha(kRadialReactionAlpha);
    overlayHoveredColor = themeData.hoverColor;
    overlayFocusedColor = themeData.focusColor;
  });

  setUp(() {
    cubit = CheckboxThemeCubit();
    color = getRandomColor();
    doubleValue = Random().nextDouble();
  });

  blocTest<CheckboxThemeCubit, CheckboxThemeState>(
    'should emit theme',
    setUp: () {
      final colorScheme = randomColorSchemeLight(shouldPrint: false);
      theme = ThemeData.from(colorScheme: colorScheme).checkboxTheme;
    },
    build: () => cubit,
    act: (cubit) => cubit.themeChanged(theme),
    expect: () => [CheckboxThemeState(theme: theme)],
  );

  group('test fill colors', () {
    blocTest<CheckboxThemeCubit, CheckboxThemeState>(
      'should emit default color',
      build: () => cubit,
      act: (cubit) => cubit.fillDefaultColorChanged(color),
      verify: (cubit) {
        final props = {
          null: color,
          MaterialState.selected: fillSelectedColor,
          MaterialState.disabled: fillDisabledColor,
        };

        verifyMaterialPropertyByMap(cubit.state.theme.fillColor!, props);
      },
    );

    blocTest<CheckboxThemeCubit, CheckboxThemeState>(
      'should emit selected color',
      build: () => cubit,
      act: (cubit) => cubit.fillSelectedColorChanged(color),
      verify: (cubit) {
        final props = {
          null: fillDefaultColor,
          MaterialState.selected: color,
          MaterialState.disabled: fillDisabledColor,
        };

        verifyMaterialPropertyByMap(cubit.state.theme.fillColor!, props);
      },
    );
    blocTest<CheckboxThemeCubit, CheckboxThemeState>(
      'should emit disabled color',
      build: () => cubit,
      act: (cubit) => cubit.fillDisabledColorChanged(color),
      verify: (cubit) {
        final props = {
          null: fillDefaultColor,
          MaterialState.selected: fillSelectedColor,
          MaterialState.disabled: color,
        };

        verifyMaterialPropertyByMap(cubit.state.theme.fillColor!, props);
      },
    );
  });

  blocTest<CheckboxThemeCubit, CheckboxThemeState>(
    'should emit check color',
    build: () => cubit,
    act: (cubit) => cubit.checkColorChanged(color),
    verify: (cubit) {
      final props = {null: color};

      verifyMaterialPropertyByMap(cubit.state.theme.checkColor!, props);
    },
  );

  group('test overlay colors', () {
    blocTest<CheckboxThemeCubit, CheckboxThemeState>(
      'should emit pressed color',
      build: () => cubit,
      act: (cubit) => cubit.overlayPressedColorChanged(color),
      verify: (cubit) {
        final props = {
          MaterialState.pressed: color,
          MaterialState.hovered: overlayHoveredColor,
          MaterialState.focused: overlayFocusedColor
        };

        verifyMaterialPropertyByMap(cubit.state.theme.overlayColor!, props);
      },
    );

    blocTest<CheckboxThemeCubit, CheckboxThemeState>(
      'should emit hovered color',
      build: () => cubit,
      act: (cubit) => cubit.overlayHoveredColorChanged(color),
      verify: (cubit) {
        final props = {
          MaterialState.pressed: overlayPressedColor,
          MaterialState.hovered: color,
          MaterialState.focused: overlayFocusedColor
        };

        verifyMaterialPropertyByMap(cubit.state.theme.overlayColor!, props);
      },
    );

    blocTest<CheckboxThemeCubit, CheckboxThemeState>(
      'should emit focused color',
      build: () => cubit,
      act: (cubit) => cubit.overlayFocusedColorChanged(color),
      verify: (cubit) {
        final props = {
          MaterialState.pressed: overlayPressedColor,
          MaterialState.hovered: overlayHoveredColor,
          MaterialState.focused: color,
        };

        verifyMaterialPropertyByMap(cubit.state.theme.overlayColor!, props);
      },
    );
  });

  group('test material tap target size', () {
    for (var size in MaterialTapTargetSize.values) {
      blocTest<CheckboxThemeCubit, CheckboxThemeState>(
        'should emit $size',
        build: () => cubit,
        act: (cubit) {
          cubit.materialTapTargetSize(UtilService.enumToString(size));
        },
        expect: () => [
          CheckboxThemeState(
            theme: CheckboxThemeData(materialTapTargetSize: size),
          ),
        ],
      );
    }
  });

  blocTest<CheckboxThemeCubit, CheckboxThemeState>(
    'should emit splash radius',
    build: () => cubit,
    act: (cubit) => cubit.splashRadiusChanged(doubleValue.toString()),
    expect: () => [
      CheckboxThemeState(theme: CheckboxThemeData(splashRadius: doubleValue)),
    ],
  );
}