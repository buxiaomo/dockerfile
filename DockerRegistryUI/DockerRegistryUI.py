# -*- coding: UTF-8 -*-
from flask import Flask,render_template,jsonify
import requests,json,os,sys
import base64
from multiprocessing.dummy import Pool as ThreadPool
import datetime

app = Flask(__name__)

@app.route('/', methods=['GET'])
def index():
    repositories = []
    namespace = {}
    res = requests.get("http://%s/v2/_catalog" % (RegistryURL))
    res = json.loads(res.text)
    if not res.has_key("repositories"):
        return render_template(
            'index.html',
            allimagenumber=0,
            repositories=repositories,
            namespace=namespace,
            registry=u"全部",
            activenamespace=u"全部"
        )
    for repo in res['repositories']:
        r = repo.split('/')
        t_repositories = {}
        t_repositories['name'] = r[1]
        t_repositories['namespace'] = r[0]
        t_repositories['addr'] = RegistryURL + "/" + repo
        repositories.append(t_repositories)
        if not namespace.has_key(str(r[0])):
            namespace[r[0]] = 0
        namespace[r[0]] = int(namespace[r[0]]) + 1
    return render_template(
        'index.html',
        allimagenumber=len(res['repositories']),
        repositories=repositories,
        namespace=namespace,
        registry=u"全部",
        activenamespace = u"全部"
    )

@app.route('/u/<namespace>', methods=['GET'])
def namespaceimage(namespace):
    repositories = []
    t_namespace = {}
    res = requests.get("http://%s/v2/_catalog" % (RegistryURL))
    for repo in json.loads(res.text)['repositories']:
        r = repo.split('/')
        t_repositories = {}
        t_repositories['name'] = r[1]
        t_repositories['namespace'] = r[0]
        t_repositories['addr'] = RegistryURL + "/" + repo
        if t_repositories['namespace'] == namespace:
            repositories.append(t_repositories)
        if not t_namespace.has_key(str(r[0])):
            t_namespace[r[0]] = 0
        t_namespace[r[0]] = int(t_namespace[r[0]]) + 1
    return render_template(
        'index.html',
        allimagenumber=len(json.loads(res.text)['repositories']),
        repositories=repositories,
        namespace=t_namespace,
        registry=namespace,
        activenamespace=namespace
    )

def MapTag(Tag):
    t_tmp = {}
    t_tmp['name'] = Tag['tag']
    tagres = requests.get(
        "http://%s/v2/%s/manifests/%s" % (RegistryURL, Tag['namespace'] + "/" + Tag['name'], Tag['tag']),
        headers={'Accept': 'application/vnd.docker.distribution.manifest.v2+json'}
    )
    tagres = json.loads(tagres.text)
    size = 0
    for layer in tagres['layers']:
        size += int(layer['size'])
    if size / 1024 / 1024 < 1024:
        size = str(size / 1024 / 1024) + " MB"
    else:
        size = str(size / 1024 / 1024 / 1024) + " GB"
    t_tmp['size'] = size
    t_tmp['del'] = "/i/d/%s/%s/%s" % (Tag['namespace'], Tag['name'], t_tmp['name'])
    t_tmp['pull'] = "docker pull %s/%s:%s" % (RegistryURL, Tag['namespace'] + "/" + Tag['name'], Tag['tag'])
    return t_tmp

@app.route('/i/<namespace>/<name>', methods=['GET'])
def imageinfo(namespace,name):
    starttime = datetime.datetime.now()
    TAG = []
    res = requests.get("http://%s/v2/%s/tags/list" % (RegistryURL,namespace+"/"+name))
    res = json.loads(res.text)
    if not res.has_key("tags"):
        return jsonify({"tasks": "Null"})
    for tag in res['tags']:
        tmp = {}
        tmp['namespace'] = namespace
        tmp['name'] = name
        tmp['tag'] = tag
        TAG.append(tmp)
    pool = ThreadPool(processes = len(res['tags']))
    results = pool.map(MapTag,TAG)
    pool.close()
    pool.join()
    endtime = datetime.datetime.now()
    print (endtime - starttime).seconds
    return jsonify({"tasks": results})

@app.route('/i/d/<namespace>/<name>/<tag>',methods=['GET'])
def imagedel(namespace,name,tag):
    res = requests.get(
        "http://%s/v2/%s/%s/manifests/%s" %(RegistryURL,namespace,name,tag),
        headers={'Accept':'application/vnd.docker.distribution.manifest.v2+json'}
    )
    res = requests.delete("http://%s/v2/%s/%s/manifests/%s" % (RegistryURL,namespace,name,res.headers['Docker-Content-Digest']))
    if res.status_code == 202:
        result="Success"
    else:
        result="Error"
    return jsonify({"result": result})

@app.route('/clean',methods=['GET'])
def clean():
    return jsonify({"result": "test"})

def get_basic_auth_str(username, password):
    temp_str = username + ':' + password
    bytesString = temp_str.encode(encoding="utf-8")
    encodestr = base64.b64encode(bytesString)
    return 'Basic ' + encodestr.decode()

if __name__ == '__main__':
    RegistryURL = os.environ.get("RegistryURL")
    if RegistryURL is None:
        print("Please set RegistryURL !")
        sys.exit()
    # print(get_basic_auth_str("admin", "admin."))
    app.run(host="0.0.0.0", port=5000)
