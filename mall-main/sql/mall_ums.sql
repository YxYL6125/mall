/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2022/4/27 9:07:19                            */
/*==============================================================*/


drop table if exists ums_admin;

drop table if exists ums_admin_login_log;

drop table if exists ums_admin_permission_relation;

drop table if exists ums_admin_role_relation;

drop table if exists ums_growth_change_history;

drop table if exists ums_integration_change_history;

drop table if exists ums_integration_consume_setting;

drop table if exists ums_member;

drop table if exists ums_member_level;

drop table if exists ums_member_login_log;

drop table if exists ums_member_member_tag_relation;

drop table if exists ums_member_product_category_relation;

drop table if exists ums_member_receive_address;

drop table if exists ums_member_rule_setting;

drop table if exists ums_member_statistics_info;

drop table if exists ums_member_tag;

drop table if exists ums_member_task;

drop table if exists ums_permission;

drop table if exists ums_role;

drop table if exists ums_role_permission_relation;

/*==============================================================*/
/* Table: ums_admin                                             */
/*==============================================================*/
create table ums_admin
(
   id                   bigint not null auto_increment,
   username             varchar(64) comment '用户名',
   password             varchar(64) comment '密码',
   icon                 varchar(500) comment '头像',
   email                varchar(100) comment '邮箱',
   nick_name            varchar(200) comment '昵称',
   note                 varchar(500) comment '备注信息',
   create_time          datetime comment '创建时间',
   login_time           datetime comment '最后登录时间',
   status               int(1) default 1 comment '帐号启用状态：0->禁用；1->启用',
   primary key (id)
);

alter table ums_admin comment '后台用户表';

/*==============================================================*/
/* Table: ums_admin_login_log                                   */
/*==============================================================*/
create table ums_admin_login_log
(
   id                   bigint not null auto_increment,
   admin_id             bigint,
   create_time          datetime,
   ip                   varchar(64),
   address              varchar(100),
   user_agent           varchar(100) comment '浏览器登录类型',
   primary key (id)
);

alter table ums_admin_login_log comment '后台用户登录日志表';

/*==============================================================*/
/* Table: ums_admin_permission_relation                         */
/*==============================================================*/
create table ums_admin_permission_relation
(
   id                   bigint not null auto_increment,
   admin_id             bigint,
   permission_id        bigint,
   type                 int(1),
   primary key (id)
);

alter table ums_admin_permission_relation comment '后台用户和权限关系表(除角色中定义的权限以外的加减权限)';

/*==============================================================*/
/* Table: ums_admin_role_relation                               */
/*==============================================================*/
create table ums_admin_role_relation
(
   id                   bigint not null auto_increment,
   admin_id             bigint,
   role_id              bigint,
   primary key (id)
);

alter table ums_admin_role_relation comment '后台用户和角色关系表';

/*==============================================================*/
/* Table: ums_growth_change_history                             */
/*==============================================================*/
create table ums_growth_change_history
(
   id                   bigint not null auto_increment,
   member_id            bigint,
   create_time          datetime,
   change_type          int(1) comment '改变类型：0->增加；1->减少',
   change_count         int comment '积分改变数量',
   operate_man          varchar(100) comment '操作人员',
   operate_note         varchar(200) comment '操作备注',
   source_type          int(1) comment '积分来源：0->购物；1->管理员修改',
   primary key (id)
);

alter table ums_growth_change_history comment '成长值变化历史记录表';

/*==============================================================*/
/* Table: ums_integration_change_history                        */
/*==============================================================*/
create table ums_integration_change_history
(
   id                   bigint not null auto_increment,
   member_id            bigint,
   create_time          datetime,
   change_type          int(1) comment '改变类型：0->增加；1->减少',
   change_count         int comment '积分改变数量',
   operate_man          varchar(100) comment '操作人员',
   operate_note         varchar(200) comment '操作备注',
   source_type          int(1) comment '积分来源：0->购物；1->管理员修改',
   primary key (id)
);

alter table ums_integration_change_history comment '积分变化历史记录表';

/*==============================================================*/
/* Table: ums_integration_consume_setting                       */
/*==============================================================*/
create table ums_integration_consume_setting
(
   id                   bigint not null auto_increment,
   deduction_per_amount int comment '每一元需要抵扣的积分数量',
   max_percent_per_order int comment '每笔订单最高抵用百分比',
   use_unit             int comment '每次使用积分最小单位100',
   coupon_status        int(1) comment '是否可以和优惠券同用；0->不可以；1->可以',
   primary key (id)
);

alter table ums_integration_consume_setting comment '积分消费设置';

/*==============================================================*/
/* Table: ums_member                                            */
/*==============================================================*/
create table ums_member
(
   id                   bigint not null auto_increment,
   member_level_id      bigint,
   username             varchar(64) comment '用户名',
   password             varchar(64) comment '密码',
   nickname             varchar(64) comment '昵称',
   phone                varchar(64) comment '手机号码',
   status               int(1) comment '帐号启用状态:0->禁用；1->启用',
   create_time          datetime comment '注册时间',
   icon                 varchar(500) comment '头像',
   gender               int(1) comment '性别：0->未知；1->男；2->女',
   birthday             date comment '生日',
   city                 varchar(64) comment '所做城市',
   job                  varchar(100) comment '职业',
   personalized_signature varchar(200) comment '个性签名',
   source_type          int(1) comment '用户来源',
   integration          int comment '积分',
   growth               int comment '成长值',
   luckey_count         int comment '剩余抽奖次数',
   history_integration  int comment '历史积分数量',
   primary key (id)
);

alter table ums_member comment '会员表';

/*==============================================================*/
/* Table: ums_member_level                                      */
/*==============================================================*/
create table ums_member_level
(
   id                   bigint not null auto_increment,
   name                 varchar(100),
   growth_point         int,
   default_status       int(1) comment '是否为默认等级：0->不是；1->是',
   free_freight_point   decimal(10,2) comment '免运费标准',
   comment_growth_point int comment '每次评价获取的成长值',
   priviledge_free_freight int(1) comment '是否有免邮特权',
   priviledge_sign_in   int(1) comment '是否有签到特权',
   priviledge_comment   int(1) comment '是否有评论获奖励特权',
   priviledge_promotion int(1) comment '是否有专享活动特权',
   priviledge_member_price int(1) comment '是否有会员价格特权',
   priviledge_birthday  int(1) comment '是否有生日特权',
   note                 varchar(200),
   primary key (id)
);

alter table ums_member_level comment '会员等级表';

/*==============================================================*/
/* Table: ums_member_login_log                                  */
/*==============================================================*/
create table ums_member_login_log
(
   id                   bigint not null auto_increment,
   member_id            bigint,
   create_time          datetime,
   ip                   varchar(64),
   city                 varchar(64),
   login_type           int(1) comment '登录类型：0->PC；1->android;2->ios;3->小程序',
   province             varchar(64),
   primary key (id)
);

alter table ums_member_login_log comment '会员登录记录';

/*==============================================================*/
/* Table: ums_member_member_tag_relation                        */
/*==============================================================*/
create table ums_member_member_tag_relation
(
   id                   bigint not null auto_increment,
   member_id            bigint,
   tag_id               bigint,
   primary key (id)
);

alter table ums_member_member_tag_relation comment '用户和标签关系表';

/*==============================================================*/
/* Table: ums_member_product_category_relation                  */
/*==============================================================*/
create table ums_member_product_category_relation
(
   id                   bigint not null auto_increment,
   member_id            bigint,
   product_category_id  bigint,
   primary key (id)
);

alter table ums_member_product_category_relation comment '会员与产品分类关系表（用户喜欢的分类）';

/*==============================================================*/
/* Table: ums_member_receive_address                            */
/*==============================================================*/
create table ums_member_receive_address
(
   id                   bigint not null auto_increment,
   member_id            bigint,
   name                 varchar(100) comment '收货人名称',
   phone_number         varchar(64),
   default_status       int(1) comment '是否为默认',
   post_code            varchar(100) comment '邮政编码',
   province             varchar(100) comment '省份/直辖市',
   city                 varchar(100) comment '城市',
   region               varchar(100) comment '区',
   detail_address       varchar(128) comment '详细地址(街道)',
   primary key (id)
);

alter table ums_member_receive_address comment '会员收货地址表';

/*==============================================================*/
/* Table: ums_member_rule_setting                               */
/*==============================================================*/
create table ums_member_rule_setting
(
   id                   bigint not null auto_increment,
   continue_sign_day    int comment '连续签到天数',
   continue_sign_point  int comment '连续签到赠送数量',
   consume_per_point    decimal(10,2) comment '每消费多少元获取1个点',
   low_order_amount     decimal(10,2) comment '最低获取点数的订单金额',
   max_point_per_order  int comment '每笔订单最高获取点数',
   type                 int(1) comment '类型：0->积分规则；1->成长值规则',
   primary key (id)
);

alter table ums_member_rule_setting comment '会员积分成长规则表';

/*==============================================================*/
/* Table: ums_member_statistics_info                            */
/*==============================================================*/
create table ums_member_statistics_info
(
   id                   bigint not null auto_increment,
   member_id            bigint,
   consume_amount       decimal(10,2) comment '累计消费金额',
   order_count          int comment '订单数量',
   coupon_count         int comment '优惠券数量',
   comment_count        int comment '评价数',
   return_order_count   int comment '退货数量',
   login_count          int comment '登录次数',
   attend_count         int comment '关注数量',
   fans_count           int comment '粉丝数量',
   collect_product_count int,
   collect_subject_count int,
   collect_topic_count  int,
   collect_comment_count int,
   invite_friend_count  int,
   recent_order_time    datetime comment '最后一次下订单时间',
   primary key (id)
);

alter table ums_member_statistics_info comment '会员统计信息';

/*==============================================================*/
/* Table: ums_member_tag                                        */
/*==============================================================*/
create table ums_member_tag
(
   id                   bigint not null auto_increment,
   name                 varchar(100),
   finish_order_count   int comment '自动打标签完成订单数量',
   finish_order_amount  decimal(10,2) comment '自动打标签完成订单金额',
   primary key (id)
);

alter table ums_member_tag comment '用户标签表';

/*==============================================================*/
/* Table: ums_member_task                                       */
/*==============================================================*/
create table ums_member_task
(
   id                   bigint not null auto_increment,
   name                 varchar(100),
   growth               int comment '赠送成长值',
   intergration         int comment '赠送积分',
   type                 int(1) comment '任务类型：0->新手任务；1->日常任务',
   primary key (id)
);

alter table ums_member_task comment '会员任务表';

/*==============================================================*/
/* Table: ums_permission                                        */
/*==============================================================*/
create table ums_permission
(
   id                   bigint not null auto_increment,
   pid                  bigint comment '父级权限id',
   name                 varchar(100) comment '名称',
   value                varchar(200) comment '权限值',
   icon                 varchar(500) comment '图标',
   type                 int(1) comment '权限类型：0->目录；1->菜单；2->按钮（接口绑定权限）',
   uri                  varchar(200) comment '前端资源路径',
   status               int(1) comment '启用状态；0->禁用；1->启用',
   create_time          datetime comment '创建时间',
   sort                 int comment '排序',
   primary key (id)
);

alter table ums_permission comment '后台用户权限表';

/*==============================================================*/
/* Table: ums_role                                              */
/*==============================================================*/
create table ums_role
(
   id                   bigint not null auto_increment,
   name                 varchar(100) comment '名称',
   description          varchar(500) comment '描述',
   admin_count          int comment '后台用户数量',
   create_time          datetime comment '创建时间',
   status               int(1) default 1 comment '启用状态：0->禁用；1->启用',
   sort                 int default 0,
   primary key (id)
);

alter table ums_role comment '后台用户角色表';

/*==============================================================*/
/* Table: ums_role_permission_relation                          */
/*==============================================================*/
create table ums_role_permission_relation
(
   id                   bigint not null auto_increment,
   role_id              bigint,
   permission_id        bigint,
   primary key (id)
);

alter table ums_role_permission_relation comment '后台用户角色和权限关系表';

alter table ums_admin_login_log add constraint FK_Reference_46 foreign key (admin_id)
      references ums_admin (id) on delete restrict on update restrict;

alter table ums_admin_permission_relation add constraint FK_Reference_73 foreign key (admin_id)
      references ums_admin (id) on delete restrict on update restrict;

alter table ums_admin_permission_relation add constraint FK_Reference_74 foreign key (permission_id)
      references ums_permission (id) on delete restrict on update restrict;

alter table ums_admin_role_relation add constraint FK_Reference_69 foreign key (admin_id)
      references ums_admin (id) on delete restrict on update restrict;

alter table ums_admin_role_relation add constraint FK_Reference_70 foreign key (role_id)
      references ums_role (id) on delete restrict on update restrict;

alter table ums_growth_change_history add constraint FK_Reference_56 foreign key (member_id)
      references ums_member (id) on delete restrict on update restrict;

alter table ums_integration_change_history add constraint FK_Reference_55 foreign key (member_id)
      references ums_member (id) on delete restrict on update restrict;

alter table ums_member add constraint FK_Reference_47 foreign key (member_level_id)
      references ums_member_level (id) on delete restrict on update restrict;

alter table ums_member_login_log add constraint FK_Reference_52 foreign key (member_id)
      references ums_member (id) on delete restrict on update restrict;

alter table ums_member_member_tag_relation add constraint FK_Reference_53 foreign key (member_id)
      references ums_member (id) on delete restrict on update restrict;

alter table ums_member_member_tag_relation add constraint FK_Reference_54 foreign key (tag_id)
      references ums_member_tag (id) on delete restrict on update restrict;

alter table ums_member_product_category_relation add constraint FK_Reference_48 foreign key (member_id)
      references ums_member (id) on delete restrict on update restrict;

alter table ums_member_receive_address add constraint FK_Reference_51 foreign key (member_id)
      references ums_member (id) on delete restrict on update restrict;

alter table ums_member_statistics_info add constraint FK_Reference_50 foreign key (member_id)
      references ums_member (id) on delete restrict on update restrict;

alter table ums_permission add constraint FK_Reference_68 foreign key (pid)
      references ums_permission (id) on delete restrict on update restrict;

alter table ums_role_permission_relation add constraint FK_Reference_71 foreign key (role_id)
      references ums_role (id) on delete restrict on update restrict;

alter table ums_role_permission_relation add constraint FK_Reference_72 foreign key (permission_id)
      references ums_permission (id) on delete restrict on update restrict;

