import 'package:equatable/equatable.dart';

class UselessFact extends Equatable {
  final String? id;
  final String? text;
  final String? source;
  final String? sourceUrl;
  final String? language;
  final String? permalink;

  const UselessFact({
    this.id,
    this.text,
    this.source,
    this.sourceUrl,
    this.language,
    this.permalink,
  });

  @override
  List<Object?> get props => [id, text];

  UselessFact copyWith({
    String? id,
    String? text,
    String? source,
    String? sourceUrl,
    String? language,
    String? permalink,
  }) {
    return UselessFact(
      id: id ?? this.id,
      text: text ?? this.text,
      source: source ?? this.source,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      language: language ?? this.language,
      permalink: permalink ?? this.permalink,
    );
  }
}
