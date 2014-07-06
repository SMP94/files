import bottle, hashlib
import cartesian 
from bottle import Bottle,get, post, response, route, run, template, request

app = Bottle()

@app.hook('after_request')
def enable_cors():
    response.headers['Access-Control-Allow-Origin'] = '*'

@route('/hello/<name>')
def index(name):
    return template('<b>Hello {{name}}</b>!', name=name)


@route('/login')
def loin():
    return '''
       <form action="/upload" method="post" enctype="multipart/form-data">
       Select a file: <input type="file" name="data" />
       <input type="submit" value="Start upload" />
       </form>
       '''

@route('/upload', method = 'POST')
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
            '''

#       read.check(data)

@get('/check')
def showAll():
    # return devices.data
    return "string ef "


run(host='localhost', port=8080)
