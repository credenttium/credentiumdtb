drop table if exists tb_tipo_pessoa cascade;
drop table if exists tb_pessoa cascade;
drop table if exists tb_credencial cascade;

create table if not exists tb_tipo_pessoa (
  code serial not null,
  descricao varchar(255) not null,
  constraint pk_tipo_pessoa primary key (code),
  constraint un_pessoa unique (descricao)
);

create table if not exists tb_pessoa (
  code serial not null,
  id_tipo_pessoa serial not null,
  nome varchar(255) not null,
  active boolean not null default true,
  constraint pk_pessoa primary key (code),
  constraint fk_pessoa foreign key (id_tipo_pessoa) references tb_tipo_pessoa (code)
);

insert into tb_tipo_pessoa (descricao) values ('Pessoa Física');
insert into tb_tipo_pessoa (descricao) values ('Pessoa Jurídica');

insert into tb_pessoa (id_tipo_pessoa, nome) values (2, 'Microsoft');
insert into tb_pessoa (id_tipo_pessoa, nome) values (2, 'Google');

create table if not exists tb_credencial (
  code serial not null,
  id_pessoa serial not null,
  descricao varchar(255) not null,
  usuario varchar(255) not null,
  senha varchar(255) not null,
  link varchar(255) null,
  active boolean not null default true,
  constraint pk_credencial primary key (code),
  constraint fk_credencial foreign key (id_pessoa) references tb_pessoa (code),
  constraint un_credencial unique (descricao, usuario, senha)
);

/*
insert into tb_credencial (id_pessoa, descricao, usuario, senha, link) values (
  (select code from tb_pessoa where nome = 'Microsoft'),
  'Conta Microsoft',
  'jose.quintinno@outlook.com.br',
  '$2a$12$h9keqE2l9aLkHyi5pzcGp.mol8Pgj120ULWSrAJR97ev2.YJNDXha',
  ''
);
*/

-- select * from tb_pessoa;
-- select * from tb_credencial;