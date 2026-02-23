import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class TransporterCreditsScreen extends ConsumerStatefulWidget {
  const TransporterCreditsScreen({super.key});

  @override
  ConsumerState<TransporterCreditsScreen> createState() =>
      _TransporterCreditsScreenState();
}

class _TransporterCreditsScreenState
    extends ConsumerState<TransporterCreditsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildCreditsSummaryCard(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildEarnedTab(),
                  _buildPendingTab(),
                  _buildRedemptionTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Text(
            'Credits',
            style: GoogleFonts.inter(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info_outline_rounded, size: 28),
            color: const Color(0xFF1A1A1A),
          ),
        ],
      ),
    );
  }

  Widget _buildCreditsSummaryCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2C2C2C), Color(0xFF000000)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.star_rounded,
                    color: Colors.amber, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Credits',
                        style: GoogleFonts.inter(
                            color: Colors.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4),
                    Text('24,580',
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0),
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _creditStatItem(
                  'This Month',
                  '2,450',
                  Icons.calendar_month_rounded,
                  Colors.blue,
                ),
              ),
              Container(
                  width: 1, height: 50, color: Colors.white.withOpacity(0.15)),
              Expanded(
                child: _creditStatItem(
                  'Pending',
                  '850',
                  Icons.schedule_rounded,
                  Colors.orange,
                ),
              ),
              Container(
                  width: 1, height: 50, color: Colors.white.withOpacity(0.15)),
              Expanded(
                child: _creditStatItem(
                  'Redeemed',
                  '1,200',
                  Icons.redeem_rounded,
                  Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _creditStatItem(
      String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(height: 10),
        Text(value,
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        Text(label,
            style: GoogleFonts.inter(
                color: Colors.white70,
                fontSize: 11,
                fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 2),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF757575),
        labelStyle:
            GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13),
        unselectedLabelStyle:
            GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13),
        tabs: const [
          Tab(text: 'Earned'),
          Tab(text: 'Pending'),
          Tab(text: 'Redeemed'),
        ],
      ),
    );
  }

  Widget _buildEarnedTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        _creditHistoryCard(
          'Task Completion Bonus',
          'TSK-1234 • Downtown Station',
          '+450',
          '2 hours ago',
          Icons.check_circle_rounded,
          Colors.green,
        ),
        const SizedBox(height: 12),
        _creditHistoryCard(
          'On-Time Delivery',
          'TSK-1233 • Airport Station',
          '+100',
          '5 hours ago',
          Icons.schedule_rounded,
          Colors.blue,
        ),
        const SizedBox(height: 12),
        _creditHistoryCard(
          'Task Completion Bonus',
          'TSK-1232 • Mall Station',
          '+380',
          '1 day ago',
          Icons.check_circle_rounded,
          Colors.green,
        ),
        const SizedBox(height: 12),
        _creditHistoryCard(
          'High Rating Reward',
          '5-star rating received',
          '+50',
          '1 day ago',
          Icons.star_rounded,
          Colors.amber,
        ),
        const SizedBox(height: 12),
        _creditHistoryCard(
          'Weekly Streak Bonus',
          '7 days consecutive delivery',
          '+200',
          '2 days ago',
          Icons.local_fire_department_rounded,
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildPendingTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        _creditHistoryCard(
          'Task Completion',
          'TSK-1235 • Under Review',
          '+420',
          'Processing',
          Icons.pending_rounded,
          Colors.orange,
          isPending: true,
        ),
        const SizedBox(height: 12),
        _creditHistoryCard(
          'Task Completion',
          'TSK-1236 • Under Review',
          '+300',
          'Processing',
          Icons.pending_rounded,
          Colors.orange,
          isPending: true,
        ),
        const SizedBox(height: 12),
        _creditHistoryCard(
          'Referral Bonus',
          'Friend signup verification',
          '+500',
          'Pending verification',
          Icons.people_rounded,
          Colors.purple,
          isPending: true,
        ),
      ],
    );
  }

  Widget _buildRedemptionTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        _buildRedeemOptions(),
        const SizedBox(height: 20),
        Text('Redemption History',
            style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A1A))),
        const SizedBox(height: 12),
        _creditHistoryCard(
          'Redeemed to Wallet',
          '1,000 credits = ₹100',
          '-1,000',
          '3 days ago',
          Icons.account_balance_wallet_rounded,
          Colors.red,
          isRedemption: true,
        ),
        const SizedBox(height: 12),
        _creditHistoryCard(
          'Gift Card',
          'Amazon ₹500 voucher',
          '-5,000',
          '1 week ago',
          Icons.card_giftcard_rounded,
          Colors.red,
          isRedemption: true,
        ),
      ],
    );
  }

  Widget _buildRedeemOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Redeem Credits',
            style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A1A))),
        const SizedBox(height: 16),
        _redeemOptionCard(
          'Transfer to Wallet',
          '1,000 credits = ₹100',
          Icons.account_balance_wallet_rounded,
          Colors.green,
        ),
        const SizedBox(height: 12),
        _redeemOptionCard(
          'Gift Cards',
          'Amazon, Flipkart & more',
          Icons.card_giftcard_rounded,
          Colors.blue,
        ),
        const SizedBox(height: 12),
        _redeemOptionCard(
          'Fuel Vouchers',
          'Get instant fuel credits',
          Icons.local_gas_station_rounded,
          Colors.orange,
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _redeemOptionCard(
      String title, String subtitle, IconData icon, Color color) {
    return GestureDetector(
      onTap: () => _showRedeemDialog(title),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFEEEEEE), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1A1A1A))),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: GoogleFonts.inter(
                          fontSize: 13,
                          color: const Color(0xFF757575),
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 18, color: Color(0xFF757575)),
          ],
        ),
      ),
    );
  }

  Widget _creditHistoryCard(
    String title,
    String subtitle,
    String amount,
    String time,
    IconData icon,
    Color color, {
    bool isPending = false,
    bool isRedemption = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: const Color(0xFF1A1A1A))),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        color: const Color(0xFF757575),
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                Text(time,
                    style: GoogleFonts.inter(
                        fontSize: 11,
                        color: const Color(0xFF9E9E9E),
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: isRedemption ? Colors.red : color)),
              if (isPending)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('Pending',
                      style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.orange)),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _showRedeemDialog(String redeemType) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Redeem Credits',
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w700, color: const Color(0xFF1A1A1A))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('How many credits would you like to redeem?',
                style: GoogleFonts.inter(fontSize: 14)),
            const SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.star_rounded),
              ),
              style: GoogleFonts.inter(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel',
                style: GoogleFonts.inter(
                    color: const Color(0xFF757575),
                    fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Redemption request submitted!',
                      style: GoogleFonts.inter()),
                  backgroundColor: const Color(0xFF1A1A1A),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A1A1A),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text('Redeem',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}