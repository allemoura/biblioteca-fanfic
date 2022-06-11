import 'package:flutter/material.dart';

class OptionsBottom extends StatelessWidget {
  final Function() onOpen;
  final Function() onEdit;
  final Function() onRemove;
  final Function() onVerifiction;
  final Function() onClosing;
  final String? verifiction;

  const OptionsBottom({
    Key? key,
    required this.onClosing,
    required this.onOpen,
    required this.onEdit,
    required this.onRemove,
    required this.onVerifiction,
    required this.verifiction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: onClosing,
      builder: (context) {
        return SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.2,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextButton(
                      child: Text(
                        "Abrir Fanfic",
                        style: TextStyle(
                            color: Colors.purpleAccent, fontSize: 20.0),
                      ),
                      onPressed: onOpen,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextButton(
                        child: Text(
                          "Editar",
                          style: TextStyle(
                              color: Colors.purpleAccent, fontSize: 20.0),
                        ),
                        onPressed: onEdit),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextButton(
                        child: Text(
                          "Excluir",
                          style: TextStyle(
                              color: Colors.purpleAccent, fontSize: 20.0),
                        ),
                        onPressed: onRemove),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextButton(
                        child: Text(
                          verifiction!,
                          style: TextStyle(
                              color: Colors.purpleAccent, fontSize: 20.0),
                        ),
                        onPressed: onVerifiction),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
