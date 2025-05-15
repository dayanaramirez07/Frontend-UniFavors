import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final Widget? content;
  final List<Widget>? actions;

  const CustomCard({
    super.key,
    this.title,
    this.subtitle,
    this.content,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white70,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) title!,
            if (subtitle != null) ...[const SizedBox(height: 4), subtitle!],
            if (content != null) ...[const SizedBox(height: 12), content!],
            if (actions != null && actions!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: actions!),
            ],
          ],
        ),
      ),
    );
  }
}
