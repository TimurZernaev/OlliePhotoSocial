import 'package:ollie_photo_social/model/yes_no.dart';
import 'package:ollie_photo_social/mock_data/user_data.dart';

final List<YesNo> yesNoList = [
  YesNo(
      imageUrls: ['yes1.jpeg', 'yes4.jpeg', 'yes5.jpeg'],
      user: userList[0],
      title: 'Give me your pulling',
      time: '5m',
      isGroup: true),
  YesNo(
      imageUrls: ['yes2.jpeg', 'yes3.jpeg', 'yes5.jpeg'],
      user: userList[0],
      title: 'Does it match with your style guys?',
      time: '5m',
      isGroup: false),
  YesNo(
      imageUrls: ['yes1.jpeg', 'yes2.jpeg', 'yes4.jpeg'],
      user: userList[0],
      title: 'Does it match with your style guys?',
      time: '5m',
      isGroup: false),
  YesNo(
      imageUrls: ['yes2.jpeg', 'yes3.jpeg', 'yes4.jpeg'],
      user: userList[0],
      title: 'Give me your pulling',
      time: '5m',
      isGroup: true),
  YesNo(
      imageUrls: ['yes1.jpeg', 'yes5.jpeg', 'yes2.jpeg'],
      user: userList[0],
      title: 'Give me your pulling',
      time: '5m',
      isGroup: true),
];
