import 'package:biblioteca_de_fanfic/screens/home/home_page.dart';
import 'package:flutter/material.dart';

class OrderFilter extends StatelessWidget {
  final Function(OrderOptions) onSelected;

  const OrderFilter({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<OrderOptions>(
      icon: Icon(
        Icons.more_vert,
        size: 30,
        color: Colors.white,
      ),
      itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
        const PopupMenuItem<OrderOptions>(
          child: Text("Ordenar de A-Z"),
          value: OrderOptions.orderaz,
        ),
        const PopupMenuItem<OrderOptions>(
          child: Text("Ordenar de Z-A"),
          value: OrderOptions.orderza,
        ),
        const PopupMenuItem<OrderOptions>(
          child: Text("Ordenar por Concluidas"),
          value: OrderOptions.orderconsim,
        ),
        const PopupMenuItem<OrderOptions>(
          child: Text("Ordenar por Não Concluidas"),
          value: OrderOptions.onderconbai,
        )
      ],
      onSelected: onSelected,
    );
  }
}
