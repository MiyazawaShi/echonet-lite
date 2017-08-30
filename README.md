# EchonetLite
これはECHONET Liteプロトコルの送受信を扱うためのモジュールです。

## Installation
以下のコマンドでGemパッケージをインストールします。

Add this line to your application's Gemfile:

```
$ gem install echonet_lite
```

# Usage

##送信, send

ECHONET Lite機器に対して制御または状態の確認は以下を実行する。

```ruby
EL.sendString(ip, buffer)
EL.sendOPC1(ip,seoj,deoj,esv,epc,edt)
```
・　ip: ECHONET Lite機器のipアドレスまたは、マルチキャストアドレス（224.0.23.0）
seoj,deoj..edt：　ECHONET Liteの[APPENDIX ECHONET機器オブジェクト詳細規定](https://echonet.jp/spec_object_rh/)を参照。

・　seoj,deoj等のECHONET Liteの電文構成解説は、[ECHONET Liteの電文作成方法](http://qiita.com/miyazawa_shi/items/725bc5eb6590be72970d)のページを参照する。

同一ネットワーク上のECHONET Lite機器に対しての探査を行う関数

```ruby
EL.search
```

##送信例

```ruby
# SET
EL.sendOPC1('192.168.2.163', [0x05,0xff,0x01], [0x01,0x35,0x01], 0x61, 0x80,[0x30])
EL.sendOPC1( '192.168.2.163', [0x05,0xff,0x01], [0x01,0x35,0x01], 0x61, 0x80,0x30)
EL.sendOPC1('224.0.23.0', [0x05,0xff,0x01], [0x01,0x35,0x01], 0x62, 0x80,0x30)
EL.sendOPC1( '192.168.2.163', '05ff01', "013501", "61", "80", "31");
EL.sendOPC1( '192.168.2.163', "05ff01", "013501", EL.SETC, "80", "31");
EL.sendString('192.168.2.163',"1081000005FF010135016201800131")


# GET
EL.sendOPC1( '192.168.2.163', [0x05,0xff,0x01], [0x01,0x35,0x01], 0x62, 0x80)
EL.sendOPC1('192.168.2.163', [0x05,0xff,0x01], [0x01,0x35,0x01], 0x62, 0x80)
EL.sendOPC1( '192.168.2.163', '05ff01', "013501", "62", "80", "31");
EL.sendOPC1( '192.168.2.163', "05ff01", "013501", EL.GET, "80", "31");
EL.sendString('192.168.2.163',"1081000005FF01013501620180")
EL.sendOPC1('224.0.23.0', [0x05,0xff,0x01], [0x01,0x35,0x01], 0x62, 0x80)

# Search
EL.search

```

##受信, Receive
ECHONET Lite機器から送られてくるパケットを受信する。

```ruby
EL.ReceivePrint
EL.Receive(function)
```
・ReceivePrintでは受信したECHOENT Lite電文をコンソールに表示する。
・Receive(function)では開発者が作成したfunction(関数)をコールバック関数として実行させる。

##受信例

```ruby
require "echonet_lite"

EL.ReceivePrint
EL.search
text = gets

# =>["1081361005ff010ef0016201d600"]
# ["AF_INET", 63895, "192.168.2.167", "192.168.2.167"]
# ["108136100ef00105ff017201d60401013501"]
# ["AF_INET", 3610, "192.168.2.163", "192.168.2.163"]
```

```ruby
require "echonet_lite"

def function(msg_r=nil,ip_r=nil)
  # 処理内容を記載する
  p msg_r
  p ip_r
end

EL.Receive(function)
EL.search
text = gets

# =>["1081361005ff010ef0016201d600"]
# ["AF_INET", 63895, "192.168.2.167", "192.168.2.167"]
# ["108136100ef00105ff017201d60401013501"]
# ["AF_INET", 3610, "192.168.2.163", "192.168.2.163"]
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
