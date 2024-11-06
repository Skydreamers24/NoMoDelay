import 'package:date_field/date_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skywalker/misc/values.dart';
import 'package:skywalker/pages/page_content.dart';
import 'package:skywalker/widgets/other/debug_border.dart';
import 'package:skywalker/widgets/other/debug_guarantee_sized.dart';
import 'package:flutter/services.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class CountryDropdown extends StatefulWidget {
  final QuizData data;
  final void Function(QuizData) setQuizData;

  const CountryDropdown(
      {super.key, required this.setQuizData, required this.data});
  @override
  State<CountryDropdown> createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  // List of countries
  final List<String> _countries = [
    'United States',
    'Canada',
    'Brazil',
    'England',
    'Japan',
    'China',
    'India',
    'Germany',
    'France',
    'Australia',
  ];

  String _selectedCountry = "";

  @override
  void initState() {
    _selectedCountry = widget.data.selectedCountry ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          hint: Text(
              _selectedCountry != "" ? _selectedCountry : "Select a country"),
          items: _countries.map<DropdownMenuItem<String>>((String country) {
            return DropdownMenuItem<String>(
              value: country,
              child: Text(country),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedCountry = newValue!;
              widget.setQuizData(
                  widget.data.copyWith(selectedCountry: _selectedCountry));
            });
          },
        )
      ],
    );
  }
}

class OriginDropdown extends StatefulWidget {
  final QuizData data;
  final void Function(QuizData) setQuizData;

  const OriginDropdown(
      {super.key, required this.setQuizData, required this.data});
  @override
  State<OriginDropdown> createState() => _OriginDropdownState();
}

class _OriginDropdownState extends State<OriginDropdown> {
  // List of countries
  final List<String> _countries = [
    'United States',
    'Canada',
    'Brazil',
    'England',
    'Japan',
    'China',
    'India',
    'Germany',
    'France',
    'Australia',
  ];

  String _selectedCountry = "";

  @override
  void initState() {
    _selectedCountry = widget.data.originCountry ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          hint: Text(
              _selectedCountry != "" ? _selectedCountry : "Select a country"),
          items: _countries.map<DropdownMenuItem<String>>((String country) {
            return DropdownMenuItem<String>(
              value: country,
              child: Text(country),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedCountry = newValue!;
              widget.setQuizData(
                  widget.data.copyWith(originCountry: _selectedCountry));
            });
          },
        )
      ],
    );
  }
}

class DestinationDropdown extends StatefulWidget {
  final QuizData data;
  final void Function(QuizData) setQuizData;

  const DestinationDropdown(
      {super.key, required this.setQuizData, required this.data});
  @override
  State<DestinationDropdown> createState() => _DestinationDropdownState();
}

class _DestinationDropdownState extends State<DestinationDropdown> {
  // List of countries
  final List<String> _countries = [
    'United States',
    'Canada',
    'Brazil',
    'England',
    'Japan',
    'China',
    'India',
    'Germany',
    'France',
    'Australia',
  ];

  String _selectedCountry = "";

  @override
  void initState() {
    _selectedCountry = widget.data.destinationCountry ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          hint: Text(
              _selectedCountry != "" ? _selectedCountry : "Select a country"),
          items: _countries.map<DropdownMenuItem<String>>((String country) {
            return DropdownMenuItem<String>(
              value: country,
              child: Text(country),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedCountry = newValue!;
              widget.setQuizData(
                  widget.data.copyWith(destinationCountry: _selectedCountry));
            });
          },
        )
      ],
    );
  }
}

class TravelDatePicker extends StatelessWidget {
  const TravelDatePicker(
      {super.key,
      required this.data,
      required void Function(QuizData data) setQuizData});
  final QuizData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(flex: 2, child: SizedBox()),
        Flexible(
          flex: 9,
          child: DateTimeFormField(
            initialValue: data.travelDate,
            pickerPlatform: DateTimeFieldPickerPlatform.material,
            mode: DateTimeFieldPickerMode.date,
            firstDate: DateTime.parse("1900-01-01"),
            lastDate: DateTime.parse("2077-06-02"),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Date of Birth",
            ),
            style: Theme.of(context).textTheme.bodyLarge,
            onChanged: (DateTime? value) {
              data.travelDate = value;
            },
          ),
        ),
        const Flexible(flex: 2, child: SizedBox()),
      ],
    );
  }
}

class DesiredSetOffDatePicker extends StatelessWidget {
  const DesiredSetOffDatePicker(
      {super.key,
      required this.data,
      required void Function(QuizData data) setQuizData});
  final QuizData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(flex: 2, child: SizedBox()),
        Flexible(
          flex: 9,
          child: DateTimeFormField(
            initialValue: data.setOffTime,
            pickerPlatform: DateTimeFieldPickerPlatform.material,
            mode: DateTimeFieldPickerMode.date,
            firstDate: DateTime.parse("1900-01-01"),
            lastDate: DateTime.parse("2077-06-02"),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Date of Birth",
            ),
            style: Theme.of(context).textTheme.bodyLarge,
            onChanged: (DateTime? value) {
              data.setOffTime = value;
            },
          ),
        ),
        const Flexible(flex: 2, child: SizedBox()),
      ],
    );
  }
}

class QuizData {
  String? selectedCountry;
  String? originCountry;
  String? destinationCountry;
  DateTime? travelDate;
  DateTime? setOffTime;
  String? numberOfTravellers;

  QuizData(
      {this.selectedCountry,
      this.originCountry,
      this.destinationCountry,
      this.travelDate,
      this.setOffTime,
      this.numberOfTravellers});

  QuizData copyWith(
      {String? selectedCountry,
      String? originCountry,
      String? destinationCountry,
      DateTime? travelDate,
      DateTime? setOffTime,
      String? numberOfTravellers}) {
    return QuizData(
        selectedCountry: selectedCountry ?? this.selectedCountry,
        originCountry: originCountry ?? this.originCountry,
        destinationCountry: destinationCountry ?? this.destinationCountry,
        travelDate: travelDate ?? this.travelDate,
        setOffTime: setOffTime ?? this.setOffTime,
        numberOfTravellers: numberOfTravellers ?? this.numberOfTravellers);
  }
}

class _QuizPageState extends State<QuizPage> {
  int _index = 0;
  late QuizData data;
  @override
  void initState() {
    data = QuizData();
    super.initState();
  }

  void setData(QuizData data) {
    setState(() {
      this.data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: PageContent.withChildWidget(
        title: "Quiz",
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              for (var i = 0; i < 5; i++)
                Padding(
                  padding: tight,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _index = i;
                        });
                      },
                      child: Text((i + 1).toString())),
                )
            ]),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  () {
                    switch (_index) {
                      case 0:
                        return Column(
                          children: [
                            Text("Passport issued by (country)"),
                            CountryDropdown(
                              data: data,
                              setQuizData: setData,
                            )
                          ],
                        );
                      case 1:
                        return Column(
                          children: [
                            Text("Origin Country"),
                            OriginDropdown(data: data, setQuizData: setData),
                            SizedBox(height: 40),
                            Text("Destination Country"),
                            DestinationDropdown(
                                setQuizData: setData, data: data)
                          ],
                        );
                      case 2:
                        return Column(children: [
                          Text("Travel Date"),
                          TravelDatePicker(data: data, setQuizData: setData)
                        ]);
                      case 3:
                        return Column(children: [
                          Text("Desired Set Off Time"),
                          DesiredSetOffDatePicker(
                              data: data, setQuizData: setData)
                        ]);
                      case 4:
                        return Column(children: [
                          Text("Number of travellers"),
                          Padding(
                            padding: const EdgeInsets.only(left: 90, right: 90),
                            child: TextFormField(
                              initialValue: data.numberOfTravellers ??
                                  "Enter number of travellers",
                              decoration: new InputDecoration(
                                  labelText: "Enter number of travellers"),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (String? newValue) {
                                data.numberOfTravellers = newValue;
                              },
                            ),
                          )
                        ]);
                      default:
                        return Placeholder();
                    }
                  }()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
