# MYSQL

drop table if exists databasechangelog;
drop table if exists databasechangeloglock;
drop table if exists tb_credencial;
drop table if exists tb_plataforma;

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
