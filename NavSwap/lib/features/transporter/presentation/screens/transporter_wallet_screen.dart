import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransporterWalletScreen extends ConsumerStatefulWidget {
  const TransporterWalletScreen({super.key});

  @override
  ConsumerState<TransporterWalletScreen> createState() =>
      _TransporterWalletScreenState();
}

class _TransporterWalletScreenState
    extends ConsumerState<TransporterWalletScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text('Wallet & Earnings',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildBalanceCard(),
                  const SizedBox(height: 24),
                  _buildEarningsSummary(),
                  const SizedBox(height: 24),
                  _buildFilterChips(),
                  const SizedBox(height: 16),
                  _buildTransactionsList(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A1A), Color(0xFF000000)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Available Balance',
                  style: TextStyle(color: Colors.white70, fontSize: 14)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.account_balance_wallet, color: Colors.green, size: 14),
                    SizedBox(width: 4),
                    Text('Active',
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('₹45,280',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold)),
              SizedBox(width: 8),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text('.00',
                    style: TextStyle(color: Colors.white70, fontSize: 24)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.account_balance, size: 18),
                  label: const Text('Withdraw'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1A1A1A),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.history, size: 18),
                  label: const Text('History'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Earnings Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _summaryItem(
                  'Today',
                  '₹2,450',
                  Icons.today,
                  Colors.blue,
                  '+12%',
                ),
              ),
              Container(width: 1, height: 60, color: Colors.grey[300]),
              Expanded(
                child: _summaryItem(
                  'This Week',
                  '₹14,280',
                  Icons.calendar_today,
                  Colors.green,
                  '+8%',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _summaryItem(
                  'This Month',
                  '₹45,280',
                  Icons.calendar_month,
                  Colors.orange,
                  '+15%',
                ),
              ),
              Container(width: 1, height: 60, color: Colors.grey[300]),
              Expanded(
                child: _summaryItem(
                  'Total',
                  '₹2.4L',
                  Icons.account_balance_wallet,
                  Colors.purple,
                  '',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryItem(
      String label, String amount, IconData icon, Color color, String change) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(amount,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF6B6B6B))),
        if (change.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(change,
              style: TextStyle(
                  fontSize: 11,
                  color: change.startsWith('+') ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600)),
        ],
      ],
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _filterChip('All'),
          const SizedBox(width: 8),
          _filterChip('Credits'),
          const SizedBox(width: 8),
          _filterChip('Debits'),
          const SizedBox(width: 8),
          _filterChip('Today'),
          const SizedBox(width: 8),
          _filterChip('This Week'),
          const SizedBox(width: 8),
          _filterChip('This Month'),
        ],
      ),
    );
  }

  Widget _filterChip(String label) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A1A1A) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF1A1A1A) : Colors.grey[300]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF6B6B6B),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Recent Transactions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _transactionCard(
          'Task Completed - TSK-1234',
          'Downtown Swap Station',
          '+ ₹450',
          '2 hours ago',
          true,
        ),
        const SizedBox(height: 12),
        _transactionCard(
          'Task Completed - TSK-1233',
          'Airport Swap Station',
          '+ ₹580',
          '5 hours ago',
          true,
        ),
        const SizedBox(height: 12),
        _transactionCard(
          'Withdrawal',
          'Bank Transfer to ****4532',
          '- ₹10,000',
          '1 day ago',
          false,
        ),
        const SizedBox(height: 12),
        _transactionCard(
          'Task Completed - TSK-1231',
          'Mall Swap Station',
          '+ ₹380',
          '1 day ago',
          true,
        ),
        const SizedBox(height: 12),
        _transactionCard(
          'Task Completed - TSK-1230',
          'Tech Park Station',
          '+ ₹620',
          '2 days ago',
          true,
        ),
      ],
    );
  }

  Widget _transactionCard(
      String title, String subtitle, String amount, String time, bool isCredit) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isCredit
                  ? Colors.green.withOpacity(0.1)
                  : Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isCredit ? Icons.arrow_downward : Icons.arrow_upward,
              color: isCredit ? Colors.green : Colors.red,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 12, color: Color(0xFF6B6B6B))),
                const SizedBox(height: 4),
                Text(time,
                    style: const TextStyle(
                        fontSize: 11, color: Color(0xFF6B6B6B))),
              ],
            ),
          ),
          Text(amount,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isCredit ? Colors.green : Colors.red)),
        ],
      ),
    );
  }
}