@set ACLWin="C:\Program Files (x86)\ACL Software\ACL for Windows 15\ACLWin.exe"
@set _python = "C:\Users\JeffWang\AppData\Local\Programs\Python\Python310\python.exe"
@md DataSource
@set path=%~dp0
@set DataSourcepath=%~dp0DataSource
@SET YEAR=%date:~0,4%
@SET MON=%date:~5,2%
@SET DAY=%date:~8,2%
@set date=%YEAR%%MON%%DAY%
@rem @echo ******************清除資料***********************
@rem @del /F /S "Point*.csv"
@rem @del /F /S "Inv*.csv"
@rem @del /F /S "Refund*.csv"
@rem @del /F /S "Void*.csv"
@rem @del /F /S "Txn*.csv"
@rem @del /F /S "Items*.csv"

@echo ******************開使資料倉儲***********************
@set /p date=輸入禮拜二的日期 (YYYYMMDD) :
@set /p this_week=輸入前一周周期(ex:7) :

@md "%DataSourcepath%\Point"
@md "%DataSourcepath%\Inv"
@md "%DataSourcepath%\Refund"
@md "%DataSourcepath%\Void"
@md "%DataSourcepath%\Txn"
@md "%DataSourcepath%\Items"




REM @copy "\\wtctw-qnap01\wtctwnasqnap\IA\ACL\Void&Refund\Rawdata\*2022*.zip" "%DataSourcepath%" /Y
C:\Users\JeffWang\AppData\Local\Programs\Python\Python310\python.exe "pick_file.py"

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

@%ACLWin% %~dp0_DataWarehouse_2022.acl /v_this_week="2022_%this_week%" /v_Audit_Program="F" /b_DataWarehouse_2022 /min


@del "*.csv"

cd "C:\_DataWarehouse_2022\DataSource"
call "C:\_DataWarehouse_2022\DataSource\清理.bat"