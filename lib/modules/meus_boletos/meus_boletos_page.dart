import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/boleto_info/boleto_info_widget.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_widget.dart';

class MeusBoletosPage extends StatefulWidget {
  const MeusBoletosPage({Key? key}) : super(key: key);

  @override
  _MeusBoletosPageState createState() => _MeusBoletosPageState();
}

class _MeusBoletosPageState extends State<MeusBoletosPage> {
  final controller = BoletoListController();
  String dropdownValue = 'Todos';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                color: AppColors.primary,
                height: 40,
                width: double.maxFinite,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ValueListenableBuilder<List<BoletoModel>>(
                  valueListenable: controller.boletosNotifier,
                  builder: (_, boletos, __) => AnimatedCard(
                      direction: AnimatedCardDirection.top,
                      child: BoletoInfoWidget(
                        size: boletos.length,
                      )),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Meus boletos",
                  style: TextStyles.titleBoldHeading,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.stroke)
                  ),
                  width: 150,
                  height: 55,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward, color: Colors.orange,),
                      iconSize: 24,
                      isExpanded: true,
                      elevation: 16,
                      style: TextStyles.buttonBoldHeading,
                      underline: Container(
                        height: 2,
                        color: Colors.transparent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>[
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
                      ].map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                )
                // ,Container(
                //   child: ValueListenableBuilder<List<BoletoModel>>(
                //   valueListenable: controller.boletosNotifier,
                //   builder: (_, boletos, __) => AnimatedCard(
                //       direction: AnimatedCardDirection.top,
                //       child: Text(
                //         "${boletos.length} ao total",
                //         style: TextStyles.titleBoldHeading,
                //       )),
                // ),
                // ),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Divider(
              thickness: 1,
              height: 1,
              color: AppColors.stroke,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BoletoListWidget(
              controller: controller,
              monthFilter: dropdownValue,
            ),
          )
        ],
      ),
    );
  }
}
