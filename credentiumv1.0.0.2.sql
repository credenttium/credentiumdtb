show databases;

create database db_credentium_desenvolvimento;

use db_credentium_desenvolvimento;

show tables;

drop table if exists databasechangelog;
drop table if exists databasechangeloglock;
drop table if exists tb_credencial;
drop table if exists tb_plataforma;
drop table if exists tb_usuario;
drop table if exists tb_perfil;
drop table if exists tb_usuario_perfil;

create table if not exists tb_plataforma (
  code int not null auto_increment,
  nome varchar(255) not null,
  url varchar(255) null,
  logomarca longblob null,
  created_at timestamp not null default current_timestamp,
  updated_at timestamp not null default current_timestamp on update current_timestamp,
  deleted_at timestamp null,
  active boolean not null default true,
  primary key (code)
);

create table if not exists tb_credencial (
  code int not null auto_increment,
  id_plataforma int not null,
  descricao varchar(255) not null,
  usuario varchar(255) null,
  senha varchar(255) null,
  link varchar(255) null,
  created_at timestamp not null default current_timestamp,
  updated_at timestamp not null default current_timestamp on update current_timestamp,
  deleted_at timestamp null,
  active boolean not null default true,
  primary key (code),
  unique key un_credencial (descricao, usuario),
  constraint fk_credencial foreign key (id_plataforma) references tb_plataforma (code)
);

create table if not exists tb_usuario (
  code int not null auto_increment,
  nome varchar(255) not null,
  usuario varchar(255) not null,
  senha varchar(255) not null,
  created_at timestamp not null default current_timestamp,
  updated_at timestamp not null default current_timestamp on update current_timestamp,
  deleted_at timestamp null,
  active boolean not null default true,
  constraint pk_usuario primary key (code),
  constraint un_usuario unique key un_usuario (usuario)
);

create table if not exists tb_perfil (
  code int not null auto_increment,
  descricao varchar(255) not null,
  sigla varchar(255) not null,
  created_at timestamp not null default current_timestamp,
  updated_at timestamp not null default current_timestamp on update current_timestamp,
  deleted_at timestamp null,
  active boolean not null default true,
  constraint pk_perfil primary key (code),
  constraint un_perfil unique key un_perfil (descricao, sigla)
);

create table if not exists tb_usuario_perfil (
  code int not null auto_increment,
  id_usuario int not null,
  id_perfil int not null,
  created_at timestamp not null default current_timestamp,
  updated_at timestamp not null default current_timestamp on update current_timestamp,
  deleted_at timestamp null,
  active boolean not null default true,
  constraint pk_usuario_perfil primary key (code),
  constraint fk_usuario_perfil_1 foreign key (id_usuario) references tb_usuario (code),
  constraint fk_usuario_perfil_2 foreign key (id_perfil) references tb_perfil (code),
  constraint un_usuario_perfil unique key un_perfil (id_usuario, id_perfil)
);