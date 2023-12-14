import 'package:flutter/material.dart';
import '../../../../models/show_models/full_show_model.dart';
import 'more_info.dart';
import '../../../../widgets/section_title.dart';

class ShowPageBoxOffice extends StatelessWidget {
  final FullShow show;
  const ShowPageBoxOffice({Key? key, required this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return show.budget.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                const SectionTitle(title: "Box Ofiice"),
                show.budget != ""
                    ? info(infoName: "Budget", infoValue: show.budget)
                    : nothing(),
                show.openingWeekendUSA != ""
                    ? info(
                        infoName: "Opening Weekend USA",
                        infoValue: show.openingWeekendUSA)
                    : nothing(),
                show.grossUSA != ""
                    ? info(infoName: "Gross USA", infoValue: show.grossUSA)
                    : nothing(),
                show.cumulativeWorldwideGross != ""
                    ? info(
                        infoName: "Cumulative Worldwide Gross",
                        infoValue: show.cumulativeWorldwideGross)
                    : nothing(),
              ],
            ),
          )
        : nothing();
  }
}
