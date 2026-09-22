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
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF5F6F9),
      ),
      home: const LoginScreen(),
    );
  }
}

// ---------------- LOGIN SCREEN ----------------
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.monetization_on, size: 80, color: Colors.green),
              const SizedBox(height: 16),
              const Text(
                'Earning App',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const SizedBox(height: 32),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'মোবাইল নম্বর',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'পিন নম্বর',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainDashboard()),
                  );
                },
                child: const Text('লগইন করুন', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- MAIN DASHBOARD ----------------
class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;
  int _userBalance = 150;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(
        balance: _userBalance,
        onTaskComplete: () {
          setState(() {
            _userBalance += 10;
          });
        },
      ),
      WalletScreen(balance: _userBalance),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'হোম'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'উইথড্র'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'প্রোফাইল'),
        ],
      ),
    );
  }
}

// ---------------- HOME SCREEN ----------------
class HomeScreen extends StatelessWidget {
  final int balance;
  final VoidCallback onTaskComplete;

  const HomeScreen({super.key, required this.balance, required this.onTaskComplete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earning App'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Balance Card
            Card(
              color: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('আপনার ব্যালেন্স', style: TextStyle(color: Colors.white70, fontSize: 16)),
                        SizedBox(height: 8),
                        Text('৳ 150.00', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.green),
                      onPressed: () {},
                      child: const Text('পয়েন্ট: ১৫০০'),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('দৈনন্দিন টাস্ক', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            // Task List
            TaskCard(
              title: 'ডেইলি বোনাস',
              reward: '১০ পয়েন্ট',
              icon: Icons.card_giftcard,
              onTap: () {
                onTaskComplete();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ডেইলি বোনাস যোগ করা হয়েছে!')),
                );
              },
            ),
            TaskCard(
              title: 'স্পিন খেলে আয়',
              reward: '৫ পয়েন্ট',
              icon: Icons.rotate_right,
              onTap: () {
                onTaskComplete();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('স্পিন সফল হয়েছে!')),
                );
              },
            ),
            TaskCard(
              title: 'ভিডিও দেখে আয়',
              reward: '১৫ পয়েন্ট',
              icon: Icons.play_circle_fill,
              onTap: () {
                onTaskComplete();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ভিডিও দেখার পয়েন্ট যোগ হয়েছে!')),
                );
              },
            ),
            TaskCard(
              title: 'কুইজ খেলে আয়',
              reward: '২০ পয়েন্ট',
              icon: Icons.quiz,
              onTap: () {
                onTaskComplete();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('কুইজ উত্তর সঠিক হয়েছে!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final String reward;
  final IconData icon;
  final VoidCallback onTap;

  const TaskCard({
    super.key,
    required this.title,
    required this.reward,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.green, size: 36),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('পুরস্কার: $reward'),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
          onPressed: onTap,
          child: const Text('শুরু করুন'),
        ),
      ),
    );
  }
}

// ---------------- WALLET / WITHDRAW SCREEN ----------------
class WalletScreen extends StatelessWidget {
  final int balance;

  const WalletScreen({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('টাকা তুলুন (Withdraw)'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text('মোট উত্তোলনযোগ্য ব্যালেন্স'),
                subtitle: Text('৳ $balance.00', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'পেমেন্ট মেথড (বিকাশ / নগদ / রকেট)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                labelText: 'একাউন্ট নম্বর',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                labelText: 'টাকার পরিমাণ',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('উইথড্র রিকোয়েস্ট সফলভাবে জমা হয়েছে!')),
                  );
                },
                child: const Text('উইথড্র রিকোয়েস্ট দিন', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ---------------- PROFILE SCREEN ----------------
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('প্রোফাইল'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.green,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            SizedBox(height: 12),
            Text('ইউজার নাম', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('01700000000', style: TextStyle(color: Colors.grey)),
            Divider(height: 30),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('পেমেন্ট হিস্ট্রি'),
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('রেফার করুন'),
            ),
            ListTile(
              leading: Icon(Icons.support_agent),
              title: Text('হেল্পলাইন / সাপোর্ট'),
            ),
          ],
        ),
      ),
    );
  }
}

