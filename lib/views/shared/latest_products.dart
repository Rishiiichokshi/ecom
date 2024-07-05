import 'export.dart';
import 'export_packages.dart';

class LatestProducts extends StatelessWidget {
  const LatestProducts({
    super.key,
    required Future<List<Products>> male,
  }) : _male = male;

  final Future<List<Products>> _male;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Products>>(
      future: _male,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (snapshot.hasError) {
          return Text("Error ${snapshot.error}");
        } else {
          final male = snapshot.data;
          return StaggeredGridView.countBuilder(
            padding: EdgeInsets.zero,
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 16,
            itemCount: male!.length,
            scrollDirection: Axis.vertical,
            staggeredTileBuilder: (index) => StaggeredTile.extent(
                (index % 2 == 0) ? 1 : 1,
                (index % 4 == 1 || index % 4 == 3)
                    ? 36.h // 36% of the screen height
                    : 30.h // 40% of the screen height
                ),
            itemBuilder: (context, index) {
              final product = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductPage(
                        products: product,
                      ),
                    ),
                  );
                },
                child: StaggerTile(
                    imageUrl: product.imageUrl[0],
                    name: product.name,
                    price: "\$${product.price}"),
              );
            },
          );
        }
      },
    );
  }
}
