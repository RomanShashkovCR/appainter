part of 'abstract_text_style_cubit.dart';

@CopyWith(copyWithNull: true)
class TextStyleState extends Equatable {
  final TextStyle style;

  const TextStyleState({required this.style});

  @override
  List<Object> get props => [style];
}
