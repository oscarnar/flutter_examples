import 'package:contact_info/domain/blocs/cubit/contacts_cubit.dart';
import 'package:contact_info/ui/pages/home/widgets/contact_tile.dart';
import 'package:contact_info/ui/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My contacts'),
      ),
      body: BlocBuilder<ContactsCubit, ContactsState>(
        builder: (context, state) {
          if (state is ContactsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ContactsError) {
            return Center(child: Text(state.message));
          }
          return ListView.builder(
            itemBuilder: (context, index) =>
                ContactTile(person: state.contacts![index]),
            itemCount: state.contacts!.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GoRouter.of(context).push(Routes.add),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
