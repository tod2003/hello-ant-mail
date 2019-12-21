import socketio
import eventlet
import subprocess
import eventlet.wsgi
from flask import Flask, render_template
from flask_cors import CORS
import os

sio = socketio.Server()
app = Flask(__name__)

#CORS(app)

# 跨域支持
#def after_request(resp):
#    resp.headers['Access-Control-Allow-Origin'] = '*'
#    return resp

#app.after_request(after_request)

# 主页
@app.route('/')
def index():
    """Serve the client-side application."""
    print('***index***')
    return render_template('index.html')

# socket.io连接
@sio.on('connect', namespace='/')
def connect(sid, environ):
    print("connect ", sid)
    sio.enter_room(sid, "doudou")
    #sio.emit('event', {'type': 'hello','data': 'connected'})

# socket.io消息
@sio.on('commands', namespace='/')
def message(sid, data):
    print("message ", data)
    # 执行指令
    (status, output) = subprocess.getstatusoutput('java -version')
    print (status, output)
    # 反馈结果
    sio.emit('reply', {'data': output}, room="doudou")

# socket.io断开
@sio.on('disconnect', namespace='/')
def disconnect(sid):
    print('disconnect ', sid)

@sio.on('leave_room', namespace='/')
def leave_room(sid, data):
    # 获取当前连接所在的房间
    rooms = sio.rooms(sid)

    # 离开房间
    sio.leave_room(sid, 'doudou')

# 入口函数
if __name__ == '__main__':
    # wrap Flask application with engineio's middleware
    app = socketio.Middleware(sio, app)

    # deploy as an eventlet WSGI server
    eventlet.wsgi.server(eventlet.listen(('', 8000)), app)