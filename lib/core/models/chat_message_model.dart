import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ChatMessageModel {
  String chatId;
  FieldValue createdAt;
  bool isDeleted;
  bool isMediaFailed;
  bool isMediaQueued;
  String objectId;
  int photoHeight;
  int photoWidth;
  String text;
  String type;
  FieldValue updatedAt;
  String userFullname;
  String userId;
  String userInitials;
  int userPictureAt;
  bool isDelivered;

  ChatMessageModel(
      {this.chatId,
      this.createdAt,
      this.isDeleted,
      this.isMediaFailed,
      this.isMediaQueued,
      this.objectId,
      this.photoHeight,
      this.photoWidth,
      this.text,
      this.type,
      this.updatedAt,
      this.userFullname,
      this.userId,
      this.userInitials,
      this.userPictureAt,
      this.isDelivered});

  ChatMessageModel.fromJson(Map<String, dynamic> json) {
    chatId = json['chatId'];
    createdAt = json['createdAt'];
    isDeleted = json['isDeleted'];
    isMediaFailed = json['isMediaFailed'];
    isMediaQueued = json['isMediaQueued'];
    objectId = json['objectId'];
    photoHeight = json['photoHeight'];
    photoWidth = json['photoWidth'];
    text = json['text'];
    type = json['type'];
    updatedAt = json['updatedAt'];
    userFullname = json['userFullname'];
    userId = json['userId'];
    userInitials = json['userInitials'];
    userPictureAt = json['userPictureAt'];
    isDelivered = json['isDelivered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chatId'] = this.chatId;
    data['createdAt'] = this.createdAt;
    data['isDeleted'] = this.isDeleted;
    data['isMediaFailed'] = this.isMediaFailed;
    data['isMediaQueued'] = this.isMediaQueued;
    data['objectId'] = this.objectId;
    data['photoHeight'] = this.photoHeight;
    data['photoWidth'] = this.photoWidth;
    data['text'] = this.text;
    data['type'] = this.type;
    data['updatedAt'] = this.updatedAt;
    data['userFullname'] = this.userFullname;
    data['userId'] = this.userId;
    data['userInitials'] = this.userInitials;
    data['userPictureAt'] = this.userPictureAt;
    data['isDelivered'] = this.isDelivered;

    return data;
  }

  ChatMessageModel.fromText(
      {@required String chatId,
      @required String objectId,
      @required String text,
      @required String userId,
      @required String userFullname}) {
    this.chatId = chatId;
    createdAt = FieldValue.serverTimestamp();
    isDeleted = false;
    isMediaFailed = false;
    isMediaQueued = false;
    this.objectId = objectId;
    photoHeight = 0;
    photoWidth = 0;
    this.text = text;
    type = 'text';
    updatedAt = FieldValue.serverTimestamp();
    this.userFullname = userFullname;
    this.userId = userId;
    userInitials = userFullname?.split("")?.first ?? '';
    userPictureAt = 0;
    this.isDelivered = true;
  }

  ChatMessageModel.fromImage(
      {@required String chatId,
      @required String objectId,
      @required String userId,
      @required String userFullname,
      @required String imageUrl}) {
    this.chatId = chatId;
    createdAt = FieldValue.serverTimestamp();
    isDeleted = false;
    isMediaFailed = false;
    isMediaQueued = false;
    this.objectId = objectId;
    text = imageUrl;
    type = 'image';
    updatedAt = FieldValue.serverTimestamp();
    this.userFullname = userFullname;
    this.userId = userId;
    userInitials = userFullname?.split("")?.first ?? '';
    userPictureAt = 0;
  }
}
