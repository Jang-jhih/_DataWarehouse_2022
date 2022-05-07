

@set ACLWin="C:\Program Files (x86)\ACL Software\ACL for Windows 15\ACLWin.exe"
@set _python = "C:\Users\JeffWang\AppData\Local\Programs\Python\Python310\python.exe"
@set ACLpath ="\\Jw-561\c\ACL\ACL_Audit\1.主要查核程式\Project"
cd C:\ACL\_DataWarehouse_2022
@md DataSource
@set path=%~dp0
@set DataSourcepath=%~dp0DataSource
@SET YEAR=%date:~0,4%
@SET MON=%date:~5,2%
@SET DAY=%date:~8,2%
@set date=%YEAR%%MON%%DAY%






@cd "%DataSourcepath%"
@"C:\Program Files\7-Zip\7z.exe" e *.zip -y
@del "%DataSourcepath%\*.zip"


@echo **************開始合併檔案**************

@copy "%DataSourcepath%\Txn_*.csv" "%path%Txn.csv"
@copy "%DataSourcepath%\Refund_*.csv" "%path%Refund.csv"
@copy "%DataSourcepath%\Void_*.csv" "%path%Void.csv"
@copy "%DataSourcepath%\Inv_*.csv" "%path%Inv.csv"
@copy "%DataSourcepath%\Point*.csv" "%path%Point.csv"
@copy "%DataSourcepath%\Items_%date%*.csv" "%path%Items.csv"

@echo **************分類檔案**************


@move "%DataSourcepath%\Txn_*" "%DataSourcepath%\Txn"
@move "%DataSourcepath%\Refund_*" "%DataSourcepath%\Refund"
@move "%DataSourcepath%\Void_*" "%DataSourcepath%\Void"
@move "%DataSourcepath%\Inv_*" "%DataSourcepath%\Inv"
@move "%DataSourcepath%\Point*" "%DataSourcepath%\Point"
@move "%DataSourcepath%\Items_*" "%DataSourcepath%\Items"