import 'package:flutter_test/flutter_test.dart';
import 'package:bokun_dart/models/user.dart';

final Map<String, Object> dummySnapshot = {
  'email': 'ble@ble.is',
  'photoURL': 'www.mbl.is/flottur',
  'username': 'Bongo',
  'highestScore': [
    {
      'against': 'PTT4NOi6Y3XQKkQImkH6zeUnvn43',
      'date': '2018-12-03T11:16:25.730Z',
      'score': 57
    },
    {
      'against': 'PTT4NOi6Y3XQKkQImkH6zeUnvn43',
      'date': '2018-12-03T11:16:25.730Z',
      'score': 78
    },
    {
      'against': 'PTT4NOi6Y3XQKkQImkH6zeUnvn43',
      'date': '2018-12-03T11:16:25.730Z',
      'score': 180
    },
  ],
  'scoreHistory': [
    {
      'against': 'PTT4NOi6Y3XQKkQImkH6zeUnvn43',
      'date': '2018-12-03T11:16:25.730Z',
      'elo': 984
    },
    {
      'against': 'PTT4NOi6Y3XQKkQImkH6zeUnvn44',
      'date': '2018-12-06T11:16:25.730Z',
      'elo': 1000
    },
    {
      'against': 'PTT4NOi6Y3XQKkQImkH6zeUnvn44',
      'date': '2018-12-06T11:16:25.730Z',
      'elo': 1000
    },
  ],
  'monthlyElo': {
    '2018-11': [
      {
        'against': 'PTT4NOi6Y3XQKkQImkH6zeUnvn43',
        'date': '2018-12-03T11:16:25.730Z',
        'elo': 984
      },
      {
        'against': 'PTT4NOi6Y3XQKkQImkH6zeUnvn44',
        'date': '2018-12-06T11:16:25.730Z',
        'elo': 1000
      },
    ],
    '2019-01': [
      {
        'against': 'PTT4NOi6Y3XQKkQImkH6zeUnvn43',
        'date': '2018-12-03T11:16:25.730Z',
        'elo': 984
      },
      {
        'against': 'PTT4NOi6Y3XQKkQImkH6zeUnvn44',
        'date': '2018-12-06T11:16:25.730Z',
        'elo': 1000
      },
    ]
  }
};

void main() {
  test('user deserializes from map', () {
  });
}