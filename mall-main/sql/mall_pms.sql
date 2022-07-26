/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2022/4/27 10:14:20                           */
/*==============================================================*/


drop table if exists pms_album;

drop table if exists pms_album_pic;

drop table if exists pms_brand;

drop table if exists pms_comment;

drop table if exists pms_comment_replay;

drop table if exists pms_feight_template;

drop table if exists pms_member_price;

drop index index_product_sn on pms_product;

drop index index_name on pms_product;

drop table if exists pms_product;

drop table if exists pms_product_attribute;

drop table if exists pms_product_attribute_category;

drop table if exists pms_product_attribute_value;

drop table if exists pms_product_category;

drop table if exists pms_product_category_attribute_relation;

drop table if exists pms_product_full_reduction;

drop table if exists pms_product_ladder;

drop table if exists pms_product_operate_log;

drop table if exists pms_product_vertify_record;

drop table if exists pms_sku_stock;

/*==============================================================*/
/* Table: pms_album                                             */
/*==============================================================*/
create table pms_album
(
   id                   bigint not null auto_increment,
   name                 varchar(64),
   cover_pic            varchar(1000),
   pic_count            int,
   sort                 int,
   description          varchar(1000),
   primary key (id)
);

alter table pms_album comment '相册表';

/*==============================================================*/
/* Table: pms_album_pic                                         */
/*==============================================================*/
create table pms_album_pic
(
   id                   bigint not null auto_increment,
   album_id             bigint,
   pic                  varchar(1000),
   primary key (id)
);

alter table pms_album_pic comment '画册图片表';

/*==============================================================*/
/* Table: pms_brand                                             */
/*==============================================================*/
create table pms_brand
(
   id                   bigint not null auto_increment,
   name                 varchar(64) comment '名称',
   first_letter         varchar(8) comment '首字母',
   sort                 int comment '排序',
   factory_status       int(1) comment '是否为品牌制造商：0->不是；1->是',
   show_status          int(1) comment '是否显示',
   product_count        int comment '产品数量',
   product_comment_count int comment '产品评论数量',
   logo                 varchar(255) comment '品牌logo',
   big_pic              varchar(255) comment '专区大图',
   brand_story          text comment '品牌故事',
   primary key (id)
);

alter table pms_brand comment '品牌表';

/*==============================================================*/
/* Table: pms_comment                                           */
/*==============================================================*/
create table pms_comment
(
   id                   bigint not null auto_increment,
   product_id           bigint comment '商品id',
   member_nick_name     varchar(255) comment '会员昵称',
   product_name         varchar(255) comment '商品名称',
   star                 int(3) comment '评价星数：0->5',
   member_ip            varchar(64) comment '评价的ip',
   create_time          datetime comment '创建时间',
   show_status          int(1) comment '是否显示',
   product_attribute    varchar(255) comment '购买时的商品属性',
   collect_couont       int comment '收藏数',
   read_count           int comment '阅读数',
   content              text comment '内容',
   pics                 varchar(1000) comment '上传图片地址，以逗号隔开',
   member_icon          varchar(255) comment '评论用户头像',
   replay_count         int comment '回复数',
   primary key (id)
);

alter table pms_comment comment '商品评价表';

/*==============================================================*/
/* Table: pms_comment_replay                                    */
/*==============================================================*/
create table pms_comment_replay
(
   id                   bigint not null auto_increment,
   comment_id           bigint comment '评论id',
   member_nick_name     varchar(255) comment '会员昵称',
   member_icon          varchar(255) comment '会员头像',
   content              varchar(1000) comment '内容',
   create_time          datetime comment '创建时间',
   type                 int(1) comment '评论人员类型；0->会员；1->管理员',
   primary key (id)
);

alter table pms_comment_replay comment '产品评价回复表';

/*==============================================================*/
/* Table: pms_feight_template                                   */
/*==============================================================*/
create table pms_feight_template
(
   id                   bigint not null auto_increment,
   name                 varchar(64) comment '名称',
   charge_type          int(1) comment '计费类型:0->按重量；1->按件数',
   first_weight         decimal(10,2) comment '首重kg',
   first_fee            decimal(10,2) comment '首费（元）',
   continue_weight      decimal(10,2) comment '续重',
   continme_fee         decimal(10,2) comment '续重费用',
   dest                 varchar(255) comment '目的地（省、市）',
   primary key (id)
);

alter table pms_feight_template comment '运费模版';

/*==============================================================*/
/* Table: pms_member_price                                      */
/*==============================================================*/
create table pms_member_price
(
   id                   bigint not null auto_increment,
   product_id           bigint comment '商品id',
   member_level_id      bigint comment '会员等级id',
   member_price         decimal(10,2) comment '会员价格',
   member_level_name    varchar(100) comment '会员等级名称',
   primary key (id)
);

alter table pms_member_price comment '商品会员价格表';

/*==============================================================*/
/* Table: pms_product                                           */
/*==============================================================*/
create table pms_product
(
   id                   bigint not null auto_increment,
   brand_id             bigint comment '品牌id',
   product_category_id  bigint comment '品牌分类id',
   feight_template_id   bigint comment '运费模版id',
   product_attribute_category_id bigint comment '品牌属性分类id',
   name                 varchar(64) not null comment '商品名称',
   pic                  varchar(255) comment '图片',
   product_sn           varchar(64) not null comment '货号',
   delete_status        int(1) comment '删除状态：0->未删除；1->已删除',
   publish_status       int(1) comment '上架状态：0->下架；1->上架',
   new_status           int(1) comment '新品状态:0->不是新品；1->新品',
   recommand_status     int(1) comment '推荐状态；0->不推荐；1->推荐',
   verify_status        int(1) comment '审核状态：0->未审核；1->审核通过',
   sort                 int comment '排序',
   sale                 int comment '销量',
   price                decimal(10,2) comment '价格',
   promotion_price      decimal(10,2) comment '促销价格',
   gift_growth          int default 0 comment '赠送的成长值',
   gift_point           int default 0 comment '赠送的积分',
   use_point_limit      int comment '限制使用的积分数',
   sub_title            varchar(255) comment '副标题',
   description          text comment '商品描述',
   original_price       decimal(10,2) comment '市场价',
   stock                int comment '库存',
   low_stock            int comment '库存预警值',
   unit                 varchar(16) comment '单位',
   weight               decimal(10,2) comment '商品重量，默认为克',
   preview_status       int(1) comment '是否为预告商品：0->不是；1->是',
   service_ids          varchar(64) comment '以逗号分割的产品服务：1->无忧退货；2->快速退款；3->免费包邮',
   keywords             varchar(255) comment '关键字',
   note                 varchar(255) comment '备注',
   album_pics           varchar(255) comment '画册图片，连产品图片限制为5张，以逗号分割',
   detail_title         varchar(255) comment '详情标题',
   detail_desc          text comment '详情描述',
   detail_html          text comment '产品详情网页内容',
   detail_mobile_html   text comment '移动端网页详情',
   promotion_start_time datetime comment '促销开始时间',
   promotion_end_time   datetime comment '促销结束时间',
   promotion_per_limit  int comment '活动限购数量',
   promotion_type       int(1) comment '促销类型：0->没有促销使用原价;1->使用促销价；2->使用会员价；3->使用阶梯价格；4->使用满减价格；5->限时购',
   product_category_name varchar(255) comment '产品分类名称',
   brand_name           varchar(255) comment '品牌名称',
   primary key (id)
);

alter table pms_product comment '商品信息';

/*==============================================================*/
/* Index: index_name                                            */
/*==============================================================*/
create index index_name on pms_product
(
   name
);

/*==============================================================*/
/* Index: index_product_sn                                      */
/*==============================================================*/
create unique index index_product_sn on pms_product
(
   product_sn
);

/*==============================================================*/
/* Table: pms_product_attribute                                 */
/*==============================================================*/
create table pms_product_attribute
(
   id                   bigint not null auto_increment,
   product_attribute_category_id bigint,
   name                 varchar(64),
   select_type          int(1) comment '属性选择类型：0->唯一；1->单选；2->多选；对应属性和参数意义不同；',
   input_type           int(1) comment '属性录入方式：0->手工录入；1->从列表中选取',
   input_list           varchar(255) comment '可选值列表，以逗号隔开',
   sort                 int comment '排序字段：最高的可以单独上传图片',
   filter_type          int(1) comment '分类筛选样式：1->普通；1->颜色',
   search_type          int(1) comment '检索类型；0->不需要进行检索；1->关键字检索；2->范围检索',
   related_status       int(1) comment '相同属性产品是否关联；0->不关联；1->关联',
   hand_add_status      int(1) comment '是否支持手动新增；0->不支持；1->支持',
   type                 int(1) comment '属性的类型；0->规格；1->参数',
   primary key (id)
);

alter table pms_product_attribute comment '商品属性参数表';

/*==============================================================*/
/* Table: pms_product_attribute_category                        */
/*==============================================================*/
create table pms_product_attribute_category
(
   id                   bigint not null auto_increment,
   name                 varchar(64),
   attribute_count      int comment '属性数量',
   param_count          int comment '参数数量',
   primary key (id)
);

alter table pms_product_attribute_category comment '产品属性分类表';

/*==============================================================*/
/* Table: pms_product_attribute_value                           */
/*==============================================================*/
create table pms_product_attribute_value
(
   id                   bigint not null auto_increment,
   product_id           bigint,
   product_attribute_id bigint,
   value                varchar(64) comment '手动添加规格或参数的值，参数单值，规格有多个时以逗号隔开',
   primary key (id)
);

alter table pms_product_attribute_value comment '存储产品参数信息的表';

/*==============================================================*/
/* Table: pms_product_category                                  */
/*==============================================================*/
create table pms_product_category
(
   id                   bigint not null auto_increment,
   parent_id            bigint comment '上级分类的编号：0表示一级分类',
   name                 varchar(64) comment '名称',
   level                int(1) comment '分类级别：0->1级；1->2级',
   product_count        int comment '商品数量',
   product_unit         varchar(64) comment '商品单位',
   nav_status           int(1) comment '是否显示在导航栏：0->不显示；1->显示',
   show_status          int(1) comment '显示状态：0->不显示；1->显示',
   sort                 int comment '排序',
   icon                 varchar(255) comment '图标',
   keywords             varchar(255) comment '关键字',
   description          text comment '描述',
   primary key (id)
);

alter table pms_product_category comment '产品分类';

/*==============================================================*/
/* Table: pms_product_category_attribute_relation               */
/*==============================================================*/
create table pms_product_category_attribute_relation
(
   id                   bigint not null auto_increment,
   product_category_id  bigint,
   product_attribute_id bigint,
   primary key (id)
);

alter table pms_product_category_attribute_relation comment '产品的分类和属性的关系表，用于设置分类筛选条件（只支持二级分类）';

/*==============================================================*/
/* Table: pms_product_full_reduction                            */
/*==============================================================*/
create table pms_product_full_reduction
(
   id                   bigint not null auto_increment,
   product_id           bigint comment '商品id',
   full_price           decimal(10,2) comment '商品满足金额',
   reduce_price         decimal(10,2) comment '商品减少金额',
   primary key (id)
);

alter table pms_product_full_reduction comment '商品满减表(只针对同商品)';

/*==============================================================*/
/* Table: pms_product_ladder                                    */
/*==============================================================*/
create table pms_product_ladder
(
   id                   bigint not null auto_increment,
   product_id           bigint comment '商品id',
   count                int comment '满足的商品数量',
   discount             decimal(10,2) comment '折扣',
   price                decimal(10,2) comment '折后价格',
   primary key (id)
);

alter table pms_product_ladder comment '商品阶梯价格表(只针对同商品)';

/*==============================================================*/
/* Table: pms_product_operate_log                               */
/*==============================================================*/
create table pms_product_operate_log
(
   id                   bigint not null auto_increment,
   product_id           bigint comment '商品id',
   price_old            decimal(10,2) comment '改变前价格',
   price_new            decimal(10,2) comment '改变后价格',
   sale_price_old       decimal(10,2) comment '改变前优惠价',
   sale_price_new       decimal(10,2) comment '改变后优惠价',
   gift_point_old       int comment '改变前积分',
   gift_point_new       int comment '改变后积分',
   use_point_limit_old  int comment '改变前积分使用限制',
   use_point_limit_new  int comment '改变后积分使用限制',
   operate_man          varchar(64) comment '操作人',
   create_time          datetime comment '创建时间',
   primary key (id)
);

/*==============================================================*/
/* Table: pms_product_vertify_record                            */
/*==============================================================*/
create table pms_product_vertify_record
(
   id                   bigint not null auto_increment,
   product_id           bigint comment '商品id',
   create_time          datetime comment '创建时间',
   vertify_man          varchar(64) comment '审核人',
   status               int(1) comment '审核后的状态：0->未通过；2->已通过',
   detail               varchar(255) comment '反馈详情',
   primary key (id)
);

alter table pms_product_vertify_record comment '商品审核记录';

/*==============================================================*/
/* Table: pms_sku_stock                                         */
/*==============================================================*/
create table pms_sku_stock
(
   id                   bigint not null auto_increment,
   product_id           bigint comment '商品id',
   sku_code             varchar(64) not null comment 'sku编码',
   price                decimal(10,2) comment '价格',
   stock                int default 0 comment '库存',
   low_stock            int comment '预警库存',
   sp1                  varchar(64) comment '规格属性1',
   sp2                  varchar(64) comment '规格属性2',
   sp3                  varchar(64) comment '规格属性3',
   pic                  varchar(255) comment '展示图片',
   sale                 int comment '销量',
   promotion_price      decimal(10,2) comment '单品促销价格',
   lock_stock           int default 0 comment '锁定库存',
   primary key (id)
);

alter table pms_sku_stock comment '商品的sku';

alter table pms_album_pic add constraint FK_Reference_25 foreign key (album_id)
      references pms_album (id) on delete restrict on update restrict;

alter table pms_comment add constraint FK_Reference_23 foreign key (product_id)
      references pms_product (id) on delete restrict on update restrict;

alter table pms_comment_replay add constraint FK_Reference_24 foreign key (comment_id)
      references pms_comment (id) on delete restrict on update restrict;

alter table pms_member_price add constraint FK_Reference_9 foreign key (product_id)
      references pms_product (id) on delete restrict on update restrict;

alter table pms_product add constraint FK_Reference_1 foreign key (brand_id)
      references pms_brand (id) on delete restrict on update restrict;

alter table pms_product add constraint FK_Reference_13 foreign key (product_attribute_category_id)
      references pms_product_attribute_category (id) on delete restrict on update restrict;

alter table pms_product add constraint FK_Reference_5 foreign key (product_category_id)
      references pms_product_category (id) on delete restrict on update restrict;

alter table pms_product add constraint FK_Reference_6 foreign key (feight_template_id)
      references pms_feight_template (id) on delete restrict on update restrict;

alter table pms_product_attribute add constraint FK_Reference_12 foreign key (product_attribute_category_id)
      references pms_product_attribute_category (id) on delete restrict on update restrict;

alter table pms_product_attribute_value add constraint FK_Reference_14 foreign key (product_id)
      references pms_product (id) on delete restrict on update restrict;

alter table pms_product_attribute_value add constraint FK_Reference_15 foreign key (product_attribute_id)
      references pms_product_attribute (id) on delete restrict on update restrict;

alter table pms_product_category add constraint FK_Reference_20 foreign key (parent_id)
      references pms_product_category (id) on delete restrict on update restrict;

alter table pms_product_category_attribute_relation add constraint FK_Reference_21 foreign key (product_category_id)
      references pms_product_category (id) on delete restrict on update restrict;

alter table pms_product_category_attribute_relation add constraint FK_Reference_22 foreign key (product_attribute_id)
      references pms_product_attribute (id) on delete restrict on update restrict;

alter table pms_product_full_reduction add constraint FK_Reference_11 foreign key (product_id)
      references pms_product (id) on delete restrict on update restrict;

alter table pms_product_ladder add constraint FK_Reference_10 foreign key (product_id)
      references pms_product (id) on delete restrict on update restrict;

alter table pms_product_operate_log add constraint FK_Reference_4 foreign key (product_id)
      references pms_product (id) on delete restrict on update restrict;

alter table pms_product_vertify_record add constraint FK_Reference_3 foreign key (product_id)
      references pms_product (id) on delete restrict on update restrict;

alter table pms_sku_stock add constraint FK_Reference_2 foreign key (product_id)
      references pms_product (id) on delete restrict on update restrict;

