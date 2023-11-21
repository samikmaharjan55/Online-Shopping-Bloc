import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping_bloc/features/cart/ui/cart_screen.dart';
import 'package:online_shopping_bloc/features/home/bloc/home_bloc.dart';
import 'package:online_shopping_bloc/features/home/ui/product_tile.dart';
import 'package:online_shopping_bloc/features/wishlist/ui/wishlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartScreen(),
              ));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WishlistScreen(),
              ));
        } else if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Item Carted')));
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Item Wishlisted')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Grocery',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.teal,
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      )),
                ],
              ),
              body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductTile(
                      homeBloc: homeBloc,
                      productDataModel: successState.products[index],
                    );
                  }),
            );
          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
