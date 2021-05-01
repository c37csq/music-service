/*
 Navicat Premium Data Transfer

 Source Server         : 本机mysql
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : localhost:3306
 Source Schema         : music-web

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : 65001

 Date: 01/05/2021 21:11:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `likeCounts` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `avatar_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `add_time` int(11) NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `song_id` int(11) NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (33, 1, 'c37csq', 'http://127.0.0.1:7001/public/avatars/2020/12/7/160732886873904.png', 1612769257, '6666', 13, 12);
INSERT INTO `comments` VALUES (34, 1, 'c37csq', 'http://127.0.0.1:7001/public/avatars/2020/12/7/160732886873904.png', 1612769264, '沙发！', 13, 12);
INSERT INTO `comments` VALUES (35, 2, 'c37csq', 'http://127.0.0.1:7001/public/avatars/2020/12/7/160732886873904.png', 1612840359, '这首歌很好听的！', 10, 12);
INSERT INTO `comments` VALUES (36, 2, 'c37csq', 'http://127.0.0.1:7001/public/avatars/2020/12/7/160732886873904.png', 1612850211, '666', 10, 12);
INSERT INTO `comments` VALUES (37, 1, 'c47csq', 'http://127.0.0.1:7001/public/avatars/2020/12/22/16086370900351.png', 1612852576, '可以的！', 10, 13);
INSERT INTO `comments` VALUES (40, 2, 'c37csq', 'http://127.0.0.1:7001/public/avatars/2020/12/7/160732886873904.png', 1613877325, '可以的！', 10, 12);
INSERT INTO `comments` VALUES (49, 0, 'c37csq', 'http://127.0.0.1:7001/public/avatars/2020/12/7/160732886873904.png', 1613889726, '好听！', 25, 12);
INSERT INTO `comments` VALUES (50, 1, 'c37csq', 'http://127.0.0.1:7001/public/avatars/2020/12/7/160732886873904.png', 1615030589, '6666', 14, 12);

-- ----------------------------
-- Table structure for comments_child
-- ----------------------------
DROP TABLE IF EXISTS `comments_child`;
CREATE TABLE `comments_child`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parentId` int(11) UNSIGNED NOT NULL,
  `likeCounts` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `avatar_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `add_time` int(11) NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userId` int(11) NOT NULL,
  `relyPerson` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments_child
-- ----------------------------
INSERT INTO `comments_child` VALUES (27, 37, 2, 'c47csq', 'http://127.0.0.1:7001/public/avatars/2020/12/22/16086370900351.png', 1612852596, '占个楼！嘻嘻！', 13, 'c47csq');
INSERT INTO `comments_child` VALUES (28, 35, 2, 'c47csq', 'http://127.0.0.1:7001/public/avatars/2020/12/22/16086370900351.png', 1612854381, '还行吧，有眼光！', 13, 'c37csq');
INSERT INTO `comments_child` VALUES (29, 40, 0, 'c47csq', 'http://127.0.0.1:7001/public/avatars/2020/12/22/16086370900351.png', 1615872335, '6666', 13, 'c37csq');
INSERT INTO `comments_child` VALUES (30, 40, 0, 'c37csq', 'http://127.0.0.1:7001/public/avatars/2020/12/7/160732886873904.png', 1618019466, '11111', 12, 'c47csq');

-- ----------------------------
-- Table structure for comments_relation_child
-- ----------------------------
DROP TABLE IF EXISTS `comments_relation_child`;
CREATE TABLE `comments_relation_child`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_Id` int(11) NOT NULL,
  `toPersonName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `toPersonId` int(11) NOT NULL,
  `commentChildId` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments_relation_child
-- ----------------------------
INSERT INTO `comments_relation_child` VALUES (52, 'c47csq', 13, 'c47csq', 13, 28);
INSERT INTO `comments_relation_child` VALUES (53, 'c47csq', 13, 'c47csq', 13, 27);
INSERT INTO `comments_relation_child` VALUES (54, 'c37csq', 12, 'c47csq', 13, 28);
INSERT INTO `comments_relation_child` VALUES (55, 'c37csq', 12, 'c47csq', 13, 27);

-- ----------------------------
-- Table structure for comments_relation_parent
-- ----------------------------
DROP TABLE IF EXISTS `comments_relation_parent`;
CREATE TABLE `comments_relation_parent`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `toPersonName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `toPersonId` int(11) NOT NULL,
  `commentParentId` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments_relation_parent
-- ----------------------------
INSERT INTO `comments_relation_parent` VALUES (40, 'c37csq', 12, 'c37csq', 12, 34);
INSERT INTO `comments_relation_parent` VALUES (41, 'c37csq', 12, 'c37csq', 12, 33);
INSERT INTO `comments_relation_parent` VALUES (42, 'c37csq', 12, 'c37csq', 12, 35);
INSERT INTO `comments_relation_parent` VALUES (44, 'c37csq', 12, 'c37csq', 12, 36);
INSERT INTO `comments_relation_parent` VALUES (47, 'c47csq', 13, 'c47csq', 13, 37);
INSERT INTO `comments_relation_parent` VALUES (50, 'c47csq', 13, 'c37csq', 12, 35);
INSERT INTO `comments_relation_parent` VALUES (51, 'c47csq', 13, 'c37csq', 12, 36);
INSERT INTO `comments_relation_parent` VALUES (53, 'c37csq', 12, 'c37csq', 12, 40);
INSERT INTO `comments_relation_parent` VALUES (55, 'c47csq', 13, 'c37csq', 12, 40);
INSERT INTO `comments_relation_parent` VALUES (56, 'c37csq', 12, 'c37csq', 12, 50);

-- ----------------------------
-- Table structure for dynamic_child
-- ----------------------------
DROP TABLE IF EXISTS `dynamic_child`;
CREATE TABLE `dynamic_child`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) UNSIGNED NOT NULL,
  `likeCounts` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `avatar_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `add_time` int(11) NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userId` int(11) NOT NULL,
  `relyPerson` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dynamic_child
-- ----------------------------
INSERT INTO `dynamic_child` VALUES (14, 22, 1, 'wxwwww', 'http://127.0.0.1:7001/public/avatars/2021/3/16/16158831715185.png', 1616054378, '6666', 14, 'wxwwww');
INSERT INTO `dynamic_child` VALUES (15, 17, 0, 'c37csq', 'http://127.0.0.1:7001/public/avatars/2020/12/7/160732886873904.png', 1616058287, '66666', 12, 'c47csq');
INSERT INTO `dynamic_child` VALUES (16, 18, 0, 'c37csq', 'http://127.0.0.1:7001/public/avatars/2020/12/7/160732886873904.png', 1616058297, '可以！', 12, 'c47csq');
INSERT INTO `dynamic_child` VALUES (17, 26, 0, 'wxwwww', 'http://127.0.0.1:7001/public/avatars/2021/3/16/16158831715185.png', 1616153907, '还行吧！', 14, 'c37csq');
INSERT INTO `dynamic_child` VALUES (18, 27, 2, 'wxwwww', 'http://127.0.0.1:7001/public/avatars/2021/3/16/16158831715185.png', 1616154183, '还行！', 14, 'wxwwww');
INSERT INTO `dynamic_child` VALUES (19, 28, 2, 'wxwwww', 'http://127.0.0.1:7001/public/avatars/2021/3/16/16158831715185.png', 1616154250, '我也这么觉得耶！', 14, 'c37csq');

-- ----------------------------
-- Table structure for dynamic_parent
-- ----------------------------
DROP TABLE IF EXISTS `dynamic_parent`;
CREATE TABLE `dynamic_parent`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `likeCounts` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `avatar_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `add_time` int(11) NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `song_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dynamic_parent
-- ----------------------------
INSERT INTO `dynamic_parent` VALUES (27, 2, 'http://127.0.0.1:7001/public/avatars/2021/3/16/16158831715185.png', 1616154171, '好好听的一首歌！', 10, 14, 'wxwwww');
INSERT INTO `dynamic_parent` VALUES (28, 2, 'http://127.0.0.1:7001/public/avatars/2020/12/7/160732886873904.png', 1616154213, '好经典的一首歌！', 26, 12, 'c37csq');
INSERT INTO `dynamic_parent` VALUES (29, 1, 'http://127.0.0.1:7001/public/avatars/2020/12/22/16086370900351.png', 1616227304, '这首歌很好听啊！', 10, 13, 'c47csq');
INSERT INTO `dynamic_parent` VALUES (30, 0, 'http://127.0.0.1:7001/public/avatars/2021/3/16/16158831715185.png', 1619872904, '挺好听的！', 20, 14, 'wxwwww');
INSERT INTO `dynamic_parent` VALUES (31, 0, 'http://127.0.0.1:7001/public/avatars/2021/3/16/16158831715185.png', 1619873639, '挺好听的一首歌！', 14, 14, 'wxwwww');
INSERT INTO `dynamic_parent` VALUES (32, 0, 'http://127.0.0.1:7001/public/avatars/2021/3/16/16158831715185.png', 1619874219, '这首歌还行！', 12, 14, 'wxwwww');
INSERT INTO `dynamic_parent` VALUES (33, 0, 'http://127.0.0.1:7001/public/avatars/2021/3/16/16158831715185.png', 1619874238, '很好听的歌！', 10, 14, 'wxwwww');
INSERT INTO `dynamic_parent` VALUES (34, 0, 'http://127.0.0.1:7001/public/avatars/2021/3/16/16158831715185.png', 1619874570, '好好听！', 28, 14, 'wxwwww');

-- ----------------------------
-- Table structure for dynamic_relation_child
-- ----------------------------
DROP TABLE IF EXISTS `dynamic_relation_child`;
CREATE TABLE `dynamic_relation_child`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `toPersonName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `toPersonId` int(11) UNSIGNED NOT NULL,
  `dynamicChildId` int(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dynamic_relation_child
-- ----------------------------
INSERT INTO `dynamic_relation_child` VALUES (15, 'wxwwww', 14, 'wxwwww', 14, 19);
INSERT INTO `dynamic_relation_child` VALUES (16, 'c37csq', 12, 'wxwwww', 14, 19);
INSERT INTO `dynamic_relation_child` VALUES (17, 'wxwwww', 14, 'wxwwww', 14, 18);
INSERT INTO `dynamic_relation_child` VALUES (18, 'c37csq', 12, 'wxwwww', 14, 18);

-- ----------------------------
-- Table structure for dynamic_relation_parent
-- ----------------------------
DROP TABLE IF EXISTS `dynamic_relation_parent`;
CREATE TABLE `dynamic_relation_parent`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `toPersonName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `toPersonId` int(11) UNSIGNED NOT NULL,
  `dynamicParentId` int(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dynamic_relation_parent
-- ----------------------------
INSERT INTO `dynamic_relation_parent` VALUES (43, 'wxwwww', 14, 'wxwwww', 14, 27);
INSERT INTO `dynamic_relation_parent` VALUES (44, 'c37csq', 12, 'c37csq', 12, 28);
INSERT INTO `dynamic_relation_parent` VALUES (46, 'c37csq', 12, 'wxwwww', 14, 27);
INSERT INTO `dynamic_relation_parent` VALUES (47, 'c47csq', 13, 'c47csq', 13, 29);
INSERT INTO `dynamic_relation_parent` VALUES (48, 'wxwwww', 14, 'c37csq', 12, 28);

-- ----------------------------
-- Table structure for like_relation_person
-- ----------------------------
DROP TABLE IF EXISTS `like_relation_person`;
CREATE TABLE `like_relation_person`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) UNSIGNED NOT NULL,
  `likeUserId` int(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of like_relation_person
-- ----------------------------
INSERT INTO `like_relation_person` VALUES (32, 12, 14);
INSERT INTO `like_relation_person` VALUES (34, 14, 12);
INSERT INTO `like_relation_person` VALUES (35, 13, 14);
INSERT INTO `like_relation_person` VALUES (37, 14, 13);

-- ----------------------------
-- Table structure for relation_music_save
-- ----------------------------
DROP TABLE IF EXISTS `relation_music_save`;
CREATE TABLE `relation_music_save`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `song_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of relation_music_save
-- ----------------------------
INSERT INTO `relation_music_save` VALUES (12, 12, 25);
INSERT INTO `relation_music_save` VALUES (13, 12, 8);
INSERT INTO `relation_music_save` VALUES (14, 12, 12);
INSERT INTO `relation_music_save` VALUES (16, 13, 8);
INSERT INTO `relation_music_save` VALUES (27, 13, 9);
INSERT INTO `relation_music_save` VALUES (28, 13, 22);
INSERT INTO `relation_music_save` VALUES (29, 13, 11);
INSERT INTO `relation_music_save` VALUES (30, 13, 14);
INSERT INTO `relation_music_save` VALUES (31, 13, 16);
INSERT INTO `relation_music_save` VALUES (32, 13, 13);
INSERT INTO `relation_music_save` VALUES (33, 13, 12);
INSERT INTO `relation_music_save` VALUES (34, 13, 15);
INSERT INTO `relation_music_save` VALUES (35, 13, 18);
INSERT INTO `relation_music_save` VALUES (36, 12, 10);
INSERT INTO `relation_music_save` VALUES (37, 12, 14);
INSERT INTO `relation_music_save` VALUES (38, 13, 20);
INSERT INTO `relation_music_save` VALUES (40, 13, 19);
INSERT INTO `relation_music_save` VALUES (41, 13, 23);
INSERT INTO `relation_music_save` VALUES (42, 14, 26);
INSERT INTO `relation_music_save` VALUES (43, 14, 25);
INSERT INTO `relation_music_save` VALUES (47, 14, 27);
INSERT INTO `relation_music_save` VALUES (48, 13, 10);
INSERT INTO `relation_music_save` VALUES (49, 14, 30);
INSERT INTO `relation_music_save` VALUES (50, 14, 10);
INSERT INTO `relation_music_save` VALUES (51, 14, 28);
INSERT INTO `relation_music_save` VALUES (52, 14, 29);

-- ----------------------------
-- Table structure for song_types
-- ----------------------------
DROP TABLE IF EXISTS `song_types`;
CREATE TABLE `song_types`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `songTypeId` int(11) NOT NULL,
  `songId` int(11) NOT NULL,
  `songTypeName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 99 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of song_types
-- ----------------------------
INSERT INTO `song_types` VALUES (22, 36, 8, '伤感');
INSERT INTO `song_types` VALUES (23, 21, 8, '古风');
INSERT INTO `song_types` VALUES (24, 44, 8, '思念');
INSERT INTO `song_types` VALUES (25, 43, 8, '安静');
INSERT INTO `song_types` VALUES (26, 49, 8, '经典');
INSERT INTO `song_types` VALUES (27, 39, 9, '孤独');
INSERT INTO `song_types` VALUES (28, 1, 9, '华语');
INSERT INTO `song_types` VALUES (29, 36, 9, '伤感');
INSERT INTO `song_types` VALUES (30, 1, 10, '华语');
INSERT INTO `song_types` VALUES (31, 47, 10, '网络歌曲');
INSERT INTO `song_types` VALUES (32, 49, 10, '经典');
INSERT INTO `song_types` VALUES (33, 50, 10, '翻唱');
INSERT INTO `song_types` VALUES (34, 1, 11, '华语');
INSERT INTO `song_types` VALUES (35, 36, 11, '伤感');
INSERT INTO `song_types` VALUES (36, 1, 12, '华语');
INSERT INTO `song_types` VALUES (37, 36, 12, '伤感');
INSERT INTO `song_types` VALUES (38, 2, 13, '欧美');
INSERT INTO `song_types` VALUES (39, 1, 13, '华语');
INSERT INTO `song_types` VALUES (40, 37, 13, '治愈');
INSERT INTO `song_types` VALUES (41, 1, 14, '华语');
INSERT INTO `song_types` VALUES (42, 36, 14, '伤感');
INSERT INTO `song_types` VALUES (43, 49, 14, '经典');
INSERT INTO `song_types` VALUES (44, 1, 15, '华语');
INSERT INTO `song_types` VALUES (45, 46, 15, '影视原生');
INSERT INTO `song_types` VALUES (46, 36, 16, '伤感');
INSERT INTO `song_types` VALUES (47, 1, 16, '华语');
INSERT INTO `song_types` VALUES (48, 56, 16, '90后');
INSERT INTO `song_types` VALUES (49, 37, 17, '治愈');
INSERT INTO `song_types` VALUES (50, 1, 17, '华语');
INSERT INTO `song_types` VALUES (51, 56, 17, '90后');
INSERT INTO `song_types` VALUES (52, 40, 18, '感动');
INSERT INTO `song_types` VALUES (53, 1, 18, '华语');
INSERT INTO `song_types` VALUES (54, 6, 18, '流行');
INSERT INTO `song_types` VALUES (55, 49, 18, '经典');
INSERT INTO `song_types` VALUES (56, 1, 19, '华语');
INSERT INTO `song_types` VALUES (57, 50, 19, '翻唱');
INSERT INTO `song_types` VALUES (58, 56, 19, '90后');
INSERT INTO `song_types` VALUES (59, 1, 20, '华语');
INSERT INTO `song_types` VALUES (60, 50, 20, '翻唱');
INSERT INTO `song_types` VALUES (61, 49, 20, '经典');
INSERT INTO `song_types` VALUES (62, 50, 21, '翻唱');
INSERT INTO `song_types` VALUES (63, 1, 21, '华语');
INSERT INTO `song_types` VALUES (64, 6, 21, '流行');
INSERT INTO `song_types` VALUES (65, 49, 22, '经典');
INSERT INTO `song_types` VALUES (66, 1, 22, '华语');
INSERT INTO `song_types` VALUES (67, 6, 22, '流行');
INSERT INTO `song_types` VALUES (68, 49, 23, '经典');
INSERT INTO `song_types` VALUES (69, 1, 23, '华语');
INSERT INTO `song_types` VALUES (70, 6, 23, '流行');
INSERT INTO `song_types` VALUES (71, 50, 24, '翻唱');
INSERT INTO `song_types` VALUES (72, 1, 24, '华语');
INSERT INTO `song_types` VALUES (73, 6, 24, '流行');
INSERT INTO `song_types` VALUES (74, 49, 24, '经典');
INSERT INTO `song_types` VALUES (75, 50, 25, '翻唱');
INSERT INTO `song_types` VALUES (76, 1, 25, '华语');
INSERT INTO `song_types` VALUES (77, 47, 25, '网络歌曲');
INSERT INTO `song_types` VALUES (78, 49, 25, '经典');
INSERT INTO `song_types` VALUES (79, 1, 26, '华语');
INSERT INTO `song_types` VALUES (80, 49, 26, '经典');
INSERT INTO `song_types` VALUES (81, 54, 27, '70后');
INSERT INTO `song_types` VALUES (82, 5, 27, '粤语');
INSERT INTO `song_types` VALUES (83, 49, 27, '经典');
INSERT INTO `song_types` VALUES (84, 55, 27, '80后');
INSERT INTO `song_types` VALUES (85, 33, 28, '怀旧');
INSERT INTO `song_types` VALUES (86, 1, 28, '华语');
INSERT INTO `song_types` VALUES (87, 49, 28, '经典');
INSERT INTO `song_types` VALUES (88, 35, 28, '浪漫');
INSERT INTO `song_types` VALUES (89, 58, 29, '00后');
INSERT INTO `song_types` VALUES (90, 1, 29, '华语');
INSERT INTO `song_types` VALUES (91, 6, 29, '流行');
INSERT INTO `song_types` VALUES (92, 56, 29, '90后');
INSERT INTO `song_types` VALUES (93, 5, 30, '粤语');
INSERT INTO `song_types` VALUES (94, 49, 30, '经典');
INSERT INTO `song_types` VALUES (95, 36, 31, '伤感');
INSERT INTO `song_types` VALUES (96, 1, 31, '华语');
INSERT INTO `song_types` VALUES (97, 37, 31, '治愈');
INSERT INTO `song_types` VALUES (98, 6, 31, '流行');

-- ----------------------------
-- Table structure for songs
-- ----------------------------
DROP TABLE IF EXISTS `songs`;
CREATE TABLE `songs`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `song_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `song_singer` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `song_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `song_introduce` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `song_album` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `create_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_id` int(11) NOT NULL,
  `create_time` bigint(20) NOT NULL,
  `song_hot` int(11) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of songs
-- ----------------------------
INSERT INTO `songs` VALUES (8, '皎然记', '司夏', 'http://127.0.0.1:7001/public/videos/2020/12/24/1608805585064.mp3', '这首歌是一首非常好听的古风歌曲，我个人也非常喜欢听这首歌，所以分享给大家！', '', 'c37csq', 12, 1608805649, 65);
INSERT INTO `songs` VALUES (9, '可乐', '赵紫骅', 'http://127.0.0.1:7001/public/videos/2021/1/6/1609901900694.mp3', '这首歌真的非常好听，值得推荐，五星好评，目前已经上传，大家快去听吧！', '赵溢晨原创demo精选', 'c37csq', 12, 1609901955, 47);
INSERT INTO `songs` VALUES (10, '处处吻', '杨千嬅', 'http://127.0.0.1:7001/public/videos/2021/1/8/1610088240392.mp3', '这首歌听好听的，虽然是翻唱，但是感觉比原唱好听。', '处处吻', 'c37csq', 12, 1610088282, 95);
INSERT INTO `songs` VALUES (11, '知晚', '叶炫清', 'http://127.0.0.1:7001/public/videos/2021/1/8/1610088969900.mp3', '这首歌是我看俩世欢电视剧听到的，当时觉得挺好听的，就分享记录下来了，故此分享给大家。', '俩世欢 电视影视原生', 'c37csq', 12, 1610089044, 38);
INSERT INTO `songs` VALUES (12, '晚吟', '李俊毅', 'http://127.0.0.1:7001/public/videos/2021/1/8/1610089500956objw5zDlMODwrDDiGjCn8Ky1506975059c82d4f2a1d5885ea575c9bfb8776a0b518c89d8e3b82.mp3', '这首歌挺好听的，电视剧里的歌。', '俩世欢 电视剧影视原声', 'c37csq', 12, 1610089530, 31);
INSERT INTO `songs` VALUES (13, '终于', '双笙', 'http://127.0.0.1:7001/public/videos/2021/1/8/1610094005413065f055c025a15a951b189262cd4a1be50cf1ab79963.mp3', '这首歌挺好听的，看电视的时候超喜欢这首歌！', '俩世欢 电视剧原声', 'c37csq', 12, 1610094049, 31);
INSERT INTO `songs` VALUES (14, '道离别', '玄觞', 'http://127.0.0.1:7001/public/videos/2021/1/11/1610329810998e304e7052bd02a28a487183895d52259efdfa8881de0.mp3', '这首歌挺好听的，非常不错！', '道离别', 'c37csq', 12, 1610329847, 46);
INSERT INTO `songs` VALUES (15, '痴心绝对', '李圣杰', 'http://127.0.0.1:7001/public/videos/2021/1/11/1610334589641objw5zDlMODwrDDiGjCn8Ky31790475306ab4192508f41682bfb6946753344c487bc47fd0dbd7.mp3', '这首歌我很喜欢！挺好听的！', '痴心绝对', 'c37csq', 12, 1610334594, 33);
INSERT INTO `songs` VALUES (16, '海底', '痴心绝对', 'http://127.0.0.1:7001/public/videos/2021/1/11/1610334737398objw5zDlMODwrDDiGjCn8Ky1497471810ae4f367698a8c98c5b9f5350b8dcb34dfb81f94e73ec.mp3', '这首歌抖音火了，很好听！', '独', 'c37csq', 12, 1610334779, 33);
INSERT INTO `songs` VALUES (17, '失眠', '周思涵', 'http://127.0.0.1:7001/public/videos/2021/1/11/1610334920227545b0f5a560fc1e895cf95801393c934ae99b0c0050e.mp3', '这首歌挺好听的，爆赞！', '失眠', 'c37csq', 12, 1610334947, 26);
INSERT INTO `songs` VALUES (18, '牧马城市', '李初寒', 'http://127.0.0.1:7001/public/videos/2021/1/11/1610335040897545b0f5a560fc1e895cf95801393c934ae99b0c0050e.mp3', '这首歌挺好听的！非常经典！', '牧马城市', 'c37csq', 12, 1610335080, 41);
INSERT INTO `songs` VALUES (19, '花间酒', '傲寒同学', 'http://127.0.0.1:7001/public/videos/2021/1/12/1610434549640objw5zDlMODwrDDiGjCn8Ky14974432640292d5bc664b8e3f56f68deb7d1faa404d4b9f52770f.mp3', '这首歌挺好听的，我非常喜欢。', '花间酒', 'c47csq', 13, 1610434576, 21);
INSERT INTO `songs` VALUES (20, '以父之名', 'D调的华丽', 'http://127.0.0.1:7001/public/videos/2021/1/13/1610499940856objwo3DlMOGwrbDjj7DisKw5609939120bc210ab68426ff2df20e912257d020001649c7b77aff.mp3', '这首歌是华语神曲，相信大家都听过！', '无与伦比', 'c47csq', 13, 1610499970, 21);
INSERT INTO `songs` VALUES (21, '踏山河', '是七叔呢', 'http://127.0.0.1:7001/public/videos/2021/1/13/1610500537622objwo3DlMOGwrbDjj7DisKw525859166361bf33cfe6a5da47602351f7f71aea8c1e88de587411.mp3', '这首歌抖音很流行，非常好听！', '踏山河', 'c47csq', 13, 1610500563, 19);
INSERT INTO `songs` VALUES (22, '夜曲', '周杰伦', 'http://127.0.0.1:7001/public/videos/2021/1/13/1610500691359Cg4DAF5kKV6ASFRMADaSZ5IEdcs832.mp3', '夜曲一出上台领奖！', '2007世界巡回演唱会', 'c47csq', 13, 1610500712, 18);
INSERT INTO `songs` VALUES (23, '霍元甲', '周杰伦', 'http://127.0.0.1:7001/public/videos/2021/1/13/1610500868299BQ4DAF5sMUAeTdFADBFgseuTWA548.mp3', '好听！', '2007世界巡回演唱会', 'c47csq', 13, 1610500878, 18);
INSERT INTO `songs` VALUES (24, '烟花易冷', '周杰伦', 'http://127.0.0.1:7001/public/videos/2021/1/13/1610501438478YocBAF5xo4aAMbzkAJ5BbGlGeY988.mp3', '这首歌原唱找不到，找了个翻唱！不过也很好听！', '', 'c47csq', 13, 1610501470, 20);
INSERT INTO `songs` VALUES (25, '消愁', '毛不易', 'http://127.0.0.1:7001/public/videos/2021/2/21/16138751689478667e0981c4452fae5790c731c41491bb252958e4ed7.mp3', '这首歌超级好听！', '平凡的一天', 'c37csq', 12, 1613875192, 24);
INSERT INTO `songs` VALUES (26, '漫步人生路', '邓丽君', 'http://127.0.0.1:7001/public/videos/2021/3/17/1615978407625objw5zDlMODwrDDiGjCn8Ky191845952217d27b3248d243c1b2b4688275d85d800ab1e4921b49.mp3', '这首歌是90年代非常经典的一首歌！', '漫步人生路', 'wxwwww', 14, 1615978440, 2);
INSERT INTO `songs` VALUES (27, '暗里着迷', '刘德华', 'http://127.0.0.1:7001/public/videos/2021/3/17/1615986989678b6e122e5b7e541e1ef8758f88efb061d812821b963ab.mp3', '刘德华大大演唱会唱的歌曲，非常好听！70后80后们的回忆！', 'Wonderful World 香港演唱会 2007', 'wxwwww', 14, 1615987095, 1);
INSERT INTO `songs` VALUES (28, '难渡', '鸾音社', 'http://127.0.0.1:7001/public/videos/2021/3/27/1616832026274055d5453040c27e5e8ad2bc9d671bbae3fa46a3d6e80.mp3', '这首歌近几天在抖音听到的，感觉还可以！', '难渡', 'c37csq', 12, 1616832063, 1);
INSERT INTO `songs` VALUES (29, '大风吹', '王赫野', 'http://127.0.0.1:7001/public/videos/2021/3/27/1616832238993objwo3DlMOGwrbDjj7DisKw782731894522142e115f5754109dd134b79b64a0aab3e79e8984f6.mp3', '这首歌最近抖音挺流行的！', '大风吹', 'c37csq', 12, 1616832267, 1);
INSERT INTO `songs` VALUES (30, '相思风雨中', '张学友', 'http://127.0.0.1:7001/public/videos/2021/3/27/16168348812312b0484cb4c25c520d440acbebe7225493267817c22f4.mp3', '张学友的歌第一次觉得好听的！', '友情对唱', 'wxwwww', 14, 1616834902, 0);
INSERT INTO `songs` VALUES (31, '错位时空', '艾辰', 'http://127.0.0.1:7001/public/videos/2021/3/27/1616835224310objwo3DlMOGwrbDjj7DisKw5546003493cfbc699afadc6b094e5431dfc70cb57527f51db8dd4c.mp3', '这首歌还不错的！', '错位时空', 'wxwwww', 14, 1616835259, 0);

-- ----------------------------
-- Table structure for songstyles
-- ----------------------------
DROP TABLE IF EXISTS `songstyles`;
CREATE TABLE `songstyles`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `typeName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of songstyles
-- ----------------------------
INSERT INTO `songstyles` VALUES (1, '语种');
INSERT INTO `songstyles` VALUES (2, '风格');
INSERT INTO `songstyles` VALUES (3, '场景');
INSERT INTO `songstyles` VALUES (4, '情感');
INSERT INTO `songstyles` VALUES (5, '主题');

-- ----------------------------
-- Table structure for songtypes
-- ----------------------------
DROP TABLE IF EXISTS `songtypes`;
CREATE TABLE `songtypes`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `parentId` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of songtypes
-- ----------------------------
INSERT INTO `songtypes` VALUES (1, '华语', 1);
INSERT INTO `songtypes` VALUES (2, '欧美', 1);
INSERT INTO `songtypes` VALUES (3, '日语', 1);
INSERT INTO `songtypes` VALUES (4, '韩语', 1);
INSERT INTO `songtypes` VALUES (5, '粤语', 1);
INSERT INTO `songtypes` VALUES (6, '流行', 2);
INSERT INTO `songtypes` VALUES (7, '摇滚', 2);
INSERT INTO `songtypes` VALUES (8, '民谣', 2);
INSERT INTO `songtypes` VALUES (9, '电子', 2);
INSERT INTO `songtypes` VALUES (10, '舞曲', 2);
INSERT INTO `songtypes` VALUES (11, '说唱', 2);
INSERT INTO `songtypes` VALUES (12, '轻音乐', 2);
INSERT INTO `songtypes` VALUES (13, '爵士', 2);
INSERT INTO `songtypes` VALUES (14, '乡村', 2);
INSERT INTO `songtypes` VALUES (15, '古典', 2);
INSERT INTO `songtypes` VALUES (16, '民族', 2);
INSERT INTO `songtypes` VALUES (17, '英伦', 2);
INSERT INTO `songtypes` VALUES (18, '金属', 2);
INSERT INTO `songtypes` VALUES (19, '朋克', 2);
INSERT INTO `songtypes` VALUES (20, '拉丁', 2);
INSERT INTO `songtypes` VALUES (21, '古风', 2);
INSERT INTO `songtypes` VALUES (22, '清晨', 3);
INSERT INTO `songtypes` VALUES (23, '夜晚', 3);
INSERT INTO `songtypes` VALUES (24, '学习', 3);
INSERT INTO `songtypes` VALUES (25, '工作', 3);
INSERT INTO `songtypes` VALUES (27, '午休', 3);
INSERT INTO `songtypes` VALUES (28, '下午茶', 3);
INSERT INTO `songtypes` VALUES (29, '运动', 3);
INSERT INTO `songtypes` VALUES (30, '旅行', 3);
INSERT INTO `songtypes` VALUES (31, '散步', 3);
INSERT INTO `songtypes` VALUES (32, '酒吧', 3);
INSERT INTO `songtypes` VALUES (33, '怀旧', 4);
INSERT INTO `songtypes` VALUES (34, '清新', 4);
INSERT INTO `songtypes` VALUES (35, '浪漫', 4);
INSERT INTO `songtypes` VALUES (36, '伤感', 4);
INSERT INTO `songtypes` VALUES (37, '治愈', 4);
INSERT INTO `songtypes` VALUES (38, '放松', 4);
INSERT INTO `songtypes` VALUES (39, '孤独', 4);
INSERT INTO `songtypes` VALUES (40, '感动', 4);
INSERT INTO `songtypes` VALUES (41, '兴奋', 4);
INSERT INTO `songtypes` VALUES (42, '快乐', 4);
INSERT INTO `songtypes` VALUES (43, '安静', 4);
INSERT INTO `songtypes` VALUES (44, '思念', 4);
INSERT INTO `songtypes` VALUES (45, '综艺', 5);
INSERT INTO `songtypes` VALUES (46, '影视原生', 5);
INSERT INTO `songtypes` VALUES (47, '网络歌曲', 5);
INSERT INTO `songtypes` VALUES (48, 'KTV', 5);
INSERT INTO `songtypes` VALUES (49, '经典', 5);
INSERT INTO `songtypes` VALUES (50, '翻唱', 5);
INSERT INTO `songtypes` VALUES (51, '儿童', 5);
INSERT INTO `songtypes` VALUES (52, '校园', 5);
INSERT INTO `songtypes` VALUES (53, '游戏', 5);
INSERT INTO `songtypes` VALUES (54, '70后', 5);
INSERT INTO `songtypes` VALUES (55, '80后', 5);
INSERT INTO `songtypes` VALUES (56, '90后', 5);
INSERT INTO `songtypes` VALUES (58, '00后', 5);
INSERT INTO `songtypes` VALUES (59, '器乐', 5);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `avatar_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `dynamicCounts` int(11) UNSIGNED NULL DEFAULT 0,
  `likeCounts` int(11) UNSIGNED NULL DEFAULT 0,
  `concernedCounts` int(11) UNSIGNED NULL DEFAULT 0,
  `introduce` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `age` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (12, 'c37csq', '$2a$15$YDNQze9EVSybSANmJGpsJunh5i7LtzUcgLUXTWhhLZRtnfmjy0KNm', 'http://127.0.0.1:7001/public/avatars/2020/12/7/160732886873904.png', 1, 1, 1, '我喜欢听音乐，大家有什么音乐可以推荐给我！', '', 22);
INSERT INTO `users` VALUES (13, 'c47csq', '$2a$15$jU104c5naU.Wj43tGgxnUe6/c05238j35VSv2KWw09tEc0r1gEN7q', 'http://127.0.0.1:7001/public/avatars/2020/12/22/16086370900351.png', 1, 1, 3, '大家好！很高兴认识大家！', 'male', 21);
INSERT INTO `users` VALUES (14, 'wxwwww', '$2a$15$HcmKKY3svXEv8EfracgwHOjfEf8JafB2MzjCVIgLKMeYIRhdv/zVC', 'http://127.0.0.1:7001/public/avatars/2021/3/16/16158831715185.png', 6, 2, 2, '我比较喜欢听歌的！', 'female', 20);

SET FOREIGN_KEY_CHECKS = 1;
