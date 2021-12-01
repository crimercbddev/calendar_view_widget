import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventsView extends StatelessWidget {
  const EventsView(
      {Key? key,
      required this.events,
      required this.month,
      required this.currentDay,
      required this.onEventTapped,
      required this.titleField,
      required this.detailField,
      required this.dateField,
      required this.theme})
      : super(key: key);

  final Map<int, List> events;
  final int month;
  final int currentDay;
  final Function onEventTapped;
  final String titleField;
  final String detailField;
  final String dateField;
  final ThemeData theme;

  Widget dateBadge(day) => Container(
        height: 44,
        width: 44,
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.accentColor,
        ),
        child: Center(
          child: Text(
            day.toString(),
            textAlign: TextAlign.center,
            style: theme.accentTextTheme.subtitle1,
          ),
        ),
      );

  String timeString(event) {
    final date = DateTime.parse(event[dateField]).toLocal();
    return DateFormat.jm().format(date);
  }

  Widget eventRow(int day, Map<String, String> event) => InkWell(
        onTap: () => onEventTapped(event),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      event[titleField] ?? "",
                      style: theme.textTheme.headline6,
                    ),
                    if (event[detailField] != null &&
                        event[detailField]!.isNotEmpty) ...[
                      SizedBox(height: 6),
                      Text(
                        event[detailField] ?? "",
                        style: theme.textTheme.subtitle2,
                      ),
                    ],
                    if (timeString(event) != null &&
                        timeString(event).isNotEmpty) ...[
                      SizedBox(height: 6),
                      Text(
                        timeString(event),
                        style: theme.textTheme.subtitle2,
                      ),
                    ],
                  ],
                ),
              ),
              dateBadge(day),
            ],
          ),
        ),
      );

  List<Widget> eventList() {
    List<Widget> list = [];
    events.forEach((int day, List dayEvents) {
      if (currentDay == 0 || currentDay == day) {
        for (var i = 0; i < dayEvents.length; i++) {
          list.add(eventRow(day, dayEvents[i]));
          list.add(Divider(
            color: theme.dividerColor,
            height: 24.0,
          ));
        }
      }
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: theme.canvasColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: eventList(),
        ),
      ),
    );
  }
}
