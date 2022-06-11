import 'package:flutter/material.dart';

class SearcherBar extends StatelessWidget {
  final Function(String) onFilter;

  const SearcherBar({
    Key? key,
    required this.onFilter,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.search,
          size: 30,
          color: Colors.white,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(
                0.1,
              ),
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(
                5,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 10,
              ),
              child: TextField(
                style: TextStyle(
                  color: Colors.white,
                ),
                onChanged: onFilter,
                decoration: InputDecoration(
                  hintText: "Pesquisar",
                  hoverColor: Colors.black,
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
