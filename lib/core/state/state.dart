import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

final playerProvider = StateProvider((ref) => AudioPlayer());
