import 'dart:io';

import 'package:flutter/cupertino.dart';

class Item {}

class Message implements Item {
  const Message(
    this.type, {
    this.sender,
    this.receiver,
    this.file,
    this.text,
    this.url,
    this.duration,
    this.timestamp,
  });

  final int type; //0 文本  1 图片  2 声音 3 红包

  final File file;

  final String text;

  final String url;

  final num duration;

  final num timestamp;

  final Friend sender;

  final Friend receiver;
}

class Marker implements Item {
  const Marker(this.type, this.text);

  final int type;

  final String text;
}

class Friend {
  const Friend({
    this.name,
    this.avatar,
    this.momentsCover,
  });

  final String name;

  final String avatar;

  ///朋友圈封面
  final String momentsCover;
}

class Comment {
  Comment(this.text, this.poster, {this.replyer, this.timestamp, this.likeCount=0,this.iLike=false});

  final String text;

  //评论者
  final Friend poster;

  //回复评论者
  final Friend replyer;

  final num timestamp;

  num likeCount=0 ;

  bool iLike=false;
}

class TiTokComment{

  final Comment mainComment;

  final List<Comment> subComments;

  TiTokComment(this.mainComment,{ this.subComments});

}

class AudioLink {
  final String cover;

  final String name;

  final String artist;

  final String url;

  AudioLink({this.cover, this.name, this.artist, this.url});
}

class WebPageLink {
  final String cover;

  final String title;

  final String url;

  WebPageLink({this.cover, this.title, this.url});
}

class Moment {
  final Friend friend;

  final String text;

  final int type; //1 纯文本 2：带有图片 3：网页链接 4 ：音频链接

  final AudioLink audioLink;

  final List<String> images;

  final WebPageLink webPageLink;

  final num timestamp;

  final List<Friend> likes;

  final List<Comment> comments;

  Moment({
    this.friend,
    this.text,
    this.type,
    this.audioLink,
    this.timestamp,
    this.images,
    this.webPageLink,
    this.likes,
    this.comments = const [],
  })  : assert(!(type == 4 && audioLink == null),
            "mement type is 4 ，but audio link is null"),
        assert(!(type == 3 && webPageLink == null),
            "mement type is 3 ，but web page link is null"),
        assert(
            !(type == 1 && text == null), "mement type is 1 ，but text is null"),
        assert(!(type == 2 && (images == null || images.length <= 0)),
            "mement type is 2 ，but images is null");
}

abstract class Entrance<T> {
  final int unreadCount;

  final Message recentMessage;

  String icon;

  String name;

  final T extra;

  Entrance({this.extra, this.unreadCount, this.recentMessage});
}

class FriendEntrance extends Entrance<Friend> {
  FriendEntrance({Friend extra, int unreadCount, Message recentMessage})
      : super(
            extra: extra,
            unreadCount: unreadCount,
            recentMessage: recentMessage);

  @override
  String get name => super.extra.name;

  @override
  String get icon => super.extra.avatar;
}

class MinProgram {
  final String name;

  final String icon;

  final void Function(BuildContext context, MinProgram minProgram) onEnter;

  const MinProgram(this.name, this.icon, this.onEnter);
}

class VideoFeed {
  final String url;

  final String userName;

  final String voiceSourceText;

  final String text;

  final String voiceSourceCover;

  VideoFeed({
    this.url,
    this.userName,
    this.voiceSourceText,
    this.text,
    this.voiceSourceCover,
  });
}


