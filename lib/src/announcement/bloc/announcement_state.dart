part of 'announcement_bloc.dart';

abstract class AnnouncementState extends Equatable {
  const AnnouncementState();
  
  @override
  List<Object> get props => [];
}

class AnnouncementInitial extends AnnouncementState {}
