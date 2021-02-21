'use strict';

const utils = require('../utils/tool');
const Controller = require('egg').Controller;
const fs = require('fs');
const path = require('path');
const bcrypt = require('bcryptjs');
const config = require('../../config/setting.js');

// 引入文件上传模块
const sendToWormhole = require('stream-wormhole');
const awaitWriteStream = require('await-stream-ready').write;

class HomeController extends Controller {

  // 上传用户头像
  async uploadAvatar () {
    const { ctx } = this;

    // 去掉中文
    const reg = /[\u4e00-\u9fa5]/g;
    // 去掉特殊字符
    const pattern = /[`~!@#$^&*()=|{}':;',\\\[\]\<>\/?~！@#￥……&*（）——|{}【】'；：""'。，、？\s \- \+]/g;
    const stream = await ctx.getFileStream();
    //新建一个文件名   并去掉空格和中文防止 出现编码问题
    const filename = Date.now() + stream.filename.replace(pattern, "").replace(reg, "").replace(/[ ]/g, "");
    // 获取当前年月日
    const date = new Date();
    const year = date.getFullYear();
    const month = date.getMonth() + 1;
    const day = date.getDate();
    const flag = true;
    // 创建文件夹
    fs.mkdir(`app/public/avatars/${year}/${month}/${day}`, { recursive: true }, async (err) => {
      if (err) {
        flag = false;
        throw err;
      } else {
        //当然这里这样市不行的，因为你还要判断一下是否存在文件路径
        const target = path.join(this.config.baseDir, `app/public/avatars/${year}/${month}/${day}`, filename);
        //生成一个文件写入 文件流
        const writeStream = fs.createWriteStream(target);
        try {
          //异步把文件流 写入
          await awaitWriteStream(stream.pipe(writeStream));
        } catch (err) {
          //如果出现错误，关闭管道
          await sendToWormhole(stream);
          flag = false;
          throw err;
        }
      }
    });
    if (flag) {
      const url = `/public/avatars/${year}/${month}/${day}/${filename}`;
      //文件响应
      ctx.body = { url, filename, status: 200 };
    } else {
      ctx.body = {
        status: 500,
        msg: '上传头像失败'
      }
    }

  }

  // 上传音频
  async uploadVideo () {
    const { ctx } = this;

    // 去掉中文
    const reg = /[\u4e00-\u9fa5]/g;
    // 去掉特殊字符
    const pattern = /[`~!@#$^&*()=|{}':;',\\\[\]\<>\/?~！@#￥……&*（）——|{}【】'；：""'。，、？\s \- \+]/g;
    const stream = await ctx.getFileStream();
    //新建一个文件名   并去掉空格和中文防止 出现编码问题
    const filename = Date.now() + stream.filename.replace(/[ ]/g, "").replace(reg, "").replace(pattern, "");
    // 获取当前年月日
    const date = new Date();
    const year = date.getFullYear();
    const month = date.getMonth() + 1;
    const day = date.getDate();

    const flag = true;
    // 创建文件夹
    fs.mkdir(`app/public/videos/${year}/${month}/${day}`, { recursive: true }, async (err) => {
      if (err) {
        flag = false;
        throw err;
      }
      else {
        //当然这里这样是不行的，因为你还要判断一下是否存在文件路径
        const target = path.join(this.config.baseDir, `app/public/videos/${year}/${month}/${day}`, filename);
        //生成一个文件写入 文件流
        const writeStream = fs.createWriteStream(target);
        try {
          //异步把文件流 写入
          await awaitWriteStream(stream.pipe(writeStream));
        } catch (err) {
          //如果出现错误，关闭管道
          await sendToWormhole(stream);
          flag = false;
          throw err;
        }
      }
    });
    if (flag) {
      const url = `/public/videos/${year}/${month}/${day}/${filename}`;
      ctx.body = { url, filename, status: 200 };
    } else {
      ctx.body = {
        status: 500,
        msg: '上传歌曲失败'
      }
    }

    // const url = `/public/videos/${year}/${month}/${day}/${filename}`;
    // ctx.body = { url, filename, status: 200 };

    // //当然这里这样市不行的，因为你还要判断一下是否存在文件路径
    // const target = path.join(this.config.baseDir, `app/public/videos/${year}/${month}/${day}`, filename);
    // //生成一个文件写入 文件流
    // const writeStream = fs.createWriteStream(target);
    // try {
    //   //异步把文件流 写入
    //   await awaitWriteStream(stream.pipe(writeStream));
    // } catch (err) {
    //   //如果出现错误，关闭管道
    //   await sendToWormhole(stream);
    //   throw err;
    // }
    // const url = `/public/videos/${year}/${month}/${day}/${filename}`;
    // //文件响应
    // ctx.body = { url, filename, status: 200 };
  }

  // 删除歌曲
  async deleteVideo () {
    const { url } = this.ctx.request.body;
    let videoPath = path.join(__dirname, `..${url}`);
    fs.unlink(videoPath, (err) => {
      if (err) {
        this.ctx.body = {
          msg: '歌曲删除失败',
          status: 500
        }
      }
    })
    this.ctx.body = {
      msg: '歌曲删除成功',
      status: 200
    }
  }

  // 删除用户头像
  async deleteAvatar () {
    const { url } = this.ctx.request.body;
    let imgPath = path.join(__dirname, `..${url}`);
    fs.unlink(imgPath, (err) => {
      if (err) {
        this.ctx.body = {
          msg: '图片删除失败',
          status: 500
        }
      }
    })
    this.ctx.body = {
      msg: '图片删除成功',
      status: 200
    }
  }

  // 注册用户
  async regesterUser () {
    const { username, password, confirm_password, avatar } = this.ctx.request.body;
    const result = await this.app.mysql.select('users', {
      columns: ['username'],
      where: {
        username: username
      }
    });
    if (result.length > 0) {
      this.ctx.body = {
        msg: '用户名不能重复',
        status: 300
      }
    } else {
      if (utils.rsaDecrypt(password) === utils.rsaDecrypt(confirm_password)) {
        const pass = utils.rsaDecrypt(password);
        const insertInfo = await this.app.mysql.insert('users', {
          username,
          password: utils.bcryptPassword(pass, 15),
          avatar_url: avatar
        });
        if (insertInfo.affectedRows === 1) {
          this.ctx.body = {
            msg: '注册成功',
            status: 200
          }
        }
      } else {
        this.ctx.body = {
          msg: '俩次密码需要一致',
          status: 301
        }
      }
    }
  }

  // 用户登录
  async loginUser () {
    const { username, password } = this.ctx.request.body;
    // RSA解密
    const user_pass = utils.rsaDecrypt(password);

    // 查找是否有相同的用户名
    const result = await this.app.mysql.select('users', {
      where: {
        username: username
      }
    });

    // 有相同的用户名
    if (result.length > 0) {
      // 数据库查询的数据
      const { id, username, password: database_pass, avatar_url } = result[0];

      // 判断数据库密码与用户输入是否相同
      const flag = bcrypt.compareSync(user_pass, database_pass);
      // 设置过期时间
      let time = 3600;
      // 密码正确 执行操作
      if (flag) {
        // 生成token
        let token = utils.generateToken({
          id,
          username,
          status: 'normal'
        }, time);

        // this.ctx.cookies.set('token', token, {
        //   maxAge: time * 1000 * 60,
        //   path: '/',
        //   domain: 'localhost:3000',
        //   SameSite: 'None',
        //   httpOnly: false,
        //   secure: false,
        //   signed: false
        // });

        this.ctx.body = {
          msg: '登录成功',
          token,
          data: {
            id,
            username,
            avatar_url
          },
          status: 200
        }
      } else {
        this.ctx.body = {
          msg: '密码错误',
          status: 301
        }
      }
    } else {
      this.ctx.body = {
        msg: '用户名不存在',
        status: 300
      }
    }
  }

  async hi () {
    const { ctx } = this;
    ctx.body = 'hi, egg';
  }

  // 获取歌曲分类
  async getSongsTypes () {
    let sql = 'SELECT songstyles.id as id ,' +
      'songstyles.typeName as typeName ,' +
      'songtypes.name as name ,' +
      'songtypes.id as childrenId ,' +
      'songtypes.parentId as parentId ' +
      'FROM songstyles LEFT JOIN songtypes ON songstyles.id = songtypes.parentId';
    const result = await this.app.mysql.query(sql);
    const map = {
      '语种': [],
      '风格': [],
      '场景': [],
      '情感': [],
      '主题': [],
    }
    result.forEach(item => {
      map[item.typeName].push({
        id: item.childrenId,
        name: item.name
      })
    })
    this.ctx.body = {
      data: map
    }
  }

  // 分享歌曲
  async shareSongs () {
    const { song_name, song_singer, song_album, song_url, song_type, song_introduce, create_user, create_id, create_time } = this.ctx.request.body;
    let insertInfo = await this.app.mysql.insert('songs', {
      song_name,
      song_singer,
      song_album,
      song_url,
      song_introduce,
      create_user,
      create_id,
      create_time,
    });
    if (insertInfo.affectedRows == 1) {
      let id = insertInfo.insertId;
      song_type.forEach(async item => {

        let result = await this.app.mysql.insert('song_types', {
          songId: id,
          songTypeId: item.id,
          songTypeName: item.name
        });
      });
      this.ctx.body = {
        msg: '分享成功！',
        status: 200
      }
    } else {
      this.ctx.body = {
        msg: '分享失败！',
        status: 500
      }
    }
  }

  // 获取歌曲列表
  async getSongs () {
    const status = this.ctx.query.status;
    const typeId = this.ctx.query.typeId;
    let sql;
    if (status === 'new') {
      sql = 'SELECT songs.id,' +
        'songs.song_singer, ' +
        'songs.song_name, ' +
        'songs.song_url, ' +
        'songs.song_introduce, ' +
        'songs.song_album, ' +
        'songs.create_user, ' +
        'songs.create_id, ' +
        "FROM_UNIXTIME(songs.create_time,'%Y-%m-%d %H:%i:%s') as create_time, " +
        'songs.song_hot, ' +
        'songtypes.name as type, ' +
        'songtypes.id as typeId ' +
        'FROM song_types LEFT JOIN songtypes ON song_types.songTypeId = songtypes.id ' +
        'LEFT JOIN songs ON songs.id = song_types.songId ' +
        'ORDER BY songs.create_time DESC'
    } else {
      sql = 'SELECT songs.id,' +
        'songs.song_singer, ' +
        'songs.song_name, ' +
        'songs.song_url, ' +
        'songs.song_introduce, ' +
        'songs.song_album, ' +
        'songs.create_user, ' +
        'songs.create_id, ' +
        "FROM_UNIXTIME(songs.create_time,'%Y-%m-%d %H:%i:%s') as create_time, " +
        'songs.song_hot, ' +
        'songtypes.name as type, ' +
        'songtypes.id as typeId ' +
        'FROM song_types LEFT JOIN songtypes ON song_types.songTypeId = songtypes.id ' +
        'LEFT JOIN songs ON songs.id = song_types.songId ' +
        'ORDER BY song_hot DESC'
    }
    const result = await this.app.mysql.query(sql);
    const arr = [];

    // 进行数据处理
    for (let i = 0; i < result.length; i++) {
      let types = new Array({ typeName: result[i].type, typeId: result[i].typeId });
      for (let j = i + 1; j < result.length; j++) {
        if (result[i].id === result[j].id) {
          types.push({ typeName: result[j].type, typeId: result[j].typeId });
        }
      }
      if (!(arr.find((value, index, arr) => value.id === result[i].id))) {
        result[i].type = types;
        delete result[i].typeId;
        arr.push(result[i]);
      }
    }

    const res = [];
    if (parseInt(typeId) === 0) {
      arr.forEach(item => {
        res.push(item);
      })
    } else {
      arr.forEach(item => {
        // typeId要转数字
        if (item.type.findIndex(item1 => item1.typeId === parseInt(typeId)) >= 0) {
          res.push(item);
        }
      });
    }

    this.ctx.body = {
      status: 200,
      result: res
    }
  }

  // 增加歌曲热度
  async addHot () {
    const { song_id, song_hot } = this.ctx.request.body;

    const result = await this.app.mysql.update('songs', { id: song_id, song_hot: song_hot + 1 });
    const updateSuccess = result.affectedRows === 1;
    this.ctx.body = {
      isSuccess: updateSuccess
    }
  }

  // 下载歌曲
  async downSong () {
    const { id } = this.ctx.request.body;
    const result = await this.app.mysql.select('songs', {
      columns: ['song_url', 'song_name', 'song_singer', 'song_album'],
      where: {
        id: id
      }
    });
    let url;
    if (result.length > 0) {
      url = result[0].song_url.replace(config.config.host, "");
      const fileName = url.split('/')[6];
      const filePath = path.join(__dirname, `..${url}`);
      this.ctx.attachment(fileName);
      this.ctx.set('Content-Type', 'application/octet-stream');
      this.ctx.body = fs.createReadStream(filePath);
    }
  }

  // 根据id获取歌曲详情
  async getSongDetailById () {
    const id = this.ctx.query.id;
    let sql = 'SELECT songs.id,' +
      'songs.song_singer, ' +
      'songs.song_name, ' +
      'songs.song_url, ' +
      'songs.song_introduce, ' +
      'songs.song_album, ' +
      'songs.create_user, ' +
      'songs.create_id, ' +
      "FROM_UNIXTIME(songs.create_time,'%Y-%m-%d %H:%i:%s') as create_time, " +
      'songs.song_hot, ' +
      'songtypes.name as type, ' +
      'songtypes.id as typeId, ' +
      'relation_music_save.user_id as user_id, ' +
      'relation_music_save.song_id as song_id, ' +
      'users.avatar_url as avatar_url, ' +
      'users.id as userId, ' +
      'users.username as username ' +
      'FROM song_types LEFT JOIN songtypes ON song_types.songTypeId = songtypes.id ' +
      'LEFT JOIN songs ON songs.id = song_types.songId ' +
      'LEFT JOIN relation_music_save ON songs.id = relation_music_save.song_id ' +
      'LEFT JOIN users ON relation_music_save.user_id = users.id ' +
      'ORDER BY songs.create_time DESC'

    const result = await this.app.mysql.query(sql);

    const arr = result.filter(item => item.id === parseInt(id));

    const types = arr.map(item => ({
      typeName: item.type,
      typeId: item.typeId
    }))

    const likePersons = arr.map(item => ({
      user_id: item.userId || 0,
      username: item.username || "",
      avatar_url: item.avatar_url || ""
    }));


    utils.noRepeat(likePersons, 'user_id');
    utils.noRepeat(types, 'typeId');
    utils.noRepeat(arr, 'id');
    arr[0].type = types;
    arr[0].likePersons = likePersons.filter(item => item.user_id !== 0);
    delete arr[0].typeId;
    delete arr[0].song_id;
    delete arr[0].user_id;
    delete arr[0].avatar_url;
    delete arr[0].userId;
    delete arr[0].username;

    this.ctx.body = {
      data: arr,
    }

    //   let sql = 'SELECT songs.id,' +
    //   'songs.song_singer, ' +
    //   'songs.song_name, ' +
    //   'songs.song_url, ' +
    //   'songs.song_introduce, ' +
    //   'songs.song_album, ' +
    //   'songs.create_user, ' +
    //   'songs.create_id, ' +
    //   "FROM_UNIXTIME(songs.create_time,'%Y-%m-%d %H:%i:%s') as create_time, " +
    //   'songs.song_hot, ' +
    //   'songtypes.name as type, ' +
    //   'songtypes.id as typeId ' +
    //   'FROM song_types LEFT JOIN songtypes ON song_types.songTypeId = songtypes.id ' +
    //   'LEFT JOIN songs ON songs.id = song_types.songId ' +
    //   'ORDER BY songs.create_time DESC'
    // const result = await this.app.mysql.query(sql);

    // const arr = [];

    // // 进行数据处理
    // for (let i = 0; i < result.length; i++) {
    //   let types = new Array({ typeName: result[i].type, typeId: result[i].typeId });
    //   for (let j = i + 1; j < result.length; j++) {
    //     if (result[i].id === result[j].id) {
    //       types.push({ typeName: result[j].type, typeId: result[j].typeId });
    //     }
    //   }
    //   if (!(arr.find((value, index, arr) => value.id === result[i].id))) {
    //     result[i].type = types;
    //     delete result[i].typeId;
    //     arr.push(result[i]);
    //   }
    // }

    // this.ctx.body = {
    //   data: arr.find(item => item.id === parseInt(id))
    // }
  }

  // 提交评论
  async submitComment () {
    const { username, avatar_url, add_time, content, song_id, user_id } = this.ctx.request.body;
    const insertInfo = await this.app.mysql.insert('comments', {
      username,
      add_time,
      content,
      song_id,
      user_id,
      avatar_url,
    });
    if (insertInfo.affectedRows === 1) {
      this.ctx.body = {
        msg: '提交成功',
        status: 200
      }
    }
  }

  // 获取评论列表
  async getCommentList () {
    const song_id = this.ctx.query.song_id;
    const sql = 'SELECT ' +
      'comments.id, ' +
      'comments.likeCounts, ' +
      'comments.username, ' +
      'comments.avatar_url, ' +
      "FROM_UNIXTIME(comments.add_time,'%Y-%m-%d %H:%i:%s') as add_time, " +
      'comments.content, ' +
      'comments.song_id, ' +
      'comments.user_id, ' +
      'comments_child.id AS childId, ' +
      'comments_child.likeCounts AS childLikeCounts, ' +
      'comments_child.username AS childUsername, ' +
      'comments_child.avatar_url AS childAvatarUrl, ' +
      "FROM_UNIXTIME(comments_child.add_time,'%Y-%m-%d %H:%i:%s') AS childAddTime, " +
      'comments_child.content AS childContent, ' +
      'comments_child.userId AS childUserId, ' +
      'comments_child.relyPerson AS relyPerson, ' +
      'comments_child.parentId, ' +
      'comments_relation_parent.id AS parentCommentId, ' +
      'comments_relation_parent.username AS parentCommentUsername, ' +
      'comments_relation_parent.user_id AS parentCommentUserId, ' +
      'comments_relation_parent.commentParentId AS commentParentId, ' +
      'comments_relation_child.id AS childCommentId, ' +
      'comments_relation_child.username AS childCommentUsername, ' +
      'comments_relation_child.user_id AS childCommentUserId, ' +
      'comments_relation_child.commentChildId AS commentChildId ' +
      'FROM ' +
      'comments ' +
      'LEFT JOIN comments_child on comments.id = comments_child.parentId ' +
      'LEFT JOIN comments_relation_parent on comments.id = comments_relation_parent.commentParentId ' +
      'LEFT JOIN comments_relation_child on comments_child.id = comments_relation_child.commentChildId ' +
      'where comments.song_id =' + song_id +
      ' ORDER BY comments.add_time DESC'

    let result = await this.app.mysql.query(sql);

    const arr = [];

    const childArr = [];

    for (let i = 0; i < result.length; i++) {

      let childCommentItem = {
        id: result[i].childCommentId,
        username: result[i].childCommentUsername,
        userId: result[i].childCommentUserId,
        commentChildId: result[i].commentChildId
      }
      if (!childArr.find((value, index, arr) => value.id === childCommentItem.id) && childCommentItem.id) {
        childArr.push(childCommentItem);
      }
    }

    for (let i = 0; i < result.length; i++) {
      let children = [];
      let likePersons = [];
      if (result[i].childId) {
        children = new Array({
          childId: result[i].childId,
          childLikeCounts: result[i].childLikeCounts,
          childUsername: result[i].childUsername,
          childAvatarUrl: result[i].childAvatarUrl,
          childAddTime: result[i].childAddTime,
          childContent: result[i].childContent,
          childUserId: result[i].childUserId,
          relyPerson: result[i].relyPerson,
          parentId: result[i].parentId
        })
      }
      if (result[i].parentCommentId) {
        likePersons = new Array({
          id: result[i].parentCommentId,
          username: result[i].parentCommentUsername,
          userId: result[i].parentCommentUserId,
          commentParentId: result[i].commentParentId
        })
      }
      for (let j = i + 1; j < result.length; j++) {
        if (result[i].id === result[j].id) {
          let child = {
            childId: result[j].childId,
            childLikeCounts: result[j].childLikeCounts,
            childUsername: result[j].childUsername,
            childAvatarUrl: result[j].childAvatarUrl,
            childAddTime: result[j].childAddTime,
            childContent: result[j].childContent,
            childUserId: result[j].childUserId,
            relyPerson: result[j].relyPerson,
            parentId: result[j].parentId
          };
          let parentCommentItem = {
            id: result[j].parentCommentId,
            username: result[j].parentCommentUsername,
            userId: result[j].parentCommentUserId,
            commentParentId: result[j].commentParentId
          }
          if (!likePersons.find((value, index, arr) => value.id === parentCommentItem.id)) {
            likePersons.push(parentCommentItem);
          }

          if (!children.find((value, index, arr) => value.childId === child.childId) && child.childId) {
            children.push(child);
          }
        }
      }
      if (!(arr.find((value, index, arr) => value.id === result[i].id))) {
        result[i].children = children;
        result[i].likePersons = likePersons;
        delete result[i].childId;
        delete result[i].childLikeCounts;
        delete result[i].childUsername;
        delete result[i].childAvatarUrl;
        delete result[i].childAddTime;
        delete result[i].childContent;
        delete result[i].childUserId;
        delete result[i].relyPerson;
        delete result[i].parentId;
        delete result[i].parentCommentId;
        delete result[i].parentCommentUsername;
        delete result[i].parentCommentUserId;
        delete result[i].commentParentId;
        arr.push(result[i]);
      }
    }

    arr.forEach(item => {
      delete item.childCommentId;
      delete item.childCommentUsername;
      delete item.childCommentUserId;
      delete item.commentChildId;
      if (item.children.length > 0) {
        item.children.forEach(item1 => {
          let likePersons = [];
          childArr.forEach(item2 => {
            if (item1.childId === item2.commentChildId) {
              likePersons.push(item2);
            }
          })
          item1.likePersons = likePersons;
        })
      }
    })
    this.ctx.body = {
      arr
    }
  }

  // 回复评论
  async relyComment () {
    let { parentId, username, avatar_url, add_time, content, user_id, relyPerson } = this.ctx.request.body;
    const insertInfo = await this.app.mysql.insert('comments_child', {
      parentId,
      username,
      add_time,
      content,
      userId: user_id,
      relyPerson,
      avatar_url,
    });
    if (insertInfo.affectedRows === 1) {
      this.ctx.body = {
        msg: '评论成功',
        status: 200
      }
    }
  }

  // 点赞
  async goodToPerson () {
    let { type, username, user_id, toPersonName, toPersonId, commentId, likeCounts } = this.ctx.request.body;
    if (type === 'parent') {
      const result = await this.app.mysql.update('comments', {
        likeCounts: likeCounts + 1 //需要修改的数据
      }, {
        where: {
          id: commentId
        } //修改查询条件
      });
      if (result.affectedRows === 1) {
        const insertInfo = await this.app.mysql.insert('comments_relation_parent', {
          username,
          user_id,
          toPersonName,
          toPersonId,
          commentParentId: commentId
        });
        if (insertInfo.affectedRows === 1) {
          this.ctx.body = {
            msg: '点赞成功！',
            status: 200
          }
        }
      }
    } else if (type === 'children') {
      const result = await this.app.mysql.update('comments_child', {
        likeCounts: likeCounts + 1 //需要修改的数据
      }, {
        where: {
          id: commentId
        } //修改查询条件
      });
      if (result.affectedRows === 1) {
        const insertInfo = await this.app.mysql.insert('comments_relation_child', {
          username,
          user_id,
          toPersonName,
          toPersonId,
          commentChildId: commentId
        });
        if (insertInfo.affectedRows === 1) {
          this.ctx.body = {
            msg: '点赞成功！',
            status: 200
          }
        }
      }
    }
  }

  // 取消点赞
  async disGoodToPerson () {
    let { type, user_id, commentId, likeCounts } = this.ctx.request.body;
    if (type === 'parent') {
      const result = await this.app.mysql.update('comments', {
        likeCounts: likeCounts - 1 //需要修改的数据
      }, {
        where: {
          id: commentId
        } //修改查询条件
      });
      if (result.affectedRows === 1) {
        const deleteInfo = await this.app.mysql.delete('comments_relation_parent', {
          commentParentId: commentId,
          user_id: user_id
        })
        if (deleteInfo.affectedRows === 1) {
          this.ctx.body = {
            msg: '取消点赞成功！',
            status: 200
          }
        }
      }
    } else if (type === 'children') {
      const result = await this.app.mysql.update('comments_child', {
        likeCounts: likeCounts - 1 //需要修改的数据
      }, {
        where: {
          id: commentId
        } //修改查询条件
      });
      if (result.affectedRows === 1) {
        const deleteInfo = await this.app.mysql.delete('comments_relation_child', {
          commentChildId: commentId,
          user_id: user_id
        })
        if (deleteInfo.affectedRows === 1) {
          this.ctx.body = {
            msg: '取消点赞成功！',
            status: 200
          }
        }
      }
    }
  }

  // 删除评论
  async deleteComment () {
    let { type, id, childId } = this.ctx.request.body;
    if (type === 'parent') {
      const deleteInfo = await this.app.mysql.delete('comments', {
        id: id
      })
      if (deleteInfo.affectedRows === 1) {
        if (childId === '0') {
          this.ctx.body = {
            msg: '删除成功！',
            status: 200
          }
        } else {
          const deleteChildInfo = await this.app.mysql.delete('comments_child', {
            parentId: id
          });
          const deleteCommentParentInfo = await this.app.mysql.delete('comments_relation_parent', {
            commentParentId: id
          });
          for (let i = 0; i < childId.length; i++) {
            const deleteCommentChildInfo = await this.app.mysql.delete('comments_relation_child', {
              commentChildId: childId[i]
            });
          }
          this.ctx.body = {
            msg: '删除成功！',
            status: 200
          }
        }
      }
    } else if (type === 'children') {
      const deleteInfo = await this.app.mysql.delete('comments_child', {
        id: childId
      })
      if (deleteInfo.affectedRows === 1) {
        const deleteCommentChildInfo = await this.app.mysql.delete('comments_relation_child', {
          commentChildId: childId
        });
        this.ctx.body = {
          msg: '删除成功！',
          status: 200
        }
      }
    }
  }

  // 收藏音乐
  async saveMusic () {
    let { song_id, user_id, type } = this.ctx.request.body;
    if (type === 'save') {
      const insertInfo = await this.app.mysql.insert('relation_music_save', {
        song_id,
        user_id
      });
      if (insertInfo.affectedRows === 1) {
        this.ctx.body = {
          msg: '收藏成功！',
          status: 200
        }
      }
    } else if (type === 'disSave') {
      const deleteInfo = await this.app.mysql.delete('relation_music_save', {
        song_id,
        user_id
      });
      if (deleteInfo.affectedRows === 1) {
        this.ctx.body = {
          msg: '取消收藏成功！',
          status: 200
        }
      }
    }
  }

  // 通过歌曲id获取同类列表
  async getSameListById () {
    const type = this.ctx.request.body.type;
    const song_id = this.ctx.request.body.song_id;

    let sql = 'SELECT songs.id,' +
      'songs.song_singer, ' +
      'songs.song_name, ' +
      'songs.song_url, ' +
      'songs.song_introduce, ' +
      'songs.song_album, ' +
      'songs.create_user, ' +
      'songs.create_id, ' +
      "FROM_UNIXTIME(songs.create_time,'%Y-%m-%d %H:%i:%s') as create_time, " +
      'songs.song_hot, ' +
      'songtypes.name as type, ' +
      'songtypes.id as typeId ' +
      'FROM song_types LEFT JOIN songtypes ON song_types.songTypeId = songtypes.id ' +
      'LEFT JOIN songs ON songs.id = song_types.songId ' +
      'ORDER BY songs.create_time DESC'
    const result = await this.app.mysql.query(sql);
    const arr = [];

    // 进行数据处理
    for (let i = 0; i < result.length; i++) {
      let types = new Array({ typeName: result[i].type, typeId: result[i].typeId });
      for (let j = i + 1; j < result.length; j++) {
        if (result[i].id === result[j].id) {
          types.push({ typeName: result[j].type, typeId: result[j].typeId });
        }
      }
      if (!(arr.find((value, index, arr) => value.id === result[i].id))) {
        result[i].type = types;
        delete result[i].typeId;
        arr.push(result[i]);
      }
    }

    const res = [];

    arr.forEach(item => {
      let typeArr = (item.type).map(item1 => parseInt(item1.typeId));
      if (typeArr.sort().toString() == type.sort().toString()) {
        res.push(item);
      }
    });

    this.ctx.body = {
      res: res.filter(item => item.id !== parseInt(song_id)),
    }
  }
}

module.exports = HomeController;
