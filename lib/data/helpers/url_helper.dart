///URLs
class BaseURL {
  static bool isLive = false;
  static String _stage = "https://api.spoticharge.com/api";
  static String _live = "";

  static String getFullPath(String url) {
    return (BaseURL.isLive ? _live : _stage) + url;
  }
}
