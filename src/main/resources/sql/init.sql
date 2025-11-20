-- 创建数据库
CREATE DATABASE IF NOT EXISTS report_management 
DEFAULT CHARACTER SET utf8mb4 
DEFAULT COLLATE utf8mb4_general_ci;

USE report_management;

-- 用户表
CREATE TABLE IF NOT EXISTS user (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    real_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    status TINYINT DEFAULT 1,
    role ENUM('admin', 'user') DEFAULT 'user',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 报告类型表
CREATE TABLE IF NOT EXISTS report_type (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(50) NOT NULL,
    description TEXT,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 报告表
CREATE TABLE IF NOT EXISTS report (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    content TEXT,
    type_id BIGINT NOT NULL,
    creator_id BIGINT NOT NULL,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (type_id) REFERENCES report_type(id),
    FOREIGN KEY (creator_id) REFERENCES user(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 账户统计表
CREATE TABLE IF NOT EXISTS account_stats (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    login_count INT DEFAULT 0,
    report_count INT DEFAULT 0,
    last_login_time DATETIME,
    FOREIGN KEY (user_id) REFERENCES user(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 初始数据
INSERT INTO user (username, password, real_name, email, phone, role) VALUES 
('admin', 'admin123', '系统管理员', 'admin@example.com', '13800138000', 'admin'),
('user1', 'user1123', '测试用户1', 'user1@example.com', '13900139001', 'user');

INSERT INTO report_type (type_name, description) VALUES 
('销售报表', '日常销售数据统计'),
('库存报表', '商品库存情况统计'),
('财务报表', '财务收支情况统计');

INSERT INTO account_stats (user_id, login_count, report_count, last_login_time) VALUES
(1, 0, 0, NULL),
(2, 0, 0, NULL);

-- 测试数据
INSERT INTO user (username, password, real_name, email, phone, role) VALUES
('user2', 'user2123', '测试用户2', 'user2@example.com', '13900139002', 'user'),
('user3', 'user3123', '测试用户3', 'user3@example.com', '13900139003', 'user'),
('user4', 'user4123', '测试用户4', 'user4@example.com', '13900139004', 'user');

INSERT INTO report_type (type_name, description) VALUES 
('日报', '每日工作报告'),
('周报', '每周工作报告');

INSERT INTO report (title, type_id, content, creator_id) VALUES
('2023年6月销售报表', 1, '6月销售额达到100万', 2),
('2023年Q2库存报表', 2, '第二季度库存周转率提升', 3),
('2023年6月财务报表', 3, '6月收支平衡', 4),
('项目A日报-20230601', 4, '今日完成模块开发', 2),
('项目B周报-202323周', 5, '本周完成需求评审', 3);

UPDATE account_stats SET 
login_count = FLOOR(RAND() * 100),
report_count = FLOOR(RAND() * 10),
last_login_time = DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 30) DAY)
WHERE user_id IN (1, 2);

INSERT INTO account_stats (user_id, login_count, report_count, last_login_time) VALUES
(3, FLOOR(RAND() * 100), FLOOR(RAND() * 10), DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 30) DAY)),
(4, FLOOR(RAND() * 100), FLOOR(RAND() * 10), DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 30) DAY)),
(5, FLOOR(RAND() * 100), FLOOR(RAND() * 10), DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 30) DAY)); 