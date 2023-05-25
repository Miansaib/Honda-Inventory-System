// final timeRange = TimeRange.daily; // or TimeRange.monthly, TimeRange.yearly, TimeRange.allTime
//
// return StreamBuilder<List<Map<String, dynamic>>>(
// stream: getProductsByTimeRange(timeRange),
// builder: (context, snapshot) {
// if (snapshot.hasData) {
// final productsData = snapshot.data!;
// return ListView.builder(
// itemCount: productsData.length,
// itemBuilder: (context, index) {
// final product = productsData[index];
// return ListTile(
// leading: Image.network(product['image_url']),
// title: Text(product['name']),
// subtitle: Text('Price: ${product['price']}, Wholesale price: ${product['wholesale_price']}'),
// );
// },
// );
// } else if (snapshot.hasError) {
// return Text('Error: ${snapshot.error}');
// } else {
// return CircularProgressIndicator();
// }
// },
// );
