bool isSVG(String url) {
  String newURL = url.substring(0, url.indexOf("?"));
  return newURL.split('.').last == 'svg';
}
