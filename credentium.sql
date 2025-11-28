drop table if exists tb_plataforma cascade;
drop table if exists tb_credencial cascade;

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
  id_plataforma serial not null,
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

-- select * from tb_pessoa;
-- select * from tb_credencial;