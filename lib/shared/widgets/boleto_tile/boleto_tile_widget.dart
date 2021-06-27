import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class BoletoTileWidget extends StatefulWidget {
  final BoletoModel data;
  final String? monthFilter;
  const BoletoTileWidget({Key? key, required this.data, this.monthFilter})
      : super(key: key);

  @override
  _BoletoTileWidgetState createState() => _BoletoTileWidgetState();
}

class _BoletoTileWidgetState extends State<BoletoTileWidget> {
  var boletoDate = '';
  //
  @override
  // ignore: must_call_super
  void initState() {
    final index = int.parse(widget.data.dueDate!.split('/')[1]);

    final month = <String>[
      'Todos',
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    ];

    try {
      setState(() {
        boletoDate =  month[index];
      });
    } catch (e) {
      setState(() {
        boletoDate = 'Todos';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (boletoDate == widget.monthFilter || widget.monthFilter == 'Todos') {
      return AnimatedCard(
        direction: AnimatedCardDirection.right,
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            widget.data.name!,
            style: TextStyles.titleListTile,
          ),
          subtitle: Text(
            "Vence em ${widget.data.dueDate}",
            style: TextStyles.captionBody,
          ),
          trailing: Text.rich(TextSpan(
            text: "R\$ ",
            style: TextStyles.trailingRegular,
            children: [
              TextSpan(
                text: "${widget.data.value!.toStringAsFixed(2)}",
                style: TextStyles.trailingBold,
              ),
            ],
          )),
        ),
      );
    } else {
      return Container();
    }
  }
}
