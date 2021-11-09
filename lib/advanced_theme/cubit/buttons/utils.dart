import 'package:flutter/material.dart';

MaterialStateProperty<Color?> getButtonBasicColor(
  MaterialStateProperty<Color?> color, {
  Color? enabledColor,
  Color? disabledColor,
}) {
  return MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.disabled)) {
      return disabledColor ?? color.resolve({MaterialState.disabled});
    }
    return enabledColor ?? color.resolve({});
  });
}

MaterialStateProperty<Color?> getButtonOverlayColor(
  MaterialStateProperty<Color?> overlayColor, {
  Color? hoveredColor,
  Color? focusedColor,
  Color? pressedColor,
}) {
  return MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.hovered)) {
      return hoveredColor ?? overlayColor.resolve({MaterialState.hovered});
    }
    if (states.contains(MaterialState.focused)) {
      return focusedColor ?? overlayColor.resolve({MaterialState.focused});
    }
    if (states.contains(MaterialState.pressed)) {
      return pressedColor ?? overlayColor.resolve({MaterialState.pressed});
    }
    return null;
  });
}