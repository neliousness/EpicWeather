import 'dart:io';

/// Author Nelio Lucas
/// Date 10/22/2021

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

  static String _formatHours(String time) {
    var timeArray = time.split(" ");
    var innerTimeArray = timeArray[1].split(":");
    return '${int.parse(innerTimeArray[0])}';
  }

  static Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static String formatTime(String hour) {
    switch (_formatHours(hour)) {
      case '0':
        return '12 AM';
      case '1':
        return '1 AM';
      case '2':
        return '2 AM';
      case '3':
        return '3 AM';
      case '4':
        return '4 AM';
      case '5':
        return '5 AM';
      case '6':
        return '6 AM';
      case '7':
        return '7 AM';
      case '8':
        return '8 AM';
      case '9':
        return '9 AM';
      case '10':
        return '10 AM';
      case '11':
        return '11 AM';
      case '12':
        return '12 PM';
      case '13':
        return '1 PM';
      case '14':
        return '2 PM';
      case '15':
        return '3 PM';
      case '16':
        return '4 PM';
      case '17':
        return '5 PM';
      case '18':
        return '6 PM';
      case '19':
        return '7 PM';
      case '20':
        return '8 PM';
      case '21':
        return '9 PM';
      case '22':
        return '10 PM';
      case '23':
        return '11 PM';
      default:
        return '';
    }
  }
}
