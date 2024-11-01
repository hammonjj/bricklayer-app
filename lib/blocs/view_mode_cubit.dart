import 'package:bricklayer/services/app_settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ViewMode { list, grid }

class ViewModeCubit extends Cubit<ViewMode> {
  final AppSettings _appSettings;
  static const String viewModeKey = 'view_mode';

  ViewModeCubit(AppSettings appSettings)
      : _appSettings = appSettings,
        super(ViewMode.list) {
    _loadViewMode();
  }

  void _loadViewMode() async {
    emit(_appSettings.getViewMode());
  }

  void toggleViewMode() async {
    await _appSettings.setViewMode(state == ViewMode.list ? ViewMode.grid : ViewMode.list);
    emit(_appSettings.getViewMode());
  }
}
