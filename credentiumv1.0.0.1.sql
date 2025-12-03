# POSTGRESQL

drop table if exists databasechangelog cascade;
drop table if exists databasechangeloglock cascade;
drop table if exists tb_credencial cascade;
drop table if exists tb_plataforma cascade;

create table if not exists tb_plataforma (
  code serial not null,
  nome varchar(255) not null,
  url varchar(255) null,
  logomarca bytea null,
  created_at timestamp not null default now(),
  updated_at timestamp not null default now(),
  deleted_at timestamp null,
  active boolean not null default true,
  constraint pk_plataforma primary key (code)
);

create table if not exists tb_credencial (
  code serial not null,
  id_plataforma integer not null,
  descricao varchar(255) not null,
  usuario varchar(255) null,
  senha varchar(255) null,
  link varchar(255) null,
  created_at timestamp not null default now(),
  updated_at timestamp not null default now(),
  deleted_at timestamp null,
  active boolean not null default true,
  constraint pk_credencial primary key (code),
  constraint fk_credencial foreign key (id_plataforma) references tb_plataforma (code),
  constraint un_credencial unique (descricao, usuario)
);