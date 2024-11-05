import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_today/home/cubit/news_cubit.dart';
import 'package:news_today/home/views/home_body.dart';
import 'package:news_today/themes/cubit/theme_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    //initiate the app
    context.read<NewsCubit>().initiate();
    //load sources placement image
    // precacheImage(const AssetImage(sourceFavIconPlacement), context);
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('NEWS TODAY', style: themeCubit.appTextStyles.headline),
      ),
      body: BlocBuilder<NewsCubit, NewsState>(builder: (context, newsState) {
        if (newsState.status == NewsStatus.success) {
          print('in success');
          return const HomeBody();
        } else if (newsState.status == NewsStatus.loading) {
          return const LinearProgressIndicator();
        }
        return Text('something went wrong',
            style: themeCubit.appTextStyles.bodyLarge);
      }),
    );
  }
}
