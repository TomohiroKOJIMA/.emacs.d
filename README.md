##フォルダ構成
- auto-install             : auto-installを使って導入したパッケージ
- auto-save-list           : autosaveのバックアップファイル
- elpa                     : elpaを使って導入したパッケージ
- plugins                  : yatex等のプラグイン関連
- server                   :
- snippets                 : 各言語modeのsnippet関連
- ac-comphist.dat          :
- all.filelist             : anything用のデータベース
- contrib-make-filelist.rb : all.filelistを最新状態に更新するRubyスクリプト
- contrib-make-filelist.bat: Windowsのタスクスケジューラから上記を実行するためのバッチファイル
- init.el                  : Emacsの設定ファイル

##Anything関連
###Windowsでのファイルリスト自動更新設定
1. コマンドプロンプトで以下のコマンドを実行すると毎日0時に更新する．

    schtasks /create /tn "EmacsUpdate" /tr c:\windows\backup.cmd /sc daily /st 00:00:00

2. 以下のコマンドを実行し，設定タスクの中に"EmacsUpdate"が追加されていることを確認する．

    schtasks /query

###OSX/Linuxでのファイルリスト自動更新設定
.bash_profileに書き込む（だったはず）．
