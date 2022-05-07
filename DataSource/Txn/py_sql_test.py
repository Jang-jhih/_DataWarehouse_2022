import os
import pandas as pd

dfs = []

x = 'Txn'
for root, dirs, files in os.walk('.'):
    for file in files:
        if file.startswith(x):
            print(file)
            if file.startswith('~$'):
                continue
            else:
                df = pd.read_csv(file,  encoding='utf-8', low_memory=False)
                dfs.append(df)