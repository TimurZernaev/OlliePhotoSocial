import 'package:ollie_photo_social/model/yes_no.dart';
import 'package:ollie_photo_social/mock_data/user_data.dart';

final List<YesNo> yesNoList = [
  YesNo(
    images: ['yes1.jpeg', 'yes4.jpeg', 'yes5.jpeg'],
    user: userList[0],
    title: 'Give me your pulling',
    end_time: '5m',
    is_group: true,
  ),
  YesNo(
    images: ['yes2.jpeg', 'yes3.jpeg', 'yes5.jpeg'],
    user: userList[0],
    title: 'Does it match with your style guys?',
    end_time: '5m',
    is_group: false,
  ),
  YesNo(
    images: ['yes1.jpeg', 'yes2.jpeg', 'yes4.jpeg'],
    user: userList[0],
    title: 'Does it match with your style guys?',
    end_time: '5m',
    is_group: false,
  ),
  YesNo(
    images: ['yes2.jpeg', 'yes3.jpeg', 'yes4.jpeg'],
    user: userList[0],
    title: 'Give me your pulling',
    end_time: '5m',
    is_group: true,
  ),
  YesNo(
    images: ['yes1.jpeg', 'yes5.jpeg', 'yes2.jpeg'],
    user: userList[0],
    title: 'Give me your pulling',
    end_time: '5m',
    is_group: true,
  ),
];
