import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_app/src/config/config.dart';
import 'package:very_good_app/src/users/cubit/user_cubit.dart';
import 'package:very_good_app/src/utils/utils.dart';

class UsersView extends StatefulWidget {
  UsersView({Key? key}) : super(key: key);

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  Environment? env = Environment.instance;

  final _scrollController = ScrollController();
  final _keyRefresh = GlobalKey<RefreshIndicatorState>();
  final _keyForm = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("BLOC Infinite Scroll ${env!.name}"),
        actions: [
          Visibility(
            visible: kIsWeb,
            child: IconButton(
              onPressed: () => _keyRefresh.currentState!.show(),
              icon: Icon(Icons.refresh),
            ),
          ),
          IconButton(
            onPressed: () => _createModalButton(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/announcement_view'),
        child: Icon(Icons.html),
      ),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state.userStatus == UserStatus.failure) {
            DialogUtil.showErrorDialog(context, state.errorMessage);
          }
          if (state.userStatus == UserStatus.refresh) {
            if (kIsWeb) _scrollController.jumpTo(_scrollController.position.minScrollExtent);
          }
        },
        builder: (context, state) {
          if (state.userStatus == UserStatus.success || state.userStatus == UserStatus.refresh) {
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
                itemBuilder: (BuildContext context, int index) {
                  return (index >= state.data!.length - 1)
                      ? state.hasMax!
                          ? SizedBox()
                          : _BottomLoader()
                      : ListTile(
                          title: Text(state.data![index].name),
                          subtitle: Text(state.data![index].username),
                          trailing: Text(state.data![index].id!),
                          onTap: () {},
                        );
                },
                separatorBuilder: (BuildContext context, int index) => Divider(height: 0),
              ),
            );
          } else if (state.userStatus == UserStatus.failure) {
            return Center(child: Text("Failed to get data Users."));
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<void> _createModalButton(BuildContext context) async {
    _scaffoldKey.currentState!.showBottomSheet((context) => BlocBuilder<UserCubit, UserState>(
          builder: ((context, state) => Wrap(
                children: [
                  Form(
                    key: _keyForm,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              width: double.infinity,
                              child: Text(
                                "Create User",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            TextFormField(
                              controller: _nameController,
                              validator: (i) {
                                if (i!.isEmpty) {
                                  return "Nama tidak boleh kosong";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  labelText: "Name",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)))),
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              controller: _usernameController,
                              validator: (i) {
                                if (i!.isEmpty) {
                                  return "Username tidak boleh kosong";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  labelText: "Username",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)))),
                            ),
                            SizedBox(height: 36),
                            ButtonTheme(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: OutlinedButton(
                                onPressed: () {
                                  if (_keyForm.currentState!.validate()) {
                                    _keyForm.currentState!.save();

                                    context.read<UserCubit>().create(_nameController.text, _usernameController.text);
                                  }
                                },
                                child: Text("Save Data"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ));
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
        child: CircularProgressIndicator(strokeWidth: 2.5),
      ),
    );
  }
}
