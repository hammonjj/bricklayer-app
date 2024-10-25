generated:
	dart run build_runner build --delete-conflicting-outputs

rebuild:
	flutter clean
	flutter pub get
	dart run build_runner build --delete-conflicting-outputs
