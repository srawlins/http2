// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:unittest/unittest.dart';

import 'package:http2/src/hpack/hpack.dart';
import 'package:http2/src/frames/frames.dart';
import 'package:http2/src/settings/settings.dart';

import '../hpack/hpack_test.dart' show isHeader;

main() {
  group('frames', () {
    group('frame-writer', () {
      test('connection-error', () {
        var settings = new Settings();
        var context = new HPackContext();
        var controller = new StreamController<List<int>>();
        var reader = new FrameReader(controller.stream, settings);
        var writer = new FrameWriter(context.encoder, controller);
        writer.initialize(settings);

        writer.doneFuture.then(expectAsync((_) {
          // We expect that the writer is done at this point.
        }));

        // We cancel here the reading part (simulates a dying socket).
        controller.stream.listen((_) {}).cancel();
      });
    });
  });
}