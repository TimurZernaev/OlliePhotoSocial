import 'package:ollie_photo_social/model/this_that.dart';
import 'package:ollie_photo_social/mock_data/user_data.dart';

final List<ThisThat> thisThatList = [
  ThisThat(
    this_images: [
      'this1.png',
      'that3.png',
    ],
    that_images: [
      'this2.png',
      'that3.png',
    ],
    user: userList[0],
    title: 'Which one will you choose?',
    end_time: '5m',
    is_group: true,
  ),
  ThisThat(
    this_images: [
      'this3.png',
      'this1.png',
      'this2.png',
    ],
    that_images: [
      'that2.png',
      'that1.png',
      'that3.png',
    ],
    user: userList[4],
    title: 'I\'m confuse to choose watch or notebook?',
    end_time: '5m',
    is_group: true,
  ),
  ThisThat(
    this_images: [
      'this2.png',
      'this1.png',
      'this3.png',
    ],
    that_images: [
      'that3.png',
      'that2.png',
      'that1.png',
    ],
    user: userList[3],
    title: 'Help me to decide',
    end_time: '5m',
    is_group: true,
  ),
  ThisThat(
    this_images: [
      'this1.png',
      'this2.png',
      'this3.png',
    ],
    that_images: [
      'that1.png',
      'that2.png',
      'that3.png',
    ],
    user: userList[2],
    title: 'Do you like these',
    end_time: '5m',
    is_group: true,
  ),
  ThisThat(
    this_images: [
      'this1.png',
      'that1.png',
    ],
    that_images: [
      'this2.png',
      'that2.png',
    ],
    user: userList[5],
    title: 'Do you like these',
    end_time: '5m',
    is_group: true,
  ),
];
