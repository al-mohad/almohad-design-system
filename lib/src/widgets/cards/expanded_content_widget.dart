import 'package:flutter/material.dart';

class ExpandedContentWidget extends StatelessWidget {
  const ExpandedContentWidget({super.key});

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Mount Everest',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        buildAddressRating(),
        SizedBox(height: 12),
        buildReview(),
      ],
    ),
  );

  Widget buildAddressRating() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'No 23 Abidjan Street Kaduna State',
        style: TextStyle(color: Colors.black45),
      ),
      // StarsWidget(),
    ],
  );

  Widget buildReview() => Row(
    children:
        [
              'https://i.pravatar.cc/',
              'https://i.pravatar.cc/',
              'https://i.pravatar.cc/',
            ]
            .map(
              (review) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.black12,
                  backgroundImage: NetworkImage(review),
                ),
              ),
            )
            .toList(),
  );
}
