import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    @required this.imageUrl,
    @required this.title,
    @required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/images/whoweare.jpg',
    title: 'Who we are?',
    description:
        'The Robin Hood Army is a volunteer based, zero-funds organization that works to get surplus food from restaurants and the community to serve less fortunate people.',
  ),
  Slide(
    imageUrl: 'assets/images/ourvision.jpg',
    title: 'Our vision',
    description:
        'Simple really, beat global hunger and bring out the best of humanity using food as a medium.The idea is to create self-sustained chapters across the world who will look after their local community. And in the process, inspire people around us to give back to those who need it most.',
  ),
  Slide(
    imageUrl: 'assets/images/ourculture.png',
    title: 'Our Culture',
    description: 'Citizens First → Mission Next → Robins Last',
  ),
];
