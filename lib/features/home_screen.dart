import 'package:flutter/material.dart';
import 'package:quran_app/core/utils/constants.dart';
import 'package:quran_app/features/audio_player_controls.dart';
import 'package:quran_app/features/recitations.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final heroTextStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: lg, vertical: md),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Qur'an App",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),

              //
              const SizedBox(height: md),

              //
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(lg),
                    child: Image.asset(
                      'assets/images/1.jpg',
                      height: 150,
                      width: size.width,
                      fit: BoxFit.cover,
                    ),
                  ),

                  //
                  Positioned.fill(
                    child: Align(
                      child: Text(
                        "The Holy Qur'an",
                        style: heroTextStyle,
                      ),
                    ),
                  ),
                ],
              ),

              //
              const SizedBox(height: md),

              //
              const Recitations(),

              const Spacer(),

              //
              const AudioPlayerControls(),
            ],
          ),
        ),
      ),
    );
  }
}
