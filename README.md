# Arduino2OSC
rubyで書かれたarduinoから得られるシリアル通信をそのままoscで指定したipアドレスに流すツール

## 使い方
- config.jsonにarduinoのポートや通信レートを記述
- 送り先のipアドレスを任意に追加する

## 事前準備
```
gem install serialport
gem install osc-ruby
```
