class IPFormatter {
 static String convertToWesternArabicNumerals(String input) {
    const easternArabicDigits = '٠١٢٣٤٥٦٧٨٩';
    const westernArabicDigits = '0123456789';

    StringBuffer output = StringBuffer();

    for (int i = 0; i < input.length; i++) {
      String char = input[i];
      int index = easternArabicDigits.indexOf(char);
      if (index != -1) {
        output.write(westernArabicDigits[index]);
      } else {
        output.write(char);
      }
    }

    return output.toString();
  }
}