//+ FLUTTER
import 'package:flutter/material.dart';

//+ UTILS
import 'package:ducco_shop/utils/colors/colors.dart';
import 'package:ducco_shop/utils/fonts/fonts.dart';

//+ LIB CORE UI
import 'package:ducco_shop/lib_core_ui/ui_buttons/module.dart';

class UIAccordion extends StatefulWidget {
  final void Function()? onPressedFunc;

  const UIAccordion({
    super.key,
    required this.onPressedFunc,
  });

  @override
  State<UIAccordion> createState() => _UIAccordionState();
}

class _UIAccordionState extends State<UIAccordion> {
  final List<AccordionSection> itemsExpansionPanel =
      List<AccordionSection>.generate(7, (int i) {
    return AccordionSection(
        title: 'Marca',
        expanded: false,
        options: List.from([
          AccordionSectionOption(id: '1', label: 'Huawei', selected: false),
          AccordionSectionOption(id: '1', label: 'Samsung', selected: true),
          AccordionSectionOption(id: '1', label: 'Alcacel', selected: false),
          AccordionSectionOption(id: '1', label: 'Apple', selected: false),
          AccordionSectionOption(id: '1', label: 'Xiaomi', selected: true),
        ]));
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.only(bottom: 4, left: 16, right: 16, top: 16),
          child: ExpansionPanelList(
            expandIconColor: AppColors.gray80Color,
            dividerColor: AppColors.black70Color,
            expandedHeaderPadding: const EdgeInsets.all(0),
            expansionCallback: (int i, bool expanded) {
              setState(() {
                itemsExpansionPanel[i].expanded = !expanded;
              });
            },
            children: itemsExpansionPanel
                .map<ExpansionPanel>((AccordionSection accordionSection) {
              return ExpansionPanel(
                backgroundColor: AppColors.gray25Color,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(accordionSection.title,
                        style: AppFonts.labelTextHeavy(
                            color: AppColors.gray100Color,
                            fontFamily: 'Ubuntu')),
                  );
                },
                body: ListTile(
                    contentPadding: const EdgeInsets.only(bottom: 0, left: 40),
                    title: SizedBox(
                      height: (accordionSection.options.length * 25) +
                          ((accordionSection.options.length) * 15),
                      child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int i) =>
                              UIAccordionSectionOption(
                                  accordionSectionOption:
                                      accordionSection.options[i]),
                          separatorBuilder: (BuildContext context, int i) =>
                              const SizedBox(
                                height: 15,
                              ),
                          itemCount: accordionSection.options.length),
                    )),
                isExpanded: accordionSection.expanded,
              );
            }).toList(),
          ),
        ),
        UIButton(
            onPressedFunc: this.widget.onPressedFunc,
            enabledColor: AppColors.secondary50Color,
            disabledColor: AppColors.secondary50Color,
            splashColor: AppColors.gray100Color,
            text: 'Aplicar filtros')
      ],
    );
  }
}

class UIAccordionSectionOption extends StatefulWidget {
  final AccordionSectionOption accordionSectionOption;
  const UIAccordionSectionOption(
      {super.key, required this.accordionSectionOption});

  @override
  State<UIAccordionSectionOption> createState() =>
      _UIAccordionSectionOptionState();
}

class _UIAccordionSectionOptionState extends State<UIAccordionSectionOption> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        this.setState(() {
          this.widget.accordionSectionOption.selected =
              !this.widget.accordionSectionOption.selected;
        })
      },
      child: SizedBox(
        height: 25,
        child: Row(
          children: <Widget>[
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: widget.accordionSectionOption.selected
                      ? AppColors.secondary60Color
                      : AppColors.gray50Color,
                  border: Border.all(color: AppColors.gray80Color, width: 1)),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              this.widget.accordionSectionOption.label,
              style: AppFonts.buttonTextHeavy(
                  color: AppColors.gray100Color, fontFamily: 'Ubuntu'),
            ),
          ],
        ),
      ),
    );
  }
}

class AccordionSection {
  final String title;
  final List<AccordionSectionOption> options;
  bool expanded;

  AccordionSection({
    required this.title,
    required this.options,
    required this.expanded,
  });
}

class AccordionSectionOption {
  final String id;
  final String label;
  bool selected;

  AccordionSectionOption(
      {required this.id, required this.label, required this.selected});
}
