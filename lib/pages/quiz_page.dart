import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:skywalker/backend/account.dart';
import 'package:skywalker/backend/database.dart';
import 'package:skywalker/misc/show_popup.dart';
import 'package:skywalker/misc/values.dart';
import 'package:skywalker/pages/page_content.dart';
import 'package:skywalker/pages/results_page.dart';
import 'package:skywalker/widgets/other/rounded_rectangle.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int page = 1;
  double budgetSlider = 0;

  void nextPage() {
    if (page + 1 <= 5) {
      setState(() {
        page += 1;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final account = Account.of(context);
    final theme = Theme.of(context);
    return PageContent(
      title: "Quiz",
      childrenPadding: comfortable.copyWith(left: 0, right: 0),
      children: [
        RoundedRectangle(
          cornerRadius: 40,
          color: theme.colorScheme.surfaceContainerHigh,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 1; i <= 5; i++)
                Padding(
                  padding: tight,
                  child: i <= page
                      ? IconButton.filled(
                          onPressed: () {
                            setState(() {
                              page = i;
                            });
                          },
                          icon: Text(
                            i.toString(),
                            style: subheading(context)
                                .copyWith(color: theme.colorScheme.onPrimary),
                          ))
                      : IconButton.outlined(
                          onPressed: () {
                            setState(() {
                              page = i;
                            });
                          },
                          icon: Text(
                            i.toString(),
                            style: subheading(context)
                                .copyWith(color: theme.colorScheme.onSurface),
                          )),
                )
            ],
          ),
        ),
        page < 6
            ? Padding(
                padding: const EdgeInsets.all(60),
                child: () {
                  switch (page) {
                    case 1:
                      return Column(
                        children: [
                          Text(
                            "Where are you from?",
                            style: heading(context),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(border: OutlineInputBorder(), label: Text("Country/region")),
                              value: account.region,
                              items: const [
                                DropdownMenuItem(
                                  value: "",
                                  child: Text(""),
                                ),
                                DropdownMenuItem(
                                  value: "China",
                                  child: Text("China"),
                                ),
                                DropdownMenuItem(
                                  value: "United States",
                                  child: Text("United States"),
                                ),
                                DropdownMenuItem(
                                  value: "United Kingdom",
                                  child: Text("United Kingdom"),
                                ),
                                DropdownMenuItem(
                                  value: "Macao",
                                  child: Text("Macao"),
                                ),
                                DropdownMenuItem(
                                  value: "Hong Kong",
                                  child: Text("Hong Kong"),
                                )
                              ],
                              onChanged: (region) {
                                toDatabaseSync(
                                    account.copyWith(region: region));
                                nextPage();
                              }),
                        ],
                      );
                    case 2:
                      return Column(
                        children: [
                          Text(
                            "Where are you?",
                            style: heading(context),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Country/region")
                            ),
                              value: account.trip.origin,
                              items: const [
                                DropdownMenuItem(value: "", child: Text("")),
                                DropdownMenuItem(
                                  value: "Hong Kong",
                                  child: Text("Hong Kong"),
                                ),
                                DropdownMenuItem(
                                  value: "Guangzhou",
                                  child: Text("Guangzhou"),
                                ),
                                DropdownMenuItem(
                                  value: "Shenzhen",
                                  child: Text("Shenzhen"),
                                ),
                                DropdownMenuItem(
                                  value: "Zhuhai",
                                  child: Text("Zhuhai"),
                                ),
                                DropdownMenuItem(
                                  value: "Jiangmen",
                                  child: Text("Jiangmen"),
                                ),
                                DropdownMenuItem(
                                  value: "Paris",
                                  child: Text("Paris"),
                                )
                              ],
                              onChanged: (region) {
                                nextPage();
                              }),
                        ],
                      );
                    case 3:
                      return Column(
                        children: [
                          Text(
                            "Where do you want to go?",
                            style: heading(context),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text("Destination")
                              ),
                              value: account.trip.destination,
                              items: const [
                                DropdownMenuItem(value: "", child: Text("")),
                                DropdownMenuItem(
                                  value: "Grand Lisboa",
                                  child: Text("Grand Lisboa, Macao"),
                                ),
                                DropdownMenuItem(
                                  value: "London",
                                  child: Text("London"),
                                ),
                                DropdownMenuItem(
                                  value: "Huizhou",
                                  child: Text("Huizhou"),
                                ),
                                DropdownMenuItem(
                                  value: "Guangzhou",
                                  child: Text("Guangzhou"),
                                ),
                                DropdownMenuItem(
                                  value: "Shenzhen",
                                  child: Text("Shenzhen"),
                                ),
                                DropdownMenuItem(
                                  value: "Zhuhai",
                                  child: Text("Zhuhai"),
                                ),
                                DropdownMenuItem(
                                  value: "Jiangmen",
                                  child: Text("Jiangmen"),
                                ),
                              ],
                              onChanged: (region) {
                                nextPage();
                              }),
                        ],
                      );
                    case 4:
                      return Column(
                        children: [
                          Text(
                            "When do you plan to leave?",
                            style: heading(context),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          DateTimeFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              pickerPlatform:
                                  DateTimeFieldPickerPlatform.material,
                              mode: DateTimeFieldPickerMode.date,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.parse("2025-11-09 00:00"),
                              onChanged: (newDate) {
                              }),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            "When do you plan to return?",
                            style: heading(context),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          DateTimeFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              pickerPlatform:
                                  DateTimeFieldPickerPlatform.material,
                              mode: DateTimeFieldPickerMode.date,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.parse("2025-11-09 00:00"),
                              onChanged: (newDate) {
                                nextPage();
                              })
                        ],
                      );
                    case 5:
                      return Column(
                        children: [
                          Text(
                            "How much do you plan to spend?",
                            style: heading(context),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Slider(
                              label: "${2000 + budgetSlider*10000}",
                              value: budgetSlider,
                              onChanged: (value) {
                                setState(() {
                                  budgetSlider = value;
                                });
                              }),
                          const SizedBox(
                            height: 30,
                          ),
                          FloatingActionButton.extended(
                              label: const Text("Take me there"),
                              onPressed: showNewPage(context, const ResultsPage()))
                        ],
                      );
                    default:
                      return const Placeholder();
                  }
                }())
            : nothing,
      ],
    );
  }
}
