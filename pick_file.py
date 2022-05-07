import datetime
from dateutil.rrule import rrule, DAILY, MONTHLY
import shutil
import os
import glob
import zipfile




def date_range(start_date, end_date):
    return [dt.date() for dt in rrule(DAILY, dtstart=start_date, until=end_date)]



def Copy_File_list(old_path,days):
    file_name = ["Txn",'Inv','Refund','Void','Items','Point']

    for file in file_name:
        _data_range_limit = datetime.datetime.today()-datetime.timedelta(days = days)
        _date_range = date_range(_data_range_limit,datetime.date.today()+datetime.timedelta(days=  1))
        _file_name = []
        new_path = os.getcwd().replace('\\','/')+'/DataSource/'
        old_path=old_path.replace("\\","//")+"/"


        if not os.path.isdir("DataSource"):
            os.mkdir("DataSource")  
        for data in _date_range:
            _file_name.append(file + "_" + data.strftime('%Y%m%d') +".zip")

        for i in _file_name:
            try:
                shutil.copyfile(old_path+i , new_path +i)
            except Exception:
                pass


def Read_Data_csv():
    import os
    import zipfile
    import pandas as pd
    final_Name = "_test.csv"

    Raw_data_files = ["Txn",'Inv','Refund','Void','Items','Point']
    for Raw_data_file in Raw_data_files:
        zip_name = []
        for root,dirs,files in os.walk("DataSource"):
            for name in files:
                zip_name.append(os.path.join(root,name))

        zip_name=list(filter(lambda i : i.find("Txn")>=0,zip_name))

        csv_name = [i.replace('.zip','.csv').replace('DataSource\\','') for i in zip_name]


        if os.path.isfile(i+final_Name):
            os.remove(i+final_Name)

        _index = ['store', 'transaction_time']

        for i in zip_name:
            for j in csv_name:
                    with zipfile.ZipFile(i,'r') as z:
                        with z.open(j) as f:
                            t = pd.read_csv(f ,index_col=_index) 
                            t.to_csv(Raw_data_file+final_Name ,mode = 'a+')


old_path = "\\wtctw-qnap01\wtctwnasqnap\IA\ACL\Void&Refund\Rawdata"

days = 73

# [Copy_File_list(file_name,old_path,days) for file_name in files]
Copy_File_list(old_path,days)
# Read_Data_csv()
