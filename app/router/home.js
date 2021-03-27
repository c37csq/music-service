module.exports = app => {
  const { router, controller } = app

  var interceptor = app.middleware.interceptor();
  // 前台接口
  router.get('/default/hi', interceptor, controller.home.hi);

  // 上传用户头像路由
  router.post('/default/uploadAvatar', controller.home.uploadAvatar);

  // 删除用户头像
  router.post('/default/deleteAvatar', controller.home.deleteAvatar);
  // 注册用户
  router.post('/default/regesterUser', controller.home.regesterUser);
  // 用户登录
  router.post('/default/loginUser', controller.home.loginUser);
  // 获取歌曲类别
  router.get('/default/getSongsTypes', controller.home.getSongsTypes);
  // 上传音频
  router.post('/default/uploadVideo', controller.home.uploadVideo);
  // 删除上传的歌曲
  router.post('/default/deleteVideo', interceptor, controller.home.deleteVideo);
  // 分享歌曲
  router.post('/default/shareSongs', interceptor, controller.home.shareSongs);
  // 获取歌曲列表
  router.get('/default/getSongs', controller.home.getSongs);
  // 增加歌曲热度
  router.post('/default/addHot', controller.home.addHot);
  // 下载歌曲
  router.post('/default/downSong', interceptor, controller.home.downSong);
  // 根据id获取歌曲详情
  router.get('/default/getSongDetailById', controller.home.getSongDetailById);
  // 提交评论
  router.post('/default/submitComment', interceptor, controller.home.submitComment);
  // 获取评论列表
  router.get('/default/getCommentList', controller.home.getCommentList);
  // 回复评论
  router.post('/default/relyComment', interceptor, controller.home.relyComment);
  // 回复动态
  router.post('/default/relyDynamic', interceptor, controller.home.relyDynamic);
  // 点赞
  router.post('/default/goodToPerson', interceptor, controller.home.goodToPerson);
  // 取消点赞
  router.post('/default/disGoodToPerson', interceptor, controller.home.disGoodToPerson);
  // 删除评论
  router.post('/default/deleteComment', interceptor, controller.home.deleteComment);
  // 收藏音乐
  router.post('/default/saveMusic', interceptor, controller.home.saveMusic);
  // 获取同类音乐列表
  router.post('/default/getSameListById', controller.home.getSameListById);
  // 获取动态列表
  router.get('/default/getDynamicList', interceptor, controller.home.getDynamicList);
  // 根据关键词获取歌曲列表
  router.get('/default/getSongsByLike', controller.home.getSongsByLike);
  // 分享动态
  router.post('/default/addDynamic', interceptor, controller.home.addDynamic);
  // 点赞动态
  router.post('/default/goodToDynamic', interceptor, controller.home.goodToDynamic);
  // 取消点赞动态
  router.post('/default/disGoodToDynamic', interceptor, controller.home.disGoodToDynamic);
  // 删除动态
  router.post('/default/deleteDynamic', interceptor, controller.home.deleteDynamic);
  // 获取用户信息
  router.get('/default/getUserInfo', controller.home.getUserInfo);
  // 关注用户
  router.post('/default/likePerson', interceptor, controller.home.likePerson);
  // 取消关注用户
  router.post('/default/disLikePerson', interceptor, controller.home.disLikePerson);
   // 关注用户列表
   router.post('/default/getConcernList', controller.home.getConcernList);
   // 关注用户详细信息列表
   router.post('/default/getConcernDetailList', controller.home.getConcernDetailList);
   // 粉丝列表
   router.post('/default/getFans', controller.home.getFans);
   // 粉丝详细列表
   router.post('/default/getFansDetailList', controller.home.getFansDetailList);
   // 修改用户信息
   router.post('/default/updateUserInfo', interceptor, controller.home.updateUserInfo);
}