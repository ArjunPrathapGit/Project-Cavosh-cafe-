import 'package:coffee/screens/ReviewOrder.dart';
import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  final String address;
  final String selectedTime;
  final String selectedDate;
  final String username;
  
  const Payment({super.key,required this.address,required this.selectedTime,required this.selectedDate,required this.username});

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String? _selectedPaymentMethod = 'Card'; // Default selected payment method
  String? _selectedCard; // Declare the selected card variable

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 224, 225, 221),
        body: Column(
          children: [
            

            Stack(
              children: [
                Container(
                  height: 115,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 27, 38, 59),
                    borderRadius: BorderRadius.only(
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.navigate_before),
                      ),
                      SizedBox(width: 60),
                      Text(
                        "Payment Method",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), // Space between the image and buttons
            CustomRadioButton(
              onPaymentMethodSelected: (method) {
                setState(() {
                  _selectedPaymentMethod = method; // Update selected payment method
                });
                print('Selected payment method: $method');
              },
            ),
            SizedBox(height: 50), // Space between the first set of buttons and the new set
            // Display CardSelection only if 'Card' is selected
            if (_selectedPaymentMethod == 'Card')
              CardSelection(
                onCardSelected: (cardType) {
                  setState(() {
                    _selectedCard = cardType; // Update selected card type
                  });
                  print('Selected card type: $cardType');
                },
              ),
            // Display CashOnDeliveryWidget only if 'Cash' is selected
            if (_selectedPaymentMethod == 'Cash') CashOnDeliveryWidget(),
            SizedBox(height: 40),
            // Display Add New Card only if 'Card' is selected
            if (_selectedPaymentMethod == 'Card')
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddNewCardScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.add),
                        SizedBox(width: 10),
                        Text("Add New Card", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              ),
            SizedBox(height: 40),
            ElevatedButton(
              child: Text('Next', style: TextStyle(color: Colors.white)),
              onPressed: () {print("${widget.username} passed");
                print("Address passed to ReviewOrder: ${widget.address}");

                // Handle your navigation logic here
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ReviewOrder(
                      address:widget.address ,
                      selectedPayment: _selectedPaymentMethod ?? 'Unknown',
                      selectedCard: _selectedCard ?? 'No Card Selected', // Pass the selected card
                      selectedTime: widget.selectedTime,
                      selectedDate: widget.selectedDate,
                      username: widget.username,
                      
                    ),
                    
                  ),
                  
                );
             

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 55, 66, 75),
                padding: EdgeInsets.symmetric(horizontal: 145, vertical: 15),
                textStyle: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRadioButton extends StatefulWidget {
  final Function(String)? onPaymentMethodSelected;

  CustomRadioButton({Key? key, this.onPaymentMethodSelected}) : super(key: key);

  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  String? _selectedPaymentMethod = 'Card';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildRadioOption('Card', 'assets/images/card.jpg'),
        SizedBox(width: 20),
        _buildRadioOption('Cash', 'assets/images/cashlogo.png'),
        SizedBox(width: 20),
        _buildRadioOption('PayPal', 'assets/images/paypal.png'),
      ],
    );
  }

  Widget _buildRadioOption(String paymentMethod, String imagePath) {
    final isSelected = _selectedPaymentMethod == paymentMethod;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = paymentMethod;
        });
        if (widget.onPaymentMethodSelected != null) {
          widget.onPaymentMethodSelected!(paymentMethod);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 34),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey.shade600 : Colors.grey[300],
          borderRadius: BorderRadius.circular(55),
          border: Border.all(color: Colors.grey, width: isSelected ? 2 : 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                imagePath,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),
            Text(
              paymentMethod,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// New Custom Card Selection Widget
class CardSelection extends StatefulWidget {
  final Function(String)? onCardSelected;

  CardSelection({Key? key, this.onCardSelected}) : super(key: key);

  @override
  _CardSelectionState createState() => _CardSelectionState();
}

class _CardSelectionState extends State<CardSelection> {
  String? _selectedCard;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCardOption('MasterCard', 'assets/images/mastercardlogo.png', '**** **** **** 1234'),
        SizedBox(height: 16),
        _buildCardOption('Visa', 'assets/images/visalogo.png', '**** **** **** 5678'),
      ],
    );
  }

  Widget _buildCardOption(String cardType, String imagePath, String cardNumber) {
    final isSelected = _selectedCard == cardType;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCard = cardType;
        });
        if (widget.onCardSelected != null) {
          widget.onCardSelected!(cardType);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.grey.shade500 : Colors.grey[300],
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey, width: isSelected ? 2 : 1),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  imagePath,
                  width: 50, // Adjust width as needed
                  height: 50, // Adjust height as needed
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16), // Space between the image and text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cardType,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      cardNumber,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Radio<String>(
                value: cardType,
                groupValue: _selectedCard,
                onChanged: (value) {
                  setState(() {
                    _selectedCard = value;
                  });
                  if (widget.onCardSelected != null) {
                    widget.onCardSelected!(value!);
                  }
                },
                activeColor: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dummy Widget for Cash On Delivery
class CashOnDeliveryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(Icons.money),
            SizedBox(width: 10),
            Text("Cash on Delivery", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

// Dummy Add New Card Screen
class AddNewCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Card")),
      body: Center(child: Text("Add New Card Page")),
    );
  }
}
