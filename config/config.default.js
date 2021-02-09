/* eslint valid-jsdoc: "off" */

'use strict';

/**
 * @param {Egg.EggAppInfo} appInfo app info
 */
module.exports = appInfo => {
  /**
   * built-in config
   * @type {Egg.EggAppConfig}
   **/
  const config = exports = {};

  // use for cookie sign key, should change to your own and keep security
  config.keys = appInfo.name + '_1607073643291_5717';

  // add your middleware config here
  // config.middleware = ['interceptor'];
  config.middleware = [];

  // add your user config here
  const userConfig = {
    // myAppName: 'egg',
  };

  // 自定义 token 的加密条件字符串
  config.jwt = {
    secret: "c37csqc47"
  };

  // 配置连接mysql数据库
  config.mysql = {
    client: {
      host: '127.0.0.1',
      port: '3306',
      user: 'root',
      password: 'C37Csq5211314...',
      database: 'music-web'
    },
    app: true,
    agent: false
  }

  config.cluster = {
    listen: {
      path: '',
      port: 7001,
      hostname: '127.0.0.1',
    }
  };

  // 解决跨域问题
  config.security = {
    csrf: {
      enable: false,
      ignoreJSON: true,
    },
    domainWhiteList: ['http://localhost:3000']
  }

  config.cors = {
    origin: 'http://localhost:3000',
    credentials: true,
    allowMethods: 'GET, HEAD, PUT, POST, UPDATE, DELETE, PATCH, OPTIONS'
  }

  return {
    ...config,
    ...userConfig,
  };
};
