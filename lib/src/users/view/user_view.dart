import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_app/src/users/cubit/user_cubit.dart';
import 'package:very_good_app/src/utils/utils.dart';

class UsersView extends StatefulWidget {
  UsersView({Key? key}) : super(key: key);

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  final _scrollController = ScrollController();
  final _keyRefresh = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _keyRefresh.currentState!.show());

    _scrollController.addListener(_scrollEvent);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController
      ..removeListener(_scrollEvent)
      ..dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLOC Infinite Scroll"),
        actions: [
          Visibility(
            visible: kIsWeb,
            child: IconButton(
              onPressed: () => _keyRefresh.currentState!.show(),
              icon: Icon(Icons.refresh),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state.status == UserStatus.failure) {
            DialogUtil.showErrorDialog(context, state.errorMessage);
          }
          if (state.status == UserStatus.refresh) {
            if (kIsWeb)
              _scrollController
                  .jumpTo(_scrollController.position.minScrollExtent);
          }
        },
        builder: (context, state) {
          if (state.status == UserStatus.success ||
              state.status == UserStatus.refresh) {
            if (state.data!.isEmpty) {
              return Center(child: Text("Data is Empty"));
            }
            return RefreshIndicator(
              key: _keyRefresh,
              onRefresh: () => context.read<UserCubit>().refreshUsers(),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                itemCount: state.data!.length,
                separatorBuilder: (BuildContext context, int index) {
                  if (index >= state.data!.length) if (state.hasMax!)
                    return SizedBox();
                  else
                    return _BottomLoader();
                  else
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AppUtil.imageProvider(state.data![index].avatar),
                      ),
                      title: Text(state.data![index].name!),
                      subtitle: Text(state.data![index].username!),
                      trailing: Text(state.data![index].id!),
                      onTap: () {},
                    );
                },
                itemBuilder: (BuildContext context, int index) {
                  return Divider(height: 0);
                },
              ),
            );
          } else if (state.status == UserStatus.failure) {
            return Center(
              child: Text("Failed to get data Users."),
            );
          }
          else
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _scrollEvent() {
    //if position scroll is on below then fecth data again.
    if (_isBottom) context.read<UserCubit>().getAllUsers();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll == maxScroll;
  }
}

class _BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}
