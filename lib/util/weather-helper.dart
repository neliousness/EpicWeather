class WeatherHelper {
  static var europeanCountries = {
    'Lisbon',
    'Madrid',
    'Paris',
    'Berlin',
    'Copenhagen',
    'Rome',
    'Dublin',
    'London',
    'Vienna',
    'Prague'
  };
  static String getWeatherAsset(String condition) {
    switch (condition.toLowerCase()) {
      case 'sunny':
        return 'sun';
      case 'clear':
        return 'clear';
      case 'partly cloudy':
        return 'cloud';
      case 'cloudy':
        return 'cloud';
      case 'overcast':
        return 'cloud';
      case 'mist':
        return 'mist';
      case 'patchy rain possible':
        return 'rain';
      case 'patchy sleet possible':
        return 'rain';
      case 'patchy freezing drizzle possible':
        return 'snow';
      case 'patchy snow possible':
        return 'snow';
      case 'thundery outbreaks possible':
        return 'thunder';
      case 'blowing snow':
        return 'snow';
      case 'blizzard':
        return 'snow';
      case 'fog':
        return 'fog';
      case 'freezing fog':
        return 'fog';
      case 'patchy light drizzle':
        return 'rain';
      case 'light drizzle':
        return 'rain';
      case 'freezing drizzle':
        return 'rain';
      case 'heavy freezing drizzle':
        return 'rain';
      case 'patchy light rain':
        return 'rain';
      case 'light rain':
        return 'rain';
      case 'moderate rain at times':
        return 'rain';
      case 'moderate rain':
        return 'rain';
      case 'heavy rain at times':
        return 'rain';
      case 'heavy rain':
        return 'rain';
      case 'light freezing rain':
        return 'rain';
      case 'moderate or heavy freezing rain':
        return 'rain';
      case 'light sleet':
        return 'rain';
      case 'moderate or heavy sleet':
        return 'rain';
      case 'patchy light snow':
        return 'snow';
      case 'patchy moderate snow':
        return 'snow';
      case 'moderate snow':
        return 'snow';
      case 'patchy heavy snow':
        return 'snow';
      case 'heavy snow':
        return 'snow';
      case 'ice pellets':
        return 'snow';
      case 'light rain shower':
        return 'rain';
      case 'moderate or heavy rain shower':
        return 'rain';
      case 'torrential rain shower':
        return 'rain';
      case 'light sleet showers':
        return 'rain';
      case 'moderate or heavy sleet showers':
        return 'rain';
      case 'light snow showers':
        return 'snow';
      case 'moderate or heavy snow showers':
        return 'snow';
      case 'light showers of ice pellets':
        return 'snow';
      case 'moderate or heavy showers of ice pellets':
        return 'snow';
      case 'patchy light rain with thunder':
        return 'thunder';
      case 'moderate or heavy rain with thunder':
        return 'thunder';
      case 'patchy light snow with thunder':
        return 'thunder';
      case 'moderate or heavy snow with thunder':
        return 'thunder';
      default:
        return '';
    }
  }
}
