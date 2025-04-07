import 'package:credentials_generator/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

// TODO: Extract card with arrow buttons to a separate wrapper widget in shared
final cards = [
  NamesAnonymizerPage(),
  PasswordsGeneratorPage(),
  EmailsExtractorPage(),
];

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Credentials Generator')),
      body: Center(
        child: CardSwiper(
          cardsCount: cards.length,
          cardBuilder:
              (context, index, percentThresholdX, percentThresholdY) =>
                  cards[index],
        ),
      ),
    );
  }
}
