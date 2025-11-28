drop table if exists tb_plataforma cascade;
drop table if exists tb_credencial cascade;
drop table if exists tb_base_dados cascade;
drop table if exists tb_plataforma cascade;
drop table if exists tb_autenticacao_federada cascade;

create table if not exists tb_plataforma (
  code serial not null,
  nome varchar(255) not null,
  url varchar(255) null,
  created_at timestamp not null default now(),
  updated_at timestamp not null default now(),
  deleted_at timestamp null,
  active boolean not null default true,
  constraint pk_plataforma primary key (code)
);

create table if not exists tb_autenticacao_federada (
  code serial not null,
  descricao varchar(255) not null,
  created_at timestamp not null default now(),
  updated_at timestamp not null default now(),
  deleted_at timestamp null,
  active boolean not null default true,
  constraint pk_autenticacao_federada primary key (code),
  constraint un_autenticacao_federada unique (descricao)
);

create table if not exists tb_credencial (
  code serial not null,
  id_plataforma integer not null,
  id_autenticacao_federada integer null,
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
  constraint fk_autenticacao_federada foreign key (id_autenticacao_federada) references tb_autenticacao_federada (code),
  constraint un_credencial unique (descricao, usuario)
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

alter table tb_credencial add constraint ck_credencial_autenticacao check (
    (id_autenticacao_federada is not null and usuario is null and senha is null and link is null)
    or
    (id_autenticacao_federada is null and usuario is not null and senha is not null and link is not null)
);

insert into tb_plataforma (nome) values ('Microsoft');
insert into tb_plataforma (nome) values ('Google');
insert into tb_plataforma (nome, url) values ('Github', 'https://github.com/');
insert into tb_plataforma (nome, url) values ('Supabase', 'https://supabase.com/');

insert into tb_credencial (id_plataforma, id_autenticacao_federada, descricao, usuario, senha, link) values (
	(select code from tb_plataforma where nome = 'Github'),
	null,
	'Conta GitHub',
	'jose.quintinno@outlook.com.br', 
	'$2a$12$h9keqE2l9aLkHyi5pzcGp.mol8Pgj120ULWSrAJR97ev2.YJNDXha', 
	'https://github.com/login'
);

insert into tb_autenticacao_federada (descricao) values ('Github (jose.quintinno@outlook.com.br)');

insert into tb_credencial (id_plataforma, id_autenticacao_federada, descricao, usuario, senha, link) values (
	(select code from tb_plataforma where nome = 'Supabase'),
	(select code from tb_autenticacao_federada where descricao = 'Github (jose.quintinno@outlook.com.br)'),
	'Conta Supabase', null, null, null
);

-- select * from tb_plataforma;
-- select * from tb_credencial;
-- select * from tb_autenticacao_federada;
-- select * from tb_base_dados;

/*
select 
	plataforma.nome,
	credencial.descricao,
	credencial.usuario,
	credencial.link,
	autenticacao_federada.descricao as autenticacao_federada
-- select * 
from tb_credencial credencial
join tb_plataforma plataforma on plataforma.code = credencial.id_plataforma
left join tb_autenticacao_federada autenticacao_federada on autenticacao_federada.code = credencial.id_autenticacao_federada;
*/
