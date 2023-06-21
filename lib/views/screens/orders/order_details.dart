import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/views/screens/orders/order_placed_details.dart';
import 'package:ecommerce_app/views/screens/orders/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: 'Order Details'
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            orderStatus(
              color: redColor,
              icon: Icons.done,
              title: 'Order placed',
              showDone: data['order_placed'],
            ),
            orderStatus(
              color: Colors.blue,
              icon: Icons.thumb_up,
              title: 'Confirmed',
              showDone: data['order_confirmed'],
            ),
            orderStatus(
              color: Colors.yellow,
              icon: Icons.fire_truck,
              title: 'On Delivery',
              showDone: data['order_on_delivery'],
            ),
            orderStatus(
              color: Colors.purple,
              icon: Icons.done_all_outlined,
              title: 'Delivered',
              showDone: data['order_delivered'],
            ),
            Divider(),
            10.heightBox,
            Column(
              children: [
                orderPlacedDetails(
                  title1: 'Order Code',
                  title2: 'Shipping Method',
                  detail1: data['order_code'],
                  detail2: data['shipping_method'],
                ),
                orderPlacedDetails(
                  title1: 'Order date',
                  title2: 'Payment Method',
                  detail1: intl.DateFormat()
                      .add_yMd()
                      .format((data['order_date'].toDate())),
                  detail2: data['payment_method'],
                ),
                orderPlacedDetails(
                  title1: 'Payment Status',
                  title2: 'Delivery Status',
                  detail1: 'Unpaid',
                  detail2: 'Order Placed',
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          'Shipping Address'
                              .text
                              .size(16)
                              .fontFamily(semibold)
                              .make(),
                          5.heightBox,
                          '${data['order_by_name']}'.text.make(),
                          '${data['order_by_email']}'.text.make(),
                          '${data['order_by_address']}'.text.make(),
                          '${data['order_by_city']}'.text.make(),
                          '${data['order_by_state']}'.text.make(),
                          '${data['order_by_country']}'.text.make(),
                          '${data['order_by_phone']}'.text.make(),
                          '${data['order_by_postalcode']}'.text.make(),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          'Total Amount'
                              .text
                              .size(16)
                              .fontFamily(semibold)
                              .make(),
                          50.heightBox,
                          '${data['total_amount']}'
                              .numCurrency
                              .text
                              .color(redColor)
                              .make(),
                          70.heightBox
                        ],
                      ).box.width(120).make(),
                    ],
                  ),
                ),
              ],
            ).box.outerShadowXl.white.make(),
            Divider(),
            10.heightBox,
            'Ordered Product'
                .text
                .size(16)
                .color(darkFontGrey)
                .fontFamily(semibold)
                .makeCentered(),
            10.heightBox,
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(data['orders'].length, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    orderPlacedDetails(
                      title1: data['orders'][index]['title'],
                      title2: data['orders'][index]['tprice'],
                      detail1: '${data['orders'][index]['qty']}x',
                      detail2: 'Refundable',
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Container(
                        width: 30,
                        height: 20,
                        color: Color(data['orders'][index]['color']),
                      ),
                    ),
                    Divider(),
                  ],
                );
              }).toList(),
            ).box.outerShadowXl.white.margin(EdgeInsets.only(bottom: 4)).make(),
            30.heightBox,
          ],
        ),
      ),
    );
  }
}
