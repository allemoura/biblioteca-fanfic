class Utils {
  String replaceValue(String value) {
    String valueFinal = value;
    //remove acentos do e
    valueFinal = valueFinal.replaceAll(RegExp(r'á'), 'a');
    valueFinal = valueFinal.replaceAll(RegExp(r'ã'), 'a');
    valueFinal = valueFinal.replaceAll(RegExp(r'à'), 'a');
    valueFinal = valueFinal.replaceAll(RegExp(r'â'), 'a');
    valueFinal = valueFinal.replaceAll(RegExp(r'ä'), 'a');
    valueFinal = valueFinal.replaceAll(RegExp(r'å'), 'a');

    //remove acentos do e
    valueFinal = valueFinal.replaceAll(RegExp(r'é'), 'e');
    valueFinal = valueFinal.replaceAll(RegExp(r'ê'), 'e');
    valueFinal = valueFinal.replaceAll(RegExp(r'è'), 'e');
    valueFinal = valueFinal.replaceAll(RegExp(r'ę'), 'e');
    valueFinal = valueFinal.replaceAll(RegExp(r'ė'), 'e');
    valueFinal = valueFinal.replaceAll(RegExp(r'ē'), 'e');
    valueFinal = valueFinal.replaceAll(RegExp(r'ë'), 'e');

    //remove acentos do i
    valueFinal = valueFinal.replaceAll(RegExp(r'í'), 'i');
    valueFinal = valueFinal.replaceAll(RegExp(r'î'), 'i');
    valueFinal = valueFinal.replaceAll(RegExp(r'ì'), 'i');
    valueFinal = valueFinal.replaceAll(RegExp(r'ï'), 'i');
    valueFinal = valueFinal.replaceAll(RegExp(r'į'), 'i');
    valueFinal = valueFinal.replaceAll(RegExp(r'ī'), 'i');

    //remove acentos do o
    valueFinal = valueFinal.replaceAll(RegExp(r'ó'), 'o');
    valueFinal = valueFinal.replaceAll(RegExp(r'õ'), 'o');
    valueFinal = valueFinal.replaceAll(RegExp(r'ô'), 'o');
    valueFinal = valueFinal.replaceAll(RegExp(r'ò'), 'o');
    valueFinal = valueFinal.replaceAll(RegExp(r'ò'), 'o');
    valueFinal = valueFinal.replaceAll(RegExp(r'ö'), 'o');
    valueFinal = valueFinal.replaceAll(RegExp(r'ō'), 'o');

    //remove acentos do u
    valueFinal = valueFinal.replaceAll(RegExp(r'ú'), 'u');
    valueFinal = valueFinal.replaceAll(RegExp(r'ü'), 'u');
    valueFinal = valueFinal.replaceAll(RegExp(r'ù'), 'u');
    valueFinal = valueFinal.replaceAll(RegExp(r'û'), 'u');
    valueFinal = valueFinal.replaceAll(RegExp(r'ū'), 'u');

    return valueFinal;
  }
}
