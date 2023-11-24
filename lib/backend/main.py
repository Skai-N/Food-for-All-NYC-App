import csv

def parseData(fileName):
    neededCols = [2, 3, 4, 5, 6, 7, 8, 14, 15]
    finalData = []
    with open(fileName, 'r') as f:
        reader = csv.reader(f)
        for row in reader:
            addRow = []
            for i in neededCols:
                if(row[i]) == '':
                    addRow.append('N/A')
                else:
                    addRow.append(row[i])
            finalData.append(addRow)
    return finalData
data = parseData('C:\\Users\\17633\\Documents\\FoodForAll\\ffa_app\\lib\\backend\\dropOffData.csv')
def fetchInfoFromName(name):
    index = -1
    for i in data:
        if(i[0] == name):
            index = data.index(i) 
            break
    if(index == -1):
        return None
    info = {
        "name" : name,
        "Adr" : data[index][1],
        "HostedBy" : data[index][2],
        "OpenMonth" : data[index][3],
        "DayHours" : data[index][4],
        "Notes" : data[index][5],
        "Website" : data[index][6],
        "Lat" : data[index][7],
        "Lng": data[index][8],
        "ID": str(index)
    }
    return info

def get_latlng(location_name):
    latlng = {}
    markers = ""
    index = 0
    for i in data[1:]:
        index += 1
        latlng[i[0]] = {
            "latitude": fetchInfoFromName(i[0])['Lat'],
            "longitude": fetchInfoFromName(i[0])['Lng'],
            "id": index
        }
        markerTemplate = f''' 
  Marker(
    markerId: MarkerId("{index}"),
    position: LatLng({fetchInfoFromName(i[0])['Lat']}, {fetchInfoFromName(i[0])['Lng']}),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    _TAP_
  ),'''
        tapString = "onTap:(){"
        tapString += f"\n      buildSidebar(context, {index});"
        tapString += "\n    }"
        markerTemplate = markerTemplate.replace("_TAP_", tapString)
        markers += markerTemplate
    print(markers)
get_latlng(3)
def getMarkerData():
    finalSet = "[\n"
    for i in data[1:]:
        dats = fetchInfoFromName(i[0])
        finalSet += f"\n  [\"{dats['name']}\", \"{dats['Adr']}\", \"{dats['HostedBy']}\", \"{dats['OpenMonth']}\", \"{dats['DayHours']}\", \"{dats['Notes']}\", \"{dats['Website']}\"],"
    print(finalSet + "]")
#getMarkerData()
    
