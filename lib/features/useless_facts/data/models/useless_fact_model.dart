import '../../domain/entities/useless_fact_entity.dart';

class UselessFactModel extends UselessFact {
  UselessFactModel({
    super.id,
    super.text,
    super.source,
    super.sourceUrl,
    super.language,
    super.permalink,
  });

  UselessFactModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    source = json['source'];
    sourceUrl = json['source_url'];
    language = json['language'];
    permalink = json['permalink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['source'] = source;
    data['source_url'] = sourceUrl;
    data['language'] = language;
    data['permalink'] = permalink;
    return data;
  }
}
