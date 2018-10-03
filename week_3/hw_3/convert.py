import pandas as pd

data = pd.read_csv('data.csv', encoding = 'big5')

out = ['項次,停車場名稱,經度(WGS84),緯度(WGS84)\n']

for i in range(len(data)):
    out.append(str(data.iloc[i, 0]) + ',' + str(data.iloc[i, 1]) + ',' + str(data.iloc[i, 2]) + ',' + str(data.iloc[i, 3]) + '\n')

outputfile = open('new_data.csv', 'w')
outputfile.writelines(out)
outputfile.close()

print('All process done')
