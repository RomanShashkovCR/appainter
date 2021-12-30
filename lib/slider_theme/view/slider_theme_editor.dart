import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_theme/color_theme/cubit/color_theme_cubit.dart';
import 'package:flutter_theme/common/common.dart';
import 'package:flutter_theme/slider_theme/slider_theme.dart';
import 'package:flutter_theme/widgets/widgets.dart';

class SliderThemeEditor extends ExpansionPanelItem {
  const SliderThemeEditor({Key? key}) : super(key: key);

  @override
  String get header => 'Slider';

  @override
  Widget build(BuildContext context) {
    return SideBySideList(
      padding: kPaddingAll,
      children: [
        _ActiveTrackColorPicker(),
        _InactiveTrackColorPicker(),
        _DisabledActiveTrackColorPicker(),
        _DisabledInactiveTrackColorPicker(),
        _ActiveTickMarkColorPicker(),
        _InactiveTickMarkColorPicker(),
        _DisabledActiveTickMarkColorPicker(),
        _DisabledInactiveTickMarkColorPicker(),
        _ThumbColorPicker(),
        _DisabledThumbColorPicker(),
        _OverlappingShapeStrokeColorPicker(),
        _OverlayColorPicker(),
        _ValueIndicatorColorPicker(),
        _TrackHeightTextField(),
      ],
    );
  }
}

class _TrackHeightTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderThemeCubit, SliderThemeState>(
      buildWhen: (previous, current) {
        return previous.theme.trackHeight != current.theme.trackHeight;
      },
      builder: (context, state) {
        return MyTextFormField(
          key: const Key('sliderThemeEditor_trackHeightTextField'),
          labelText: 'Track Height',
          initialValue:
              (state.theme.trackHeight ?? kSliderTrackHeight).toString(),
          onChanged: (value) {
            context.read<SliderThemeCubit>().trackHeightChanged(value);
          },
        );
      },
    );
  }
}

class _ActiveTrackColorPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final activeTrackColor =
        context.watch<SliderThemeCubit>().state.theme.activeTrackColor;
    final primaryColor = context.watch<ColorThemeCubit>().state.primaryColor;

    return ColorListTile(
      key: const Key('sliderThemeEditor_activeTrackColorPicker'),
      title: 'Active Track Color',
      color: activeTrackColor ?? primaryColor,
      onColorChanged: (color) {
        context.read<SliderThemeCubit>().activeTrackColorChanged(color);
      },
    );
  }
}

class _InactiveTrackColorPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inactiveTrackColor =
        context.watch<SliderThemeCubit>().state.theme.inactiveTrackColor;
    final primaryColor = context.watch<ColorThemeCubit>().state.primaryColor;

    return ColorListTile(
      key: const Key('sliderThemeEditor_inactiveTrackColorPicker'),
      title: 'Inactive Track Color',
      color: inactiveTrackColor ?? primaryColor.withOpacity(0.24),
      onColorChanged: (color) {
        context.read<SliderThemeCubit>().inactiveTrackColorChanged(color);
      },
    );
  }
}

class _DisabledActiveTrackColorPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final disabledActiveTrackColor =
        context.watch<SliderThemeCubit>().state.theme.disabledActiveTrackColor;
    final primaryColorDark =
        context.watch<ColorThemeCubit>().state.primaryColorDark;

    return ColorListTile(
      key: const Key('sliderThemeEditor_disabledActiveTrackColorPicker'),
      title: 'Disabled Active Track Color',
      color: disabledActiveTrackColor ?? primaryColorDark.withOpacity(0.32),
      onColorChanged: (color) {
        context.read<SliderThemeCubit>().disabledActiveTrackColorChanged(color);
      },
    );
  }
}

class _DisabledInactiveTrackColorPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final disabledInactiveTrackColor = context
        .watch<SliderThemeCubit>()
        .state
        .theme
        .disabledInactiveTrackColor;
    final primaryColorDark =
        context.watch<ColorThemeCubit>().state.primaryColorDark;

    return ColorListTile(
      key: const Key('sliderThemeEditor_disabledInactiveTrackColorPicker'),
      title: 'Disabled Inactive Track Color',
      color: disabledInactiveTrackColor ?? primaryColorDark.withOpacity(0.12),
      onColorChanged: (color) {
        context
            .read<SliderThemeCubit>()
            .disabledInactiveTrackColorChanged(color);
      },
    );
  }
}

class _ActiveTickMarkColorPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final activeTickMarkColor =
        context.watch<SliderThemeCubit>().state.theme.activeTickMarkColor;
    final primaryColorLight =
        context.watch<ColorThemeCubit>().state.primaryColorLight;

    return ColorListTile(
      key: const Key('sliderThemeEditor_activeTickMarkColorPicker'),
      title: 'Active Tick Mark Color',
      color: activeTickMarkColor ?? primaryColorLight.withOpacity(0.54),
      onColorChanged: (color) {
        context.read<SliderThemeCubit>().activeTickMarkColorChanged(color);
      },
    );
  }
}

class _InactiveTickMarkColorPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inactiveTickMarkColor =
        context.watch<SliderThemeCubit>().state.theme.inactiveTickMarkColor;
    final primaryColor = context.watch<ColorThemeCubit>().state.primaryColor;

    return ColorListTile(
      key: const Key('sliderThemeEditor_inactiveTickMarkColorPicker'),
      title: 'Inactive Tick Mark Color',
      color: inactiveTickMarkColor ?? primaryColor.withOpacity(0.54),
      onColorChanged: (color) {
        context.read<SliderThemeCubit>().inactiveTickMarkColorChanged(color);
      },
    );
  }
}

class _DisabledActiveTickMarkColorPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final disabledActiveTickMarkColor = context
        .watch<SliderThemeCubit>()
        .state
        .theme
        .disabledActiveTickMarkColor;
    final primaryColorLight =
        context.watch<ColorThemeCubit>().state.primaryColorLight;

    return ColorListTile(
      key: const Key('sliderThemeEditor_disabledActiveTickMarkColorPicker'),
      title: 'Disabled Active Tick Mark Color',
      color: disabledActiveTickMarkColor ?? primaryColorLight.withOpacity(0.12),
      onColorChanged: (color) {
        context
            .read<SliderThemeCubit>()
            .disabledActiveTickMarkColorChanged(color);
      },
    );
  }
}

class _DisabledInactiveTickMarkColorPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final disabledInactiveTickMarkColor = context
        .watch<SliderThemeCubit>()
        .state
        .theme
        .disabledInactiveTickMarkColor;
    final primaryColorDark =
        context.watch<ColorThemeCubit>().state.primaryColorDark;

    return ColorListTile(
      key: const Key('sliderThemeEditor_disabledInactiveTickMarkColorPicker'),
      title: 'Disabled Inactive Tick Mark Color',
      color:
          disabledInactiveTickMarkColor ?? primaryColorDark.withOpacity(0.12),
      onColorChanged: (color) {
        context
            .read<SliderThemeCubit>()
            .disabledInactiveTickMarkColorChanged(color);
      },
    );
  }
}

class _ThumbColorPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final thumbColor = context.watch<SliderThemeCubit>().state.theme.thumbColor;
    final primaryColor = context.watch<ColorThemeCubit>().state.primaryColor;

    return ColorListTile(
      key: const Key('sliderThemeEditor_thumbColorPicker'),
      title: 'Thumb Color',
      color: thumbColor ?? primaryColor,
      onColorChanged: (color) {
        context.read<SliderThemeCubit>().thumbColorChanged(color);
      },
    );
  }
}

class _DisabledThumbColorPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final disabledThumbColor =
        context.watch<SliderThemeCubit>().state.theme.disabledThumbColor;
    final primaryColorDark =
        context.watch<ColorThemeCubit>().state.primaryColorDark;

    return ColorListTile(
      key: const Key('sliderThemeEditor_disabledThumbColorPicker'),
      title: 'Disabled Thumb Color',
      color: disabledThumbColor ?? primaryColorDark.withOpacity(0.32),
      onColorChanged: (color) {
        context.read<SliderThemeCubit>().disabledThumbColorChanged(color);
      },
    );
  }
}

class _OverlappingShapeStrokeColorPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderThemeCubit, SliderThemeState>(
      buildWhen: (previous, current) {
        return previous.theme.overlappingShapeStrokeColor !=
            current.theme.overlappingShapeStrokeColor;
      },
      builder: (context, state) {
        return ColorListTile(
          key: const Key('sliderThemeEditor_overlappingShapeStrokeColorPicker'),
          title: 'Overlapping Shape Stroke Color',
          color: state.theme.overlappingShapeStrokeColor ?? Colors.white,
          onColorChanged: (color) {
            context
                .read<SliderThemeCubit>()
                .overlappingShapeStrokeColorChanged(color);
          },
        );
      },
    );
  }
}

class _OverlayColorPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final overlayColor =
        context.watch<SliderThemeCubit>().state.theme.overlayColor;
    final primaryColor = context.watch<ColorThemeCubit>().state.primaryColor;

    return ColorListTile(
      key: const Key('sliderThemeEditor_overlayColorPicker'),
      title: 'Overlay Color',
      color: overlayColor ?? primaryColor.withOpacity(0.12),
      onColorChanged: (color) {
        context.read<SliderThemeCubit>().overlayColorChanged(color);
      },
    );
  }
}

class _ValueIndicatorColorPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final valueIndicatorColor =
        context.watch<SliderThemeCubit>().state.theme.valueIndicatorColor;
    final primaryColor = context.watch<ColorThemeCubit>().state.primaryColor;

    return ColorListTile(
      key: const Key('sliderThemeEditor_valueIndicatorColorPicker'),
      title: 'Value Indicator Color',
      color: valueIndicatorColor ?? primaryColor,
      onColorChanged: (color) {
        context.read<SliderThemeCubit>().valueIndicatorColorChanged(color);
      },
    );
  }
}