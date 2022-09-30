import 'package:Sprout/components/constant.dart';
import 'package:Sprout/components/day.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class PlantSchedule extends StatefulWidget {
  const PlantSchedule({Key? key}) : super(key: key);

  @override
  State<PlantSchedule> createState() => _PlantScheduleState();
}

class _PlantScheduleState extends State<PlantSchedule> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 70, 16, 0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                Text(
                  "April",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      fontSize: 20),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                decoration: BoxDecoration(
                    color: Color(0xffddffda).withOpacity(.57),
                    borderRadius: BorderRadius.circular(10)),
                child: TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: focusedDay,
                  calendarFormat: CalendarFormat.week,
                  headerVisible: false,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  daysOfWeekHeight: 40,
                  selectedDayPredicate: (day) {
                    return isSameDay(selectedDay, day);
                  },
                  onDaySelected: (DateTime selectDay, DateTime focusDay) {
                    if (!isSameDay(selectedDay, selectDay)) {
                      setState(() {
                        selectedDay = selectDay;
                        focusedDay =
                            focusDay; // update `_focusedDay` here as well
                      });
                    }
                  },
                  daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: kLighttext, weekendStyle: kLighttext),
                  calendarStyle: CalendarStyle(),
                  calendarBuilders: CalendarBuilders(
                    selectedBuilder: (context, day, focusedDay) => Container(
                      width: 40,
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 2, color: Color(0xff17bb0a)),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          day.day.toString(),
                          style: kLighttext,
                        ),
                      ),
                    ),
                    todayBuilder: (context, day, focusedDay) {
                      return Center(
                        child: Text(
                          DateTime.now().day.toString(),
                          style: kLighttext,
                        ),
                      );
                    },
                  ),
                )),
            SizedBox(
              height: 30,
            ),
            Text(
              "Today",
              style: kSmalltext,
            ),
            SizedBox(
              height: 7,
            ),
            Description(
              color: Color(0xff24881b),
              txtcolor: Colors.white,
              txt: "Water Aloe Vera",
              width: 50,
            ),
            SizedBox(
              height: 7,
            ),
            Description(
              color: Color(0xff24881b),
              txtcolor: Colors.white,
              txt: "Fertilize Monstera",
              width: 30,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Tomorrow",
              style: kSmalltext,
            ),
            SizedBox(
              height: 7,
            ),
            Description(
              color: Color(0xfff4f4f4),
              txtcolor: Color(0xff393939),
              txt: "Repot Aloe Vera",
              width: 50,
            ),
            SizedBox(
              height: 10,
            ),
            Description(
              color: Color(0xfff4f4f4),
              txtcolor: Color(0xff393939),
              txt: "Repot Aloe Vera",
              width: 50,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Wednesday",
              style: kSmalltext,
            ),
            SizedBox(
              height: 7,
            ),
            Description(
              color: Color(0xfff4f4f4),
              txtcolor: Color(0xff393939),
              txt: "Repot Aloe Vera",
              width: 50,
            ),
            SizedBox(
              height: 10,
            ),
            Description(
              color: Color(0xfff4f4f4),
              txtcolor: Color(0xff393939),
              txt: "Repot Aloe Vera",
              width: 50,
            ),
          ]),
        ),
      ),
    );
  }
}
