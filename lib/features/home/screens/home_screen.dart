import 'package:bricklayer/core/utils/build_context_extensions.dart';
import 'package:bricklayer/core/utils/responsive_utilities.dart';
import 'package:bricklayer/features/home/widgets/sets_list.dart';
import 'package:bricklayer/features/home/widgets/sidebar_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';
import '../widgets/add_set_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Widget? centerWidget;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const HomeEvent.fetchUserSets());
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = getDeviceType(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<HomeBloc>().add(const HomeEvent.fetchUserSets()),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.goPush('/settings'),
          ),
        ],
      ),
      drawer: deviceType == DeviceType.mobile ? const SidebarMenu(isDrawer: true) : null,
      body: Row(
        children: [
          if (deviceType == DeviceType.desktop || deviceType == DeviceType.tablet) const SidebarMenu(),
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state.errorMessage != null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage!)),
                    );
                  });
                }

                return SetsList(state);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (dialogContext) => BlocProvider.value(
              value: context.read<HomeBloc>(),
              child: const AddSetDialog(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
