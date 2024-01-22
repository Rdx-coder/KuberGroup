<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Trading View</title>
</head>
<body>
<!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container" style="height:100vh;width:100%">
  <div id="tradingview_992ce" style="height:calc(100% - 32px);width:100%"></div>
  <div class="tradingview-widget-copyright"><a href="https://in.tradingview.com/" rel="noopener nofollow" target="_blank"><span class="blue-text">Track all markets on TradingView</span></a></div>
  <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
  <script type="text/javascript">
  new TradingView.widget(
  {
  "autosize": true,
  "symbol": "NASDAQ:AAPL",
  "interval": "D",
  "timezone": "Asia/Colombo",
  "theme": "dark",
  "style": "1",
  "locale": "in",
  "enable_publishing": true,
  "withdateranges": true,
  "hide_side_toolbar": false,
  "allow_symbol_change": true,
  "watchlist": [
    "NSE:BANKNIFTY"
  ],
  "details": true,
  "hotlist": true,
  "calendar": true,
  "show_popup_button": true,
  "popup_width": "1000",
  "popup_height": "650",
  "container_id": "tradingview_992ce"
}
  );
  </script>
</div>
<!-- TradingView Widget END -->
</body>
</html>