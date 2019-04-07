import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:login_demo/models/user.dart';
import 'package:login_demo/models/match.dart';

final dummySnapshot = {
  'email': 'ble@ble.is',
  'photoURL': 'www.mbl.is/flottur',
  'username': 'Bongo',
  'highestScore': {
    '0': {
      'against': 'PTT4NOi6Y3XQKkQImkH6zeUnvn43',
      'date': '2018-12-03T11:16:25.730Z',
      'score': 57
    },
    '1': {
      'against': 'PTT4NOi6Y3XQKkQImkH6zeUnvn43',
      'date': '2018-12-03T11:16:25.730Z',
      'score': 78
    },
    '2': {
      'against': 'PTT4NOi6Y3XQKkQImkH6zeUnvn43',
      'date': '2018-12-03T11:16:25.730Z',
      'score': 180
    },
  },
  'scoreHistory': {
    '0': {
      'against': 'PTT4NOi6Y3XQKkQImkH6zeUnvn43',
      'date': '2018-12-03T11:16:25.730Z',
      'elo': 984
    },
    '1': {
      'against': 'PTT4NOi6Y3XQKkQImkH6zeUnvn44',
      'date': '2018-12-06T11:16:25.730Z',
      'elo': 1000
    },
    '2': {
      'against': 'PTT4NOi6Y3XQKkQImkH6zeUnvn44',
      'date': '2018-12-06T11:16:25.730Z',
      'elo': 1000
    },
  },
  'monthlyElo': {
    '2018-11': {
      '0': {
        'against': 'PTT4NOi6Y3XQKkQImkH6zeUnvn43',
        'date': '2018-12-03T11:16:25.730Z',
        'elo': 984
      },
      '1': {
        'against': 'PTT4NOi6Y3XQKkQImkH6zeUnvn44',
        'date': '2018-12-06T11:16:25.730Z',
        'elo': 1000
      },
    },
    '2019-01': {
      '0': {
        'against': 'PTT4NOi6Y3XQKkQImkH6zeUnvn43',
        'date': '2018-12-03T11:16:25.730Z',
        'elo': 984
      },
      '1': {
        'against': 'PTT4NOi6Y3XQKkQImkH6zeUnvn44',
        'date': '2018-12-06T11:16:25.730Z',
        'elo': 1000
      },
    }
  }
};

void main() {
  test('user deserializes from map', () {
    final User result = User.map(dummySnapshot);
    expect(result.monthlyElo.keys.length, 2);
    expect(result.gameHistory.length, 3);
  });
}