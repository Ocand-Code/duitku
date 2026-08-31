import 'package:flutter/material.dart';

import '../models/category.dart';

class CategoryChip extends StatelessWidget {
  final TxCategory category;
  final bool selected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.category,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChoiceChip(
      label: Text(category.name),
      avatar: Text(category.emoji),
      selected: selected,
      selectedColor: category.color,
      showCheckmark: false,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      labelStyle: TextStyle(
        color: selected
            ? Colors.white
            : theme.colorScheme.onSurface,
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
      shape: const StadiumBorder(),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(horizontal: -1, vertical: -1),
      onSelected: selected ? null : (_) => onTap(),
    );
  }
}

class CategoryGrid extends StatefulWidget {
  final List<TxCategory> categories;
  final String selectedId;
  final ValueChanged<String> onSelected;

  const CategoryGrid({
    super.key,
    required this.categories,
    required this.selectedId,
    required this.onSelected,
  });

  @override
  State<CategoryGrid> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  late String _sel;

  @override
  void initState() {
    super.initState();
    _sel = widget.selectedId;
  }

  @override
  void didUpdateWidget(CategoryGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    _sel = widget.selectedId;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.categories
          .map((c) => CategoryChip(
                category: c,
                selected: c.id == _sel,
                onTap: () => setState(() => _sel = c.id),
              ))
          .toList(),
    );
  }
}