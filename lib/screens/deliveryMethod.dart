import 'package:coffee/screens/payment.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Deliverymethod extends StatefulWidget {
  final String username;
  const Deliverymethod({super.key,required this.username});

  @override
  _DeliverymethodState createState() => _DeliverymethodState();
}

class _DeliverymethodState extends State<Deliverymethod> {
  bool showPickup = true; // Controls the current view
  DateTime selectedDate = DateTime.now(); // Start with the current date
  TimeOfDay selectedTime = TimeOfDay.now(); // Start with the current time
  String address = ""; // Variable to hold the address

  void toggleView() {
    setState(() {
      showPickup = !showPickup; // Toggle between pickup and delivery views
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked; // Update the selected time
      });
      print("Selected Time: ${selectedTime.format(context)}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 115,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 27, 38, 59),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Opacity(
                      opacity: 0.04,
                      child: Image.asset(
                        "assets/images/Coffee beans set.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(19.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.navigate_before),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 85),
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: showPickup ? null : toggleView,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: showPickup ? const Color.fromARGB(255, 47, 66, 83) : Colors.white,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Pickup",
                                  style: TextStyle(
                                    color: showPickup ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: showPickup ? toggleView : null,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: !showPickup ? const Color.fromARGB(255, 47, 66, 83) : Colors.white,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Address",
                                  style: TextStyle(
                                    color: !showPickup ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  showPickup
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 140, horizontal: 22),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              const Text("Choose date"),
                              SizedBox(
                                width: 300, // Set your desired width
                                height: 340, // Set your desired height
                                child: TableCalendar(
                                  focusedDay: DateTime.now(),
                                  firstDay: DateTime.now(),
                                  lastDay: DateTime.now().add(Duration(days: 365)),
                                  selectedDayPredicate: (day) {
                                    return isSameDay(selectedDate, day);
                                  },
                                  onDaySelected: (selectedDay, focusedDay) {
                                    setState(() {
                                      selectedDate = selectedDay; // Update the selected date
                                    });
                                    print("Selected Date: ${DateFormat.yMMMd().format(selectedDay)}");
                                  },
                                  calendarStyle: CalendarStyle(
                                    selectedDecoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    todayDecoration: BoxDecoration(
                                      color: Colors.orange.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    defaultDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    weekendDecoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  headerStyle: HeaderStyle(
                                    formatButtonVisible: false,
                                    titleCentered: true,
                                  ),
                                  availableGestures: AvailableGestures.all,
                                  daysOfWeekVisible: true,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Selected Date: ${DateFormat.yMMMd().format(selectedDate)}",
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                "Selected Time: ${selectedTime.format(context)}",
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () => _selectTime(context),
                                child: const Text('Select Time'),
                              ),
                              const SizedBox(height: 30),
                              const Text("Your order will be ready in 5-7 minutes"),
                              const SizedBox(height: 25),
                              ElevatedButton(
                                child:  Text('Next', style: TextStyle(color: Colors.white)),
                                onPressed: () {print("${widget.username} passed");
                                  
                                  // Convert selectedTime to a String format
                                  String formattedTime = selectedTime.format(context);
                                  // Convert selectedDate to a String format
                                  String formattedDate = DateFormat.yMMMd().format(selectedDate); // Format the date to string  
                               
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Payment(address: address,
                                   selectedTime: formattedTime,
                                   selectedDate: formattedDate,
                                   username: widget.username,)));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 55, 66, 75),
                                  padding: const EdgeInsets.symmetric(horizontal: 125, vertical: 15),
                                  textStyle: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 200, horizontal: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Enter your delivery address:",
                                style: TextStyle(fontSize: 24),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                onChanged: (value) {
                                  setState(() {
                                    address = value; // Update the address variable
                                  });
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter your address',
                                ),
                              ),
                              const SizedBox(height: 20),
                              Image.asset(
                                'assets/images/address.jpg', // Replace with your image path
                                height: 200, // Set your desired height
                                width: double.infinity, // Make it responsive
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  // Save address logic here
                                  print("Saved Address: $address"); // This prints the current address
                                  // You can add more logic to save the address if needed
                                },
                                child: const Text('Save', style: TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 55, 66, 75),
                                  padding: const EdgeInsets.symmetric(horizontal: 125, vertical: 15),
                                  textStyle: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
