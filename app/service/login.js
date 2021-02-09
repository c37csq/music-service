const Service = require('egg').Service;

class LoginService extends Service {
  // 判断用户token是否合法
  async checkLegal (id, username) {
    const res = await this.app.mysql.select('users', {
      where: {
        id: id,
        username: username
      }
    });
    return res.length > 0
  }
}

module.exports = LoginService;