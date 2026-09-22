import 'package:flutter/material.dart';

void main() {
  runApp(const EarningApp());
}

class EarningApp extends StatelessWidget {
  const EarningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Earning App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _userPoints = 250;

  void _addPoints(int points, String taskName) {
    setState(() {
      _userPoints += points;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$taskName সম্পন্ন হয়েছে! +$points পয়েন্ট পেয়েছেন।'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('আর্নিং অ্যাপ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: Colors.deepPurple,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('স্বাগতম,', style: TextStyle(color: Colors.white70, fontSize: 16)),
                        SizedBox(height: 4),
                        Text('ইউজার নাম', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.monetization_on, color: Colors.black87),
                          const SizedBox(width: 6),
                          Text(
                            '$_userPoints পয়েন্ট',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            GestureDetector(
              onTap: () => _addPoints(50, 'ডেইলি বোনাস'),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Colors.orange, Colors.deepOrange]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.card_giftcard, color: Colors.white, size: 30),
                        SizedBox(width: 12),
                        Text('ডেইলি বোনাস ক্লেইম করুন', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Text('+৫০ পয়েন্ট', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text('পয়েন্ট অর্জনের কাজসমূহ:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            _buildTaskCard(
              icon: Icons.play_circle_fill,
              color: Colors.red,
              title: 'ভিডিও অ্যাড দেখুন',
              subtitle: 'একটি ভিডিও দেখলে ২০ পয়েন্ট',
              reward: '+২০',
              onTap: () => _addPoints(20, 'ভিডিও দেখা'),
            ),
            _buildTaskCard(
              icon: Icons.casino,
              color: Colors.blue,
              title: 'স্পিন ঘুরান (Spin Wheel)',
              subtitle: 'ভাগ্যের চাকা ঘুরিয়ে জিতুন ১০-৫০ পয়েন্ট',
              reward: '+১০',
              onTap: () => _addPoints(10, 'স্পিন কাজ'),
            ),
            _buildTaskCard(
              icon: Icons.quiz,
              color: Colors.green,
              title: 'কুইজ খেলুন',
              subtitle: 'সহজ প্রশ্নের উত্তর দিন',
              reward: '+১৫',
              onTap: () => _addPoints(15, 'কুইজ উত্তর'),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  _showWithdrawDialog(context);
                },
                icon: const Icon(Icons.account_balance_wallet, color: Colors.white),
                label: const Text('টাকা উইথড্র করুন (Withdraw)', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required String reward,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(12)),
          child: Text(reward, style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold)),
        ),
        onTap: onTap,
      ),
    );
  }

  void _showWithdrawDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('উইথড্র অপশন'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('আপনার বর্তমান পয়েন্ট: $_userPoints'),
            const SizedBox(height: 10),
            const Text('পেমেন্ট মেথড সিলেক্ট করুন:'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Chip(label: const Text('বিকাশ'), backgroundColor: Colors.pink.shade100),
                Chip(label: const Text('নগদ'), backgroundColor: Colors.orange.shade100),
                Chip(label: const Text('রিচার্জ'), backgroundColor: Colors.blue.shade100),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('বন্ধ করুন'),
          ),
        ],
      ),
    );
  }
}

