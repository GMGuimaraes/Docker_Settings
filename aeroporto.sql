create database if not exists companhia_aerea;

use companhia_aerea;

create table aeroporto(
	codigo_aeroporto int not null primary key,
    cidade varchar(256) not null,
    estado varchar (2) not null,
    nome varchar (256) not null
);

create table voo (
	numero int not null primary key,
    companhia_aerea varchar (256) not null,
    dias_da_semana varchar (256) not null
);

create table trecho_voo (
	trecho_num int primary key,
	aeroporto_chegada int not null,
    aerorpoto_partida int not null,
    horario_partida_previsto time,
    horario_chegada_previsto time,
    voo_numero int not null
);



create table tarifa (
	codigo int not null primary key,
    voo int not null,
    quantidade int,
    restricoes varchar (128)
);

create table tipo_aeronave(
	tipo_nome varchar (128) primary key,
    empresa varchar (256) not null,
    qtd_max_assentos int not null
);

create table pode_pousar (
	aeroporto int,
    tipo_aeronave varchar (128),
    constraint aeroporto_fk foreign key (aeroporto) references aeroporto (codigo_aeroporto),
    constraint tipo_aeronave_fk foreign key (tipo_aeronave) references tipo_aeronave (tipo_nome)
);

create table aeronave (
	cod_aeronave int primary key,
    numero_total_assentos int not null,
    tipo_aeronave varchar (128),
    constraint aeronave_tipo_aeronave_fk foreign key (tipo_aeronave) references tipo_aeronave (tipo_nome)
);

create table instancia_trecho (
	data date primary key,
    numero_assentos_disponiveis int,
    trecho_voo int,
    aeroporto_chegada int,
    aeroporto_partida int,
    hora_chegada time,
    hora_partida time,
    aeronave int,
    constraint aeroporto_chegada_fk foreign key (aeroporto_chegada) references aeroporto (codigo_aeroporto),
    constraint aeroporto_partida_fk foreign key (aeroporto_partida) references aeroporto (codigo_aeroporto),
    constraint trecho_voo_fk foreign key (trecho_voo) references trecho_voo (trecho_num),
    constraint aeronave_fk foreign key (aeronave) references aeronave (cod_aeronave)
);

create table reserva_assento (
	cliente_tel varchar (16) not null,
    nome_cliente varchar (356) not null,
    numero_assento smallint,
    intancia_trecho date not null,
    constraint instancia_trecho_fk foreign key (instancia_trecho) references instancia_trecho (data)
);
