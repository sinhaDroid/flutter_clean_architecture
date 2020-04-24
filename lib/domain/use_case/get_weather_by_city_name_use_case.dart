import 'package:flutter_clean_architecture/core/app_result.dart';
import 'package:flutter_clean_architecture/domain/repository/repository.dart';
import 'package:flutter_clean_architecture/domain/use_case/save_city_name_use_case.dart';
import 'package:injectable/injectable.dart';

abstract class GetWeatherByCityNameUseCase {
  Future<AppResult> execute(String cityName);
}

@injectable
@RegisterAs(GetWeatherByCityNameUseCase)
class GetWeatherByCityName implements GetWeatherByCityNameUseCase {
  final Repository repository;
  final SaveCityNameUseCase saveCityNameUseCase;

  GetWeatherByCityName(this.repository, this.saveCityNameUseCase);

  @override
  Future<AppResult> execute(String cityName) async {
    final response = await repository.getWeatherByCityName(cityName);
    response.mapSuccess((data) => saveCityNameUseCase.execute(cityName));
    return response;
  }
}
