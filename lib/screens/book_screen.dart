import 'dart:convert';

import 'package:booking_calendar/booking_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class BookScreen extends StatefulWidget {

  static const routeName = '/book-screen';
  String expertId;
  String userId;
  String userEmail;
  String userName;
  String expertEmail;
  String expertName;

  BookScreen({required this.expertId,required this.expertName,required this.userId,required this.userEmail,required this.userName,required this.expertEmail});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {

  void sendMail(
      {required String to_name,
      required String user_mail,
      required String expert_name,
      required String date_time,
      required String expert_mail}) async {
    // ignore: prefer_const_declarations
    final serviceId = 'service_6r2956m',
        templateId = 'template_od6ug1b',
        userId = '1woXDnhf50wlq8AXJ';
    Future sendActualMail() async {
      final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
      final response = await http.post(url,
          body: json.encode({
            'service_id': serviceId,
            'template_id': templateId,
            'user_id': userId,
            'template_params': {
              'to_name': to_name,
              'user_mail': user_mail,
              'expert_name': expert_name,
              'date_time': date_time,
              'expert_mail': expert_mail
            }
          }),
          headers: {
            'Content-Type': 'application/json',
            'origin': 'http://localhost'
          });
      print(response.statusCode);
      // return response;
    }

    await sendActualMail().then((value) => print("Successful"));
  }


  List<DateTimeRange> getBookedSlots(String expertId) {
    List<DateTimeRange> bookedSlots = [];

    // Connect to firebase and get list of experts and get the list of blocked slots
    var start, end, expert;
    expert =[];
    for (var i in expert) {
      bookedSlots.add(DateTimeRange(
          start: i['start'].subtract(const Duration(hours: 5, minutes: 30)),
          end: i['end'].subtract(const Duration(hours: 5, minutes: 30))));
    }
    return bookedSlots;
  }

  @override
  Widget build(BuildContext context) {
    DateTime start = DateTime(2022, 7, 26, 8), end = DateTime(2022, 7, 27);
    
    BookingService bookingService = BookingService(
        userId: widget.userId,
        userEmail: widget.userEmail,
        userName: widget.userName,
        servicePrice: 99,
        serviceId: Timestamp.now().toString(),
        serviceName: 'Mock Service',
        serviceDuration: 30,
        bookingStart: start,
        bookingEnd: end);

    Stream<dynamic>? getBookingStreamMock(
        {required DateTime end, required DateTime start}) {
      return Stream.value([]);
    }

    List<DateTimeRange> converted = [];
    List<String> selected_slot = [];
    Future<dynamic> uploadBookingMock(
        {required BookingService newBooking}) async {
      await Future.delayed(const Duration(seconds: 1));
      converted.add(DateTimeRange(
          start: newBooking.bookingStart, end: newBooking.bookingEnd));
      selected_slot.add('$newBooking.toJson()');
      print('${newBooking.toJson()} has been uploaded');
      sendMail(to_name: widget.userName, user_mail: widget.userEmail, expert_name: widget.expertName, date_time: "26 August 2022", expert_mail: widget.expertEmail);
    }

    final now = DateTime.now();
    List<DateTimeRange> convertStreamResultMock(
        {required dynamic streamResult}) {
      ///here you can parse the streamresult and convert to [List<DateTimeRange>]
      DateTime first = now;
      DateTime second = now.add(const Duration(minutes: 55));
      DateTime third = now.subtract(const Duration(minutes: 240));
      DateTime fourth = now.subtract(const Duration(minutes: 500));
      converted.add(DateTimeRange(
          start: first, end: now.add(const Duration(minutes: 30))));
      converted.add(DateTimeRange(
          start: second, end: second.add(const Duration(minutes: 23))));
      converted.add(DateTimeRange(
          start: third, end: third.add(const Duration(minutes: 15))));
      converted.add(DateTimeRange(
          start: fourth, end: fourth.add(const Duration(minutes: 50))));
      return converted;
    }

    // var data=await uploadBookingMock();
    return Scaffold(
      body: BookingCalendar(
        bookingService: bookingService,
        getBookingStream: getBookingStreamMock,
        uploadBooking: uploadBookingMock,
        convertStreamResultToDateTimeRanges: convertStreamResultMock,
        
        pauseSlots: getBookedSlots(widget.expertId),
      
        pauseSlotColor: Colors.grey[800],
      ),
    );
  }
}
