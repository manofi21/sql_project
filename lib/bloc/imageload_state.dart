import 'package:equatable/equatable.dart';

import '../photo.dart';

abstract class ImageloadState extends Equatable {
  const ImageloadState([List props = const[]]);
}

class ImageloadInitial extends ImageloadState {
  @override
  List<Object> get props => [];
}

class ImageloadLoading extends ImageloadState {
  final List<Photo> allPhoto;
  ImageloadLoading(this.allPhoto);
  @override
  List<Object> get props => [allPhoto];
}

/*
abstract class DateChooseState extends Equatable {
  List prop = const [];
  DateChooseState(prop);
    @override
  List<Object> get props => prop;
}

class DateChooseInitial extends DateChooseState {
  DateChooseInitial([prop]) : super(prop);
// DateChooseInitial();
}

class DateRetieve extends DateChooseState {
  final String dates;
  DateRetieve(this.dates) : super([dates]);
}
 */

// abstract class DateChooseState extends Equatable {
//   DateChooseState([List props = const[]]);
// }

// class DateChooseInitial extends DateChooseState {
//   @override
//   List<Object> get props => [];

// }

// class DateRetieve extends DateChooseState {
//   final String dates;
//   DateRetieve(this.dates) : super([dates]);

//   @override
//   List<Object> get props => [dates];
  
// }