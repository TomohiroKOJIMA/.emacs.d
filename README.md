#フォルダ構成
- all.filelist             : anything用のデータベース
- contrib-make-filelist.rb : all.filelistを最新状態に更新するRubyスクリプト
- contrib-make-filelist.bat: Windowsのタスクスケジューラから上記を実行するためのバッチファイル


#contrib-make-filelist.rbのスケジューラへの登録
以下のコマンドを実行する

    schtasks /create /tn "EmacsUpdate" /tr c:\windows\backup.cmd /sc daily /st 00:00:00
