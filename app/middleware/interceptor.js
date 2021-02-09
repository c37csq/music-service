"use strict";
const utils = require('../utils/tool.js');

module.exports = options => {
  return async function interceptor (ctx, next) {
    if (ctx.header.authorization) {
      // 获取headers里的authorization
      let authToken = ctx.headers.authorization.slice(7);
      if (authToken) {
        // 解密token
        let decode = utils.verifyToken(authToken);
        // 检查是否有用户id和用户名
        let { id, username, status } = decode;
        if (id && username && status) {
          if (status === 'normal') {
            if (username.length >= 1 && username.length <= 10) {
              const res = await ctx.service.login.checkLegal(id, username);
              if (res) {
                await next();
              } else {
                ctx.body = {
                  status: 403,
                  msg: '登录不合法',
                }
              }
            } else {
              ctx.body = {
                status: 403,
                msg: '登录不合法',
              }
            }
          }
        } else {
          // token不合法，则代表客户端token已经过期或者不合法
          ctx.body = {
            status: 402,
            msg: '你的身份已过期'
          }
        }
      } else {
        // 如果token为空，则代表客户没有登录
        ctx.body = {
          status: 401,
          msg: '你还没有登录，请登录后再进行操作！'
        }
      }
    } else {
      ctx.body = {
        status: 401,
        msg: '你还没有登录，请登录后再进行操作！'
      }
    }
  }
};