// config/config.default.js
exports.keys = "abc";
// add view's configurations
exports.view = {
  defaultViewEngine: 'nunjucks',
  mapping: {
    '.tpl': 'nunjucks',
  },
};

// config/config.default.js
// add news' configurations
exports.news = {
    pageSize: 5,
    serverUrl: 'https://hacker-news.firebaseio.com/v0',
  };


  // config/config.default.js
// add middleware robot
exports.middleware = [
    'robot'
  ];
  // robot's configurations
  exports.robot = {
    ua: [
        /curl/i,
      /Baiduspider/i,
    ]
  };