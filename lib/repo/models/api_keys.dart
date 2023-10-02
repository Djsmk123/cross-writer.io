import 'package:hive/hive.dart';

part 'api_keys.g.dart';

@HiveType(typeId: 1)
class BlogApiBox extends HiveObject {
  @HiveField(0)
  final String? hashApiKey;
  @HiveField(1)
  final String? mediumApiKey;
  @HiveField(2)
  final String? devToApiKey;

  @HiveField(3)
  final String? hashUserId;
  BlogApiBox(
      this.hashApiKey, this.mediumApiKey, this.devToApiKey, this.hashUserId);
  BlogApiBox copyWith(
      {String? hashUserId,
      String? hashApiKey,
      String? mediumApiKey,
      String? devToApiKey}) {
    return BlogApiBox(
        hashApiKey ?? this.hashApiKey,
        mediumApiKey ?? this.mediumApiKey,
        devToApiKey ?? this.devToApiKey,
        hashUserId ?? this.hashUserId);
  }

  Map<String, dynamic> toJson() {
    return {
      'medium_api_key': mediumApiKey,
      'dev_to_api_key': devToApiKey,
      'hash_user_id': hashUserId,
      'hash_api_key': hashApiKey,
    };
  }
}
