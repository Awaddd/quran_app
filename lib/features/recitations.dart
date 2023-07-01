import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/core/state/state.dart';
import 'package:quran_app/core/utils/constants.dart';

class Recitations extends ConsumerWidget {
  const Recitations({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recitations = Recitation.recitations;
    final player = ref.read(playerProvider);
    player.setVolume(1);

    return SizedBox(
      height: 125,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: recitations.length,
        separatorBuilder: (context, index) => const SizedBox(width: md),
        itemBuilder: (context, index) {
          final item = recitations[index];
          return InkWell(
            onTap: () async {
              await player.setAsset(item.audio);
              await player.play();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(lg),
              child: Image.asset(
                item.image,
                width: 175,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

class Recitation {
  int id;
  String name;
  String image;
  String audio;

  Recitation({
    required this.id,
    required this.name,
    required this.image,
    required this.audio,
  });

  static List<Recitation> recitations = [
    Recitation(
      id: 1,
      name: 'Musa Abuzaghleh',
      image: 'assets/images/musa-abuzaghleh.jpg',
      audio: 'assets/Musa_Abuzaghleh.mp3',
    ),
    Recitation(
      id: 2,
      name: 'Abdul Basit',
      image: 'assets/images/abdul-basit.jpg',
      audio: 'assets/Abdul_Basit.mp3',
    ),
    Recitation(
      id: 3,
      name: 'Haneef and Salaf',
      image: 'assets/images/haneef-and-salaf.jpg',
      audio: 'assets/Haneef_and_Salaf.mp3',
    ),
    Recitation(
      id: 4,
      name: 'Salaf',
      image: 'assets/images/salaf.jpg',
      audio: 'assets/Salaf.mp3',
    ),
  ];
}
