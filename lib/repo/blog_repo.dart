import 'dart:convert';
import 'dart:developer';

import 'package:blogtools/core/enum.dart';
import 'package:blogtools/core/errors/exceptions.dart';
import 'package:blogtools/core/services/network/network_info.dart';
import 'package:blogtools/repo/models/api_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

import '../core/errors/failures.dart';

class BlogRepo {
  static const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  static Future<(Failure?, BlogApiBox?)> fetchAPIKeys() async {
    try {
      final box = await Hive.openBox<BlogApiBox>('api_keys',
          encryptionCipher: HiveAesCipher(base64Url.decode(encryptionKey)));
      if (box.isNotEmpty) {
        return (null, box.getAt(0));
      }
      return (null, null);
    } catch (e) {
      log(e.toString());
      return (CustomErrorFailure(message: 'failed to open box'), null);
    }
  }

  static Future<Failure?> addAPIKey(BlogApiBox api) async {
    try {
      /*     var encryptionKey = base64Url.decode(
          await secureStorage.read(key: 'encryptionKey') ?? "encryptionKey");*/
      final box = await Hive.openBox<BlogApiBox>('api_keys',
          encryptionCipher: HiveAesCipher(base64Url.decode(encryptionKey)));
      await box.add(api);
    } catch (e) {
      log(e.toString());
      return CustomErrorFailure(message: "failed to add API key");
    }
    return null;
  }

  static Future<Failure?> updateApiKey(BlogApiBox api) async {
    try {
      final box = await Hive.openBox<BlogApiBox>('api_keys',
          encryptionCipher: HiveAesCipher(base64Url.decode(encryptionKey)));
      await box.putAt(0, api);
    } catch (e) {
      log(e.toString());
      return CustomErrorFailure(message: "failed to update api key");
    }
    return null;
  }

  static Future<Failure?> crossPostHelper(
      {required BlogSource source,
      required String articleUrl,
      bool isMedium = true,
      bool isHashNode = true,
      bool isDevTo = true,
      String? hashUserKey,
      String? hashApiKey,
      String? devApiKey,
      String? mediumApiKey}) async {
    switch (source) {
      case BlogSource.devTo:
        {
          return postFromDev(articleUrl, isMedium, isHashNode, hashUserKey,
              hashApiKey, mediumApiKey);
        }
      case BlogSource.medium:
        {
          return postFromMedium(articleUrl, isDevTo, isHashNode, hashUserKey,
              hashApiKey, devApiKey);
        }
      case BlogSource.hashNode:
        {
          return postFromHashNode(
              articleUrl, isDevTo, isMedium, mediumApiKey, devApiKey);
        }
    }
  }

  static Future<Failure?> postFromDev(
      String articleUrl,
      bool toMedium,
      bool toHashNode,
      String? hashUserKey,
      String? hashApiKey,
      String? mediumApiKey) async {
    final res = await NetworkInfoImpl().postRequest(endpoint: '/dev', body: {
      "url": articleUrl,
      "medium": toMedium,
      "hash": toHashNode,
      "hash_userID": hashUserKey,
      "medium_token": mediumApiKey,
      "hash_token": hashApiKey,
    });
    return res.$1;
  }

  static Future<Failure?> postFromMedium(
      String articleUrl,
      bool toDev,
      bool toHashNode,
      String? hashUserKey,
      String? hashApiKey,
      String? devApi) async {
    final res = await NetworkInfoImpl().postRequest(endpoint: '/medium', body: {
      "url": articleUrl,
      "dev": toDev,
      "hash": toHashNode,
      "hash_userID": hashUserKey,
      "dev_api": devApi,
      "hash_token": hashApiKey,
    });
    return res.$1;
  }

  static Future<Failure?> postFromHashNode(String articleUrl, bool toDev,
      bool toMedium, String? mediumApi, String? devApi) async {
    final res = await NetworkInfoImpl().postRequest(endpoint: '/hash', body: {
      "url": articleUrl,
      "dev": toDev,
      'medium': toMedium,
      "medium_api": mediumApi,
      "dev_api": devApi,
    });
    return res.$1;
  }

  static String encryptionKey = "";
  static Future<Failure?> createEncryptionKey() async {
    try {
      var secretKey = await secureStorage.read(key: 'key');
      if (secretKey == null) {
        final key = Hive.generateSecureKey();
        encryptionKey = base64Url.encode(key);
        await secureStorage.write(key: 'key', value: encryptionKey);
        debugPrint(base64Encode(key));
        return null;
      }
      encryptionKey = secretKey;
    } catch (e) {
      return CustomErrorFailure(message: "failed to generate secure key");
    }
    return null;
  }
}
