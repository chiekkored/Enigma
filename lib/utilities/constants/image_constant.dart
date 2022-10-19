bool isSVG(String url) {
  String newURL = url.substring(0, url.indexOf("?"));
  return newURL.split('.').last == 'svg';
}

bool isSVG2(String url) {
  // String newURL = url.substring(0, url.indexOf("?"));
  return url.split('.').last == 'svg';
}
