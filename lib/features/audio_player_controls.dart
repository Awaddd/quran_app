import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/core/state/state.dart';
import 'package:quran_app/core/utils/constants.dart';

enum ButtonState { paused, playing, loading, idle }

class AudioPlayerControls extends ConsumerStatefulWidget {
  const AudioPlayerControls({super.key});

  @override
  ConsumerState<AudioPlayerControls> createState() =>
      _AudioPlayerControlsState();
}

class _AudioPlayerControlsState extends ConsumerState<AudioPlayerControls> {
  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.idle);

  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = ref.read(playerProvider);

    player.playerStateStream.listen((audioPlayerState) {
      final isPlaying = audioPlayerState.playing;
      final ps = audioPlayerState.processingState;

      if (ps == ProcessingState.loading || ps == ProcessingState.buffering) {
        buttonNotifier.value = ButtonState.loading;
      } else if (ps == ProcessingState.idle) {
        buttonNotifier.value = ButtonState.idle;
      } else if (!isPlaying) {
        buttonNotifier.value = ButtonState.paused;
      } else {
        buttonNotifier.value = ButtonState.playing;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> play() async {
      await player.play();
    }

    Future<void> pause() async {
      await player.pause();
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: xs),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(md),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.fast_rewind,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
            ),
          ),

          //
          const SizedBox(width: md),

          //
          ValueListenableBuilder(
            valueListenable: buttonNotifier,
            builder: (context, value, child) {
              if (value == ButtonState.loading) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  width: 14.0,
                  height: 14.0,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                    strokeWidth: 3.0,
                  ),
                );
              }

              if (value == ButtonState.paused) {
                return IconButton(
                  onPressed: play,
                  icon: Icon(
                    Icons.play_arrow,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                );
              }

              if (value == ButtonState.idle) {
                return IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.play_arrow,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.6),
                  ),
                );
              }

              return IconButton(
                onPressed: pause,
                icon: Icon(
                  Icons.pause,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              );
            },
          ),

          //
          const SizedBox(width: md),

          //
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.fast_forward,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
