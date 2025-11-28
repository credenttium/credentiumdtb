drop table if exists tb_plataforma cascade;
drop table if exists tb_credencial cascade;
drop table if exists tb_base_dados cascade;

create table if not exists tb_plataforma (
  code serial not null,
  nome varchar(255) not null,
  created_at timestamp not null default now(),
  updated_at timestamp not null default now(),
  deleted_at timestamp null,
  active boolean not null default true,
  constraint pk_plataforma primary key (code)
);

insert into tb_plataforma (nome) values ('Microsoft');
insert into tb_plataforma (nome) values ('Google');

create table if not exists tb_credencial (
  code serial not null,
  id_plataforma integer not null,
  descricao varchar(255) not null,
  usuario varchar(255) not null,
  senha varchar(255) not null,
  link varchar(255) null,
  created_at timestamp not null default now(),
  updated_at timestamp not null default now(),
  deleted_at timestamp null,
  active boolean not null default true,
  constraint pk_credencial primary key (code),
  constraint fk_credencial foreign key (id_plataforma) references tb_plataforma (code),
  constraint un_credencial unique (descricao, usuario, senha)
);

create table if not exists tb_base_dados (
  code serial not null,
  descricao varchar(255) not null,
  nome varchar(255) not null,
  senha varchar(255) not null,
  host varchar(255) not null,
  porta varchar(255) not null,
  url varchar(255) null,
  created_at timestamp not null default now(),
  updated_at timestamp not null default now(),
  deleted_at timestamp null,
  active boolean not null default true,
  constraint pk_base_dados primary key (code),
  constraint un_base_dados unique (descricao, nome, host)
);

-- select * from tb_plataforma;
-- select * from tb_credencial;
-- select * from tb_base_dados;