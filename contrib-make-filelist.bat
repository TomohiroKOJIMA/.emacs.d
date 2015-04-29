@echo off

rem Filename:contrib-make-filelist.bat
rem Author  :Tomohiro KOJIMA
rem Date    :2015-04-26
rem
rem contrib-make-filelist.rbの処理をWindowsのタスクスケジュ
rem ーラで実行するためのバッチファイル．
rem

ruby contrib-make-filelist.rb > all.filelist

echo Filelist updated!
