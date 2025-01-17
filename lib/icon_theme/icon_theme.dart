import 'package:appainter/abstract_icon_theme/abstract_icon_theme.dart';
import 'package:flutter/material.dart';

class IconThemeCubit extends AbstractIconThemeCubit {}

class IconThemeEditor extends AbstractIconThemeEditor<IconThemeCubit> {
  const IconThemeEditor({Key? key})
      : super(key: key, keyPrefix: 'iconThemeEditor');

  @override
  String get header => 'Icon theme';
}
