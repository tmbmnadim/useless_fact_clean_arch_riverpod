class UselessFact {
  String? id;
  String? text;
  String? source;
  String? sourceUrl;
  String? language;
  String? permalink;

  UselessFact({
    this.id,
    this.text,
    this.source,
    this.sourceUrl,
    this.language,
    this.permalink,
  });

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
