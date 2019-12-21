const io = require('socket.io').listen(8000);
const ionsp = io.of('/test');

ionsp.on('connection', function (socket) {
    console.log('客户端连接成功：' + socket.id)

    // 向客户端发送消息
    socket.emit('reply', {
      id: socket.id,
      msg: 'connected',
    });

    // 接收客户端消息
    socket.on('commands', function (data) {
        console.log(data)
    });
});

