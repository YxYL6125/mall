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
   username             varchar(64) comment '�û���',
   password             varchar(64) comment '����',
   icon                 varchar(500) comment 'ͷ��',
   email                varchar(100) comment '����',
   nick_name            varchar(200) comment '�ǳ�',
   note                 varchar(500) comment '��ע��Ϣ',
   create_time          datetime comment '����ʱ��',
   login_time           datetime comment '����¼ʱ��',
   status               int(1) default 1 comment '�ʺ�����״̬��0->���ã�1->����',
   primary key (id)
);

alter table ums_admin comment '��̨�û���';

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
   user_agent           varchar(100) comment '�������¼����',
   primary key (id)
);

alter table ums_admin_login_log comment '��̨�û���¼��־��';

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

alter table ums_admin_permission_relation comment '��̨�û���Ȩ�޹�ϵ��(����ɫ�ж����Ȩ������ļӼ�Ȩ��)';

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

alter table ums_admin_role_relation comment '��̨�û��ͽ�ɫ��ϵ��';

/*==============================================================*/
/* Table: ums_growth_change_history                             */
/*==============================================================*/
create table ums_growth_change_history
(
   id                   bigint not null auto_increment,
   member_id            bigint,
   create_time          datetime,
   change_type          int(1) comment '�ı����ͣ�0->���ӣ�1->����',
   change_count         int comment '���ָı�����',
   operate_man          varchar(100) comment '������Ա',
   operate_note         varchar(200) comment '������ע',
   source_type          int(1) comment '������Դ��0->���1->����Ա�޸�',
   primary key (id)
);

alter table ums_growth_change_history comment '�ɳ�ֵ�仯��ʷ��¼��';

/*==============================================================*/
/* Table: ums_integration_change_history                        */
/*==============================================================*/
create table ums_integration_change_history
(
   id                   bigint not null auto_increment,
   member_id            bigint,
   create_time          datetime,
   change_type          int(1) comment '�ı����ͣ�0->���ӣ�1->����',
   change_count         int comment '���ָı�����',
   operate_man          varchar(100) comment '������Ա',
   operate_note         varchar(200) comment '������ע',
   source_type          int(1) comment '������Դ��0->���1->����Ա�޸�',
   primary key (id)
);

alter table ums_integration_change_history comment '���ֱ仯��ʷ��¼��';

/*==============================================================*/
/* Table: ums_integration_consume_setting                       */
/*==============================================================*/
create table ums_integration_consume_setting
(
   id                   bigint not null auto_increment,
   deduction_per_amount int comment 'ÿһԪ��Ҫ�ֿ۵Ļ�������',
   max_percent_per_order int comment 'ÿ�ʶ�����ߵ��ðٷֱ�',
   use_unit             int comment 'ÿ��ʹ�û�����С��λ100',
   coupon_status        int(1) comment '�Ƿ���Ժ��Ż�ȯͬ�ã�0->�����ԣ�1->����',
   primary key (id)
);

alter table ums_integration_consume_setting comment '������������';

/*==============================================================*/
/* Table: ums_member                                            */
/*==============================================================*/
create table ums_member
(
   id                   bigint not null auto_increment,
   member_level_id      bigint,
   username             varchar(64) comment '�û���',
   password             varchar(64) comment '����',
   nickname             varchar(64) comment '�ǳ�',
   phone                varchar(64) comment '�ֻ�����',
   status               int(1) comment '�ʺ�����״̬:0->���ã�1->����',
   create_time          datetime comment 'ע��ʱ��',
   icon                 varchar(500) comment 'ͷ��',
   gender               int(1) comment '�Ա�0->δ֪��1->�У�2->Ů',
   birthday             date comment '����',
   city                 varchar(64) comment '��������',
   job                  varchar(100) comment 'ְҵ',
   personalized_signature varchar(200) comment '����ǩ��',
   source_type          int(1) comment '�û���Դ',
   integration          int comment '����',
   growth               int comment '�ɳ�ֵ',
   luckey_count         int comment 'ʣ��齱����',
   history_integration  int comment '��ʷ��������',
   primary key (id)
);

alter table ums_member comment '��Ա��';

/*==============================================================*/
/* Table: ums_member_level                                      */
/*==============================================================*/
create table ums_member_level
(
   id                   bigint not null auto_increment,
   name                 varchar(100),
   growth_point         int,
   default_status       int(1) comment '�Ƿ�ΪĬ�ϵȼ���0->���ǣ�1->��',
   free_freight_point   decimal(10,2) comment '���˷ѱ�׼',
   comment_growth_point int comment 'ÿ�����ۻ�ȡ�ĳɳ�ֵ',
   priviledge_free_freight int(1) comment '�Ƿ���������Ȩ',
   priviledge_sign_in   int(1) comment '�Ƿ���ǩ����Ȩ',
   priviledge_comment   int(1) comment '�Ƿ������ۻ�����Ȩ',
   priviledge_promotion int(1) comment '�Ƿ���ר����Ȩ',
   priviledge_member_price int(1) comment '�Ƿ��л�Ա�۸���Ȩ',
   priviledge_birthday  int(1) comment '�Ƿ���������Ȩ',
   note                 varchar(200),
   primary key (id)
);

alter table ums_member_level comment '��Ա�ȼ���';

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
   login_type           int(1) comment '��¼���ͣ�0->PC��1->android;2->ios;3->С����',
   province             varchar(64),
   primary key (id)
);

alter table ums_member_login_log comment '��Ա��¼��¼';

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

alter table ums_member_member_tag_relation comment '�û��ͱ�ǩ��ϵ��';

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

alter table ums_member_product_category_relation comment '��Ա���Ʒ�����ϵ���û�ϲ���ķ��ࣩ';

/*==============================================================*/
/* Table: ums_member_receive_address                            */
/*==============================================================*/
create table ums_member_receive_address
(
   id                   bigint not null auto_increment,
   member_id            bigint,
   name                 varchar(100) comment '�ջ�������',
   phone_number         varchar(64),
   default_status       int(1) comment '�Ƿ�ΪĬ��',
   post_code            varchar(100) comment '��������',
   province             varchar(100) comment 'ʡ��/ֱϽ��',
   city                 varchar(100) comment '����',
   region               varchar(100) comment '��',
   detail_address       varchar(128) comment '��ϸ��ַ(�ֵ�)',
   primary key (id)
);

alter table ums_member_receive_address comment '��Ա�ջ���ַ��';

/*==============================================================*/
/* Table: ums_member_rule_setting                               */
/*==============================================================*/
create table ums_member_rule_setting
(
   id                   bigint not null auto_increment,
   continue_sign_day    int comment '����ǩ������',
   continue_sign_point  int comment '����ǩ����������',
   consume_per_point    decimal(10,2) comment 'ÿ���Ѷ���Ԫ��ȡ1����',
   low_order_amount     decimal(10,2) comment '��ͻ�ȡ�����Ķ������',
   max_point_per_order  int comment 'ÿ�ʶ�����߻�ȡ����',
   type                 int(1) comment '���ͣ�0->���ֹ���1->�ɳ�ֵ����',
   primary key (id)
);

alter table ums_member_rule_setting comment '��Ա���ֳɳ������';

/*==============================================================*/
/* Table: ums_member_statistics_info                            */
/*==============================================================*/
create table ums_member_statistics_info
(
   id                   bigint not null auto_increment,
   member_id            bigint,
   consume_amount       decimal(10,2) comment '�ۼ����ѽ��',
   order_count          int comment '��������',
   coupon_count         int comment '�Ż�ȯ����',
   comment_count        int comment '������',
   return_order_count   int comment '�˻�����',
   login_count          int comment '��¼����',
   attend_count         int comment '��ע����',
   fans_count           int comment '��˿����',
   collect_product_count int,
   collect_subject_count int,
   collect_topic_count  int,
   collect_comment_count int,
   invite_friend_count  int,
   recent_order_time    datetime comment '���һ���¶���ʱ��',
   primary key (id)
);

alter table ums_member_statistics_info comment '��Աͳ����Ϣ';

/*==============================================================*/
/* Table: ums_member_tag                                        */
/*==============================================================*/
create table ums_member_tag
(
   id                   bigint not null auto_increment,
   name                 varchar(100),
   finish_order_count   int comment '�Զ����ǩ��ɶ�������',
   finish_order_amount  decimal(10,2) comment '�Զ����ǩ��ɶ������',
   primary key (id)
);

alter table ums_member_tag comment '�û���ǩ��';

/*==============================================================*/
/* Table: ums_member_task                                       */
/*==============================================================*/
create table ums_member_task
(
   id                   bigint not null auto_increment,
   name                 varchar(100),
   growth               int comment '���ͳɳ�ֵ',
   intergration         int comment '���ͻ���',
   type                 int(1) comment '�������ͣ�0->��������1->�ճ�����',
   primary key (id)
);

alter table ums_member_task comment '��Ա�����';

/*==============================================================*/
/* Table: ums_permission                                        */
/*==============================================================*/
create table ums_permission
(
   id                   bigint not null auto_increment,
   pid                  bigint comment '����Ȩ��id',
   name                 varchar(100) comment '����',
   value                varchar(200) comment 'Ȩ��ֵ',
   icon                 varchar(500) comment 'ͼ��',
   type                 int(1) comment 'Ȩ�����ͣ�0->Ŀ¼��1->�˵���2->��ť���ӿڰ�Ȩ�ޣ�',
   uri                  varchar(200) comment 'ǰ����Դ·��',
   status               int(1) comment '����״̬��0->���ã�1->����',
   create_time          datetime comment '����ʱ��',
   sort                 int comment '����',
   primary key (id)
);

alter table ums_permission comment '��̨�û�Ȩ�ޱ�';

/*==============================================================*/
/* Table: ums_role                                              */
/*==============================================================*/
create table ums_role
(
   id                   bigint not null auto_increment,
   name                 varchar(100) comment '����',
   description          varchar(500) comment '����',
   admin_count          int comment '��̨�û�����',
   create_time          datetime comment '����ʱ��',
   status               int(1) default 1 comment '����״̬��0->���ã�1->����',
   sort                 int default 0,
   primary key (id)
);

alter table ums_role comment '��̨�û���ɫ��';

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

alter table ums_role_permission_relation comment '��̨�û���ɫ��Ȩ�޹�ϵ��';

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

