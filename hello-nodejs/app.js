
 var express = require('express');
 var app = express();
 var router = express.Router();

 var server = require('http').createServer(app);
 var io = require('socket.io')(server);

 /********************socket.io ************* */
 server.listen(3001);
 //socket部分
io.of('/test').on('connection', function(socket) {
    //接收并处理客户端的hi事件
    socket.on('hi', function(data) {
        console.log(data);

        //触发客户端事件c_hi
        socket.emit('c_hi','hello too!')
    })

    //断开事件
    socket.on('disconnect', function(data) {
        console.log('断开',data)
        socket.emit('c_leave','离开');
        //socket.broadcast用于向整个网络广播(除自己之外)
        //socket.broadcast.emit('c_leave','某某人离开了')
    })

});

/****************public directory ******************/
 app.use('/', express.static('public'))
// app.use(express.static(path.join(__dirname, '/static'))); 

/***************page router ********/
 app.get('/index.html', function(req, res){
    res.sendFile(__dirname+"/index.html", {title:'Express'});  
 })


/****************call router************ */
 router.use(function(req, res, next) {
     req.query["name"] = "tom";
     console.info('进入路由，添加一个参数name=tom');
     next();
 });
 
 router.get('/login', function(req, res, next) {
     console.log('进入路由，添加一个参数age=28');
     req.query["age"] = "28";
     next(); //请求转发
 });
 
 app.get('/login', router);
 app.get('/login', function(req, res) {
     console.log('打印参数', req.query);
     res.end('ok');
 });
 
 router.all('*', logic1, logic2);
 
 function logic1(req, res, next) {
     req.query["logic1"] = "logic1";
     next();
 }
 function logic2(req, res, next) {
     req.query["logic2"] = "logic2";
     next();
 }
 app.listen(3000); //指定端口并启动express web服务