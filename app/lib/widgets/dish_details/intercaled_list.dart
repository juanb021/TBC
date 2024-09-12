import 'package:flutter/material.dart';

class IntercaledList extends StatelessWidget {
  const IntercaledList({
    super.key,
    required this.texts,
    required this.images,
  });

  final List<String> texts;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    int maxLength = texts.length > images.length ? texts.length : images.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(maxLength, (index) {
        List<Widget> items = [];

        if (index < texts.length) {
          items.add(
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 58, 171, 72),
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '-  ${texts[index]}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }
        items.add(const SizedBox(
          height: 16,
        ));

        if (index < images.length) {
          items.add(
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(8.0),
              child: Card(
                clipBehavior: Clip.hardEdge,
                child: Image.asset(
                  images[index],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items,
        );
      }),
    );
  }
}
