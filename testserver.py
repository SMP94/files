import bottle,json, pymongo, zlib, base64,hashlib,cartesian
from bottle import response, template, run, static_file
from bottle import Bottle,get, post, response, route, run, template, request

from pymongo import MongoClient

client = MongoClient()
db = client.local
col = db.vizdata
hash = []
app = bottle.Bottle()

@app.hook('after_request')
def enable_cors():
    response.headers['Access-Control-Allow-Origin'] = '*'

# a simple json test main page
@app.route('/')
def home():
    hash = []
    for str in col.find():
	hash.append(str['s1'])
    return template('list', hash = hash)

@app.route('/static/<filename>')
def server_static(filename):
    return static_file(filename, root='/home/spatil/pyfiles/static')

@app.route('/upload', method = 'POST')
def do_upload():
        data = request.files.data
        raw = data.file.read()
        hash = hashlib.sha1(raw).hexdigest()
        print hash
        string = raw
        chk = cartesian.decode(string,hash)
        if chk:
          return '''
            <p>File Read Successful...</p>
            '''
        else:
          return '''
            <p>File ALREADY EXITS.</p>
	    <form action="/">
              <input type="submit" value="Upload other file" />
            </form>
	    <form action="/hist">
              <input type="submit" value = "visualize this" />
            </form>
            '''
@app.route('/hist')
def hist():
	return template('hist')

@app.get('/check')
def showAll():
    tmp=col.find_one()
    str = tmp['hist']
    str = zlib.decompress(base64.b64decode(str))	
    return str

@app.route('/test')
def test():
   # for i in range(0,10):
	return '5'

@app.route('/process/<key>')
def proc(key):
    print key
    return key

@app.get('/getData/<hash>')
def givemehash(hash):
    #get the hash from GET request
   # hash=request.forms.get('hash')
    #find the record
    tmp = {}
    tmp=col.find_one({'s1':hash},{'_id':0})
    print tmp.keys()
    print tmp['s1']	
    tmp['hist']=zlib.decompress(base64.b64decode(tmp['hist']))
    tmp['cm']=zlib.decompress(base64.b64decode(tmp['cm']))
    tmp['t2']=zlib.decompress(base64.b64decode(tmp['t2']))
    tmp['t3']=zlib.decompress(base64.b64decode(tmp['t3']))
    return template('file',result=tmp )

run(app=app, host='localhost', port=8080)
