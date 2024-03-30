//+ FLUTTER
import 'package:flutter/material.dart';

//+ UTILS
import 'package:ducco_shop/utils/colors/colors.dart';
import 'package:ducco_shop/utils/fonts/fonts.dart';

//+ LIB CORE UI
import 'package:ducco_shop/lib_core_ui/ui_buttons/module.dart';
import 'package:ducco_shop/lib_core_ui/ui_inputs/module.dart';

//+ LIB CORE DOMAIN
import 'package:ducco_shop/lib_core_domain/module.dart';

class UIAccordionFilters extends StatefulWidget {
  final List<CategoryFilter> filters;
  final void Function()? onPressedFunc;

  const UIAccordionFilters({
    super.key,
    required this.onPressedFunc,
    required this.filters,
  });

  @override
  State<UIAccordionFilters> createState() => _UIAccordionFiltersState();
}

class _UIAccordionFiltersState extends State<UIAccordionFilters> {
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
                widget.filters[i].expanded = !expanded;
              });
            },
            children: widget.filters
                .map<ExpansionPanel>((CategoryFilter accordionSection) {
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
                    title: accordionSection.type == 'input_select'
                        ? SizedBox(
                            height: (accordionSection.options.length * 25) +
                                ((accordionSection.options.length) * 15),
                            child: UIAccordionFilterIn(
                              categoryFilter: accordionSection,
                            ),
                          )
                        : UIAccordionFilterBetween(
                            categoryFilter: accordionSection,
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

class UIAccordionFilterIn extends StatelessWidget {
  final CategoryFilter categoryFilter;

  const UIAccordionFilterIn({
    super.key,
    required this.categoryFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0, left: 20),
      child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int i) =>
              UIAccordionSectionOption(
                  accordionSectionOption: categoryFilter.options[i]),
          separatorBuilder: (BuildContext context, int i) => const SizedBox(
                height: 15,
              ),
          itemCount: categoryFilter.options.length),
    );
  }
}

class UIAccordionFilterBetween extends StatelessWidget {
  final CategoryFilter categoryFilter;

  const UIAccordionFilterBetween({
    super.key,
    required this.categoryFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Column(
        children: <Widget>[
          CoreUIInputText(
            labelText: categoryFilter.options[0].label,
            textInputType: TextInputType.number,
            validators: [
              AppInputTextValidators.checkRequired(errorMsg: 'Campo requerido'),
              AppInputTextValidators.checkNumber(
                  errorMsg: 'Verifica que sea un número'),
            ],
          ),
          const SizedBox(height: 12),
          CoreUIInputText(
            labelText: categoryFilter.options[1].label,
            textInputType: TextInputType.number,
            validators: [
              AppInputTextValidators.checkRequired(errorMsg: 'Campo requerido'),
              AppInputTextValidators.checkNumber(
                  errorMsg: 'Verifica que sea un número'),
            ],
          )
        ],
      ),
    );
  }
}

class UIAccordionSectionOption extends StatefulWidget {
  final CategoryFilterOption accordionSectionOption;
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
