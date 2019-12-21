import socketio

sio = socketio.Client()

@sio.on('connect')
def on_connect():
    print('connected')
    pass

@sio.on('reply')
def on_event(data):
    print(data)
    pass

sio.connect('http://127.0.0.1:8000')
sio.wait()