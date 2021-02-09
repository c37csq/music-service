const JSEncrypt = require("node-jsencrypt");
const key = require('../../config/key.js');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

// RSA解密
exports.rsaDecrypt = ciphertext => {
  let decrypt = new JSEncrypt();
  decrypt.setPrivateKey(key.PRIVATE_KEY);
  let uncrypted = decrypt.decrypt(ciphertext);
  return uncrypted;
};

// bcrypt加密 saltRounds: 生成salt的迭代次数
exports.bcryptPassword = (password, saltRounds) => {
  //随机生成salt
  const salt = bcrypt.genSaltSync(saltRounds);
  //获取hash值
  var hash = bcrypt.hashSync(password, salt);
  return hash;
}

// 生成token
/**
 * 
 * @param {data} 用户id和username 
 * @param {time} 保存时间
 */
exports.generateToken = (data, time) => {
  // 当前时间
  let created = Math.floor(Date.now() / 1000);
  // 进行签名
  let token = jwt.sign({
    data,
    exp: created + time
  }, key.PRIVATE_KEY, { algorithm: 'RS256'});

  return token;
}

/**
 * 解密token
 */
exports.verifyToken = (token) => {
  let cert = key.PUBLIC_KEY;//公钥
  let res = ''
  try {
      let result = jwt.verify(token, cert, {algorithms: ['RS256']}) || {};
      let {exp} = result, current = Math.floor(Date.now() / 1000);
      if (current <= exp) {
          res = result.data || {};
      }
  } catch (e) {
      console.log(e);
  }
  return res;
}

exports.noRepeat = (arr, key) => {
  for (let i = 0; i < arr.length; i ++) {
    for (let j = i + 1; j < arr.length; j ++) {
      if (arr[i][key] === arr[j][key]) {
        arr.splice(j, 1);
        j = j - 1;
      }
    }
  }
}

