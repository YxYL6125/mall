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

alter table pms_album comment '����';

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

alter table pms_album_pic comment '����ͼƬ��';

/*==============================================================*/
/* Table: pms_brand                                             */
/*==============================================================*/
create table pms_brand
(
   id                   bigint not null auto_increment,
   name                 varchar(64) comment '����',
   first_letter         varchar(8) comment '����ĸ',
   sort                 int comment '����',
   factory_status       int(1) comment '�Ƿ�ΪƷ�������̣�0->���ǣ�1->��',
   show_status          int(1) comment '�Ƿ���ʾ',
   product_count        int comment '��Ʒ����',
   product_comment_count int comment '��Ʒ��������',
   logo                 varchar(255) comment 'Ʒ��logo',
   big_pic              varchar(255) comment 'ר����ͼ',
   brand_story          text comment 'Ʒ�ƹ���',
   primary key (id)
);

alter table pms_brand comment 'Ʒ�Ʊ�';

/*==============================================================*/
/* Table: pms_comment                                           */
/*==============================================================*/
create table pms_comment
(
   id                   bigint not null auto_increment,
   product_id           bigint comment '��Ʒid',
   member_nick_name     varchar(255) comment '��Ա�ǳ�',
   product_name         varchar(255) comment '��Ʒ����',
   star                 int(3) comment '����������0->5',
   member_ip            varchar(64) comment '���۵�ip',
   create_time          datetime comment '����ʱ��',
   show_status          int(1) comment '�Ƿ���ʾ',
   product_attribute    varchar(255) comment '����ʱ����Ʒ����',
   collect_couont       int comment '�ղ���',
   read_count           int comment '�Ķ���',
   content              text comment '����',
   pics                 varchar(1000) comment '�ϴ�ͼƬ��ַ���Զ��Ÿ���',
   member_icon          varchar(255) comment '�����û�ͷ��',
   replay_count         int comment '�ظ���',
   primary key (id)
);

alter table pms_comment comment '��Ʒ���۱�';

/*==============================================================*/
/* Table: pms_comment_replay                                    */
/*==============================================================*/
create table pms_comment_replay
(
   id                   bigint not null auto_increment,
   comment_id           bigint comment '����id',
   member_nick_name     varchar(255) comment '��Ա�ǳ�',
   member_icon          varchar(255) comment '��Աͷ��',
   content              varchar(1000) comment '����',
   create_time          datetime comment '����ʱ��',
   type                 int(1) comment '������Ա���ͣ�0->��Ա��1->����Ա',
   primary key (id)
);

alter table pms_comment_replay comment '��Ʒ���ۻظ���';

/*==============================================================*/
/* Table: pms_feight_template                                   */
/*==============================================================*/
create table pms_feight_template
(
   id                   bigint not null auto_increment,
   name                 varchar(64) comment '����',
   charge_type          int(1) comment '�Ʒ�����:0->��������1->������',
   first_weight         decimal(10,2) comment '����kg',
   first_fee            decimal(10,2) comment '�׷ѣ�Ԫ��',
   continue_weight      decimal(10,2) comment '����',
   continme_fee         decimal(10,2) comment '���ط���',
   dest                 varchar(255) comment 'Ŀ�ĵأ�ʡ���У�',
   primary key (id)
);

alter table pms_feight_template comment '�˷�ģ��';

/*==============================================================*/
/* Table: pms_member_price                                      */
/*==============================================================*/
create table pms_member_price
(
   id                   bigint not null auto_increment,
   product_id           bigint comment '��Ʒid',
   member_level_id      bigint comment '��Ա�ȼ�id',
   member_price         decimal(10,2) comment '��Ա�۸�',
   member_level_name    varchar(100) comment '��Ա�ȼ�����',
   primary key (id)
);

alter table pms_member_price comment '��Ʒ��Ա�۸��';

/*==============================================================*/
/* Table: pms_product                                           */
/*==============================================================*/
create table pms_product
(
   id                   bigint not null auto_increment,
   brand_id             bigint comment 'Ʒ��id',
   product_category_id  bigint comment 'Ʒ�Ʒ���id',
   feight_template_id   bigint comment '�˷�ģ��id',
   product_attribute_category_id bigint comment 'Ʒ�����Է���id',
   name                 varchar(64) not null comment '��Ʒ����',
   pic                  varchar(255) comment 'ͼƬ',
   product_sn           varchar(64) not null comment '����',
   delete_status        int(1) comment 'ɾ��״̬��0->δɾ����1->��ɾ��',
   publish_status       int(1) comment '�ϼ�״̬��0->�¼ܣ�1->�ϼ�',
   new_status           int(1) comment '��Ʒ״̬:0->������Ʒ��1->��Ʒ',
   recommand_status     int(1) comment '�Ƽ�״̬��0->���Ƽ���1->�Ƽ�',
   verify_status        int(1) comment '���״̬��0->δ��ˣ�1->���ͨ��',
   sort                 int comment '����',
   sale                 int comment '����',
   price                decimal(10,2) comment '�۸�',
   promotion_price      decimal(10,2) comment '�����۸�',
   gift_growth          int default 0 comment '���͵ĳɳ�ֵ',
   gift_point           int default 0 comment '���͵Ļ���',
   use_point_limit      int comment '����ʹ�õĻ�����',
   sub_title            varchar(255) comment '������',
   description          text comment '��Ʒ����',
   original_price       decimal(10,2) comment '�г���',
   stock                int comment '���',
   low_stock            int comment '���Ԥ��ֵ',
   unit                 varchar(16) comment '��λ',
   weight               decimal(10,2) comment '��Ʒ������Ĭ��Ϊ��',
   preview_status       int(1) comment '�Ƿ�ΪԤ����Ʒ��0->���ǣ�1->��',
   service_ids          varchar(64) comment '�Զ��ŷָ�Ĳ�Ʒ����1->�����˻���2->�����˿3->��Ѱ���',
   keywords             varchar(255) comment '�ؼ���',
   note                 varchar(255) comment '��ע',
   album_pics           varchar(255) comment '����ͼƬ������ƷͼƬ����Ϊ5�ţ��Զ��ŷָ�',
   detail_title         varchar(255) comment '�������',
   detail_desc          text comment '��������',
   detail_html          text comment '��Ʒ������ҳ����',
   detail_mobile_html   text comment '�ƶ�����ҳ����',
   promotion_start_time datetime comment '������ʼʱ��',
   promotion_end_time   datetime comment '��������ʱ��',
   promotion_per_limit  int comment '��޹�����',
   promotion_type       int(1) comment '�������ͣ�0->û�д���ʹ��ԭ��;1->ʹ�ô����ۣ�2->ʹ�û�Ա�ۣ�3->ʹ�ý��ݼ۸�4->ʹ�������۸�5->��ʱ��',
   product_category_name varchar(255) comment '��Ʒ��������',
   brand_name           varchar(255) comment 'Ʒ������',
   primary key (id)
);

alter table pms_product comment '��Ʒ��Ϣ';

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
   select_type          int(1) comment '����ѡ�����ͣ�0->Ψһ��1->��ѡ��2->��ѡ����Ӧ���ԺͲ������岻ͬ��',
   input_type           int(1) comment '����¼�뷽ʽ��0->�ֹ�¼�룻1->���б���ѡȡ',
   input_list           varchar(255) comment '��ѡֵ�б��Զ��Ÿ���',
   sort                 int comment '�����ֶΣ���ߵĿ��Ե����ϴ�ͼƬ',
   filter_type          int(1) comment '����ɸѡ��ʽ��1->��ͨ��1->��ɫ',
   search_type          int(1) comment '�������ͣ�0->����Ҫ���м�����1->�ؼ��ּ�����2->��Χ����',
   related_status       int(1) comment '��ͬ���Բ�Ʒ�Ƿ������0->��������1->����',
   hand_add_status      int(1) comment '�Ƿ�֧���ֶ�������0->��֧�֣�1->֧��',
   type                 int(1) comment '���Ե����ͣ�0->���1->����',
   primary key (id)
);

alter table pms_product_attribute comment '��Ʒ���Բ�����';

/*==============================================================*/
/* Table: pms_product_attribute_category                        */
/*==============================================================*/
create table pms_product_attribute_category
(
   id                   bigint not null auto_increment,
   name                 varchar(64),
   attribute_count      int comment '��������',
   param_count          int comment '��������',
   primary key (id)
);

alter table pms_product_attribute_category comment '��Ʒ���Է����';

/*==============================================================*/
/* Table: pms_product_attribute_value                           */
/*==============================================================*/
create table pms_product_attribute_value
(
   id                   bigint not null auto_increment,
   product_id           bigint,
   product_attribute_id bigint,
   value                varchar(64) comment '�ֶ���ӹ��������ֵ��������ֵ������ж��ʱ�Զ��Ÿ���',
   primary key (id)
);

alter table pms_product_attribute_value comment '�洢��Ʒ������Ϣ�ı�';

/*==============================================================*/
/* Table: pms_product_category                                  */
/*==============================================================*/
create table pms_product_category
(
   id                   bigint not null auto_increment,
   parent_id            bigint comment '�ϼ�����ı�ţ�0��ʾһ������',
   name                 varchar(64) comment '����',
   level                int(1) comment '���༶��0->1����1->2��',
   product_count        int comment '��Ʒ����',
   product_unit         varchar(64) comment '��Ʒ��λ',
   nav_status           int(1) comment '�Ƿ���ʾ�ڵ�������0->����ʾ��1->��ʾ',
   show_status          int(1) comment '��ʾ״̬��0->����ʾ��1->��ʾ',
   sort                 int comment '����',
   icon                 varchar(255) comment 'ͼ��',
   keywords             varchar(255) comment '�ؼ���',
   description          text comment '����',
   primary key (id)
);

alter table pms_product_category comment '��Ʒ����';

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

alter table pms_product_category_attribute_relation comment '��Ʒ�ķ�������ԵĹ�ϵ���������÷���ɸѡ������ֻ֧�ֶ������ࣩ';

/*==============================================================*/
/* Table: pms_product_full_reduction                            */
/*==============================================================*/
create table pms_product_full_reduction
(
   id                   bigint not null auto_increment,
   product_id           bigint comment '��Ʒid',
   full_price           decimal(10,2) comment '��Ʒ������',
   reduce_price         decimal(10,2) comment '��Ʒ���ٽ��',
   primary key (id)
);

alter table pms_product_full_reduction comment '��Ʒ������(ֻ���ͬ��Ʒ)';

/*==============================================================*/
/* Table: pms_product_ladder                                    */
/*==============================================================*/
create table pms_product_ladder
(
   id                   bigint not null auto_increment,
   product_id           bigint comment '��Ʒid',
   count                int comment '�������Ʒ����',
   discount             decimal(10,2) comment '�ۿ�',
   price                decimal(10,2) comment '�ۺ�۸�',
   primary key (id)
);

alter table pms_product_ladder comment '��Ʒ���ݼ۸��(ֻ���ͬ��Ʒ)';

/*==============================================================*/
/* Table: pms_product_operate_log                               */
/*==============================================================*/
create table pms_product_operate_log
(
   id                   bigint not null auto_increment,
   product_id           bigint comment '��Ʒid',
   price_old            decimal(10,2) comment '�ı�ǰ�۸�',
   price_new            decimal(10,2) comment '�ı��۸�',
   sale_price_old       decimal(10,2) comment '�ı�ǰ�Żݼ�',
   sale_price_new       decimal(10,2) comment '�ı���Żݼ�',
   gift_point_old       int comment '�ı�ǰ����',
   gift_point_new       int comment '�ı�����',
   use_point_limit_old  int comment '�ı�ǰ����ʹ������',
   use_point_limit_new  int comment '�ı�����ʹ������',
   operate_man          varchar(64) comment '������',
   create_time          datetime comment '����ʱ��',
   primary key (id)
);

/*==============================================================*/
/* Table: pms_product_vertify_record                            */
/*==============================================================*/
create table pms_product_vertify_record
(
   id                   bigint not null auto_increment,
   product_id           bigint comment '��Ʒid',
   create_time          datetime comment '����ʱ��',
   vertify_man          varchar(64) comment '�����',
   status               int(1) comment '��˺��״̬��0->δͨ����2->��ͨ��',
   detail               varchar(255) comment '��������',
   primary key (id)
);

alter table pms_product_vertify_record comment '��Ʒ��˼�¼';

/*==============================================================*/
/* Table: pms_sku_stock                                         */
/*==============================================================*/
create table pms_sku_stock
(
   id                   bigint not null auto_increment,
   product_id           bigint comment '��Ʒid',
   sku_code             varchar(64) not null comment 'sku����',
   price                decimal(10,2) comment '�۸�',
   stock                int default 0 comment '���',
   low_stock            int comment 'Ԥ�����',
   sp1                  varchar(64) comment '�������1',
   sp2                  varchar(64) comment '�������2',
   sp3                  varchar(64) comment '�������3',
   pic                  varchar(255) comment 'չʾͼƬ',
   sale                 int comment '����',
   promotion_price      decimal(10,2) comment '��Ʒ�����۸�',
   lock_stock           int default 0 comment '�������',
   primary key (id)
);

alter table pms_sku_stock comment '��Ʒ��sku';

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

