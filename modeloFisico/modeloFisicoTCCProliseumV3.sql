create database db_tcc_proliseum_v3;

use db_tcc_proliseum_v3;

show tables;

drop database db_tcc_proliseum_v3;

create table tbl_genero(
	id int not null primary key auto_increment,
    nome_genero varchar(100),
    icone_genero text,
    unique index(id)
);

create table tbl_perfil(
	id int not null auto_increment,
    nome_usuario varchar(100) not null,
    nome_completo varchar(100) not null,
    email varchar(255),
    senha varchar(64) not null,
    data_nascimento date not null,
    foto_perfil text,
    foto_capa text,
    id_genero int not null,
    
    constraint FK_Genero_Perfil
    foreign key(id_genero)
    references tbl_genero(id),
    
    primary key(id),
    unique index(id)
);

create table tbl_rede_social(
	id int not null primary key auto_increment,
    nome_rede_social varchar(100),
    icone_rede_social text,
    unique index(id)
    
);

create table tbl_tag_rede_social(
	id int not null auto_increment,
    tag text,
    id_rede_social int not null,
    
    constraint FK_RedeSocial_TagRedeSocial
    foreign key (id_rede_social)
    references tbl_rede_social(id),
    
    primary key(id),
    unique index(id)
);

create table tbl_organizador(
	id int not null auto_increment,
    nome_organizacao varchar(100) not null,
    foto_organizacao text,
    biografia text(2000),
    id_perfil int not null,
    id_tag_rede_social int not null,
    
    constraint FK_Perfil_Organizador
    foreign key (id_perfil)
    references tbl_perfil(id),
    
    constraint FK_TagRedeSocial_Organizador
    foreign key (id_tag_rede_social)
    references tbl_tag_rede_social(id),
    
    primary key(id),
    unique index(id)

);

create table tbl_jogo(
	id int not null primary key auto_increment,
    nome_jogo varchar(100),
    foto_jogo text not null,
    unique index(id)
);

create table tbl_time(
	id int not null auto_increment,
    nome_time varchar(100) not null,
    foto_time text,
    foto_capa text,
    biografia text(2000),
    id_jogo int not null,
    id_organizador int not null,
    id_tag_rede_social int not null,
    
    constraint FK_Jogo_Time
    foreign key (id_jogo)
    references tbl_jogo(id),
    
    constraint FK_Organizador_Time
    foreign key (id_organizador)
    references tbl_organizador(id),
    
    constraint FK_TagRedeSocial_Time
    foreign key (id_tag_rede_social)
    references tbl_tag_rede_social(id),
    
    primary key(id),
    unique index(id)
    
);

create table tbl_peneira_time(
	id int not null auto_increment,
    nome_publicacao varchar(100) not null,
    inicio_horario_publicacao datetime not null,
    inicio_horario_disponivel datetime not null,
    fim_horario_disponivel datetime not null,
    descricao text(5000) not null,
    foto text,
    video text,
    id_time int not null,
    
    constraint FK_Time_PeneiraTime
    foreign key (id_time)
    references tbl_time(id),
    
    primary key(id),
    unique index(id)
);

create table tbl_treino(
	id int not null primary key auto_increment,
    nome_treino varchar(100) not null,
    data_hora datetime not null,
    inicio datetime not null,
    fim datetime not null,
    avaliacao double,
    unique index(id)
);

create table tbl_treino_time(
	id int not null auto_increment,
    id_time int not null,
    id_treino int not null,
    
    constraint FK_Time_TreinoTime
    foreign key (id_time)
    references tbl_time(id),
    
    constraint FK_Treino_TreinoTime
    foreign key (id_treino)
    references tbl_treino(id),
    
    primary key(id),
    unique index(id)
    
);

create table tbl_rank_jogo(
	id int not null auto_increment,
    icone_rank text not null,
    id_jogo int not null,
    
    constraint FK_Jogo_RankJogo
    foreign key(id_jogo)
    references tbl_jogo(id),
    
    primary key(id),
    unique index(id)
    
);

create table tbl_funcao_jogo(
	id int not null auto_increment,
    foto_funcao text not null,
    id_jogo int not null,
    
    constraint FK_Jogo_FuncaoJogo
    foreign key(id_jogo)
    references tbl_jogo(id),
    
    primary key(id),
    unique index(id)
    
);

create table tbl_dados_jogador(
	id int not null auto_increment,
    id_funcao_jogo int not null,
    id_rank_jogo int not null,
    
    constraint FK_FuncaoJogo_DadosJogador
    foreign key (id_funcao_jogo)
    references tbl_funcao_jogo(id),
    
    constraint FK_RankJogo_DadosJogador
    foreign key (id_rank_jogo)
    references tbl_rank_jogo(id),
    
    primary key(id),
    unique index(id)
    
);

create table tbl_jogador(
	id int not null auto_increment,
    nickname varchar(100) not null,
    biografia text(2000),
    id_perfil int not null,
    id_tag_rede_social int not null,
    id_time int not null,
    id_dados_jogador int not null,
    
    constraint FK_Perfil_Jogador
    foreign key (id_perfil)
    references tbl_perfil(id),
    
    constraint FK_TagRedeSocial_Jogador
    foreign key (id_tag_rede_social)
    references tbl_tag_rede_social(id),
    
    constraint FK_Time_Jogador
    foreign key (id_time)
    references tbl_time(id),
    
    constraint FK_DadosJogador_Jogador
    foreign key(id_dados_jogador)
    references tbl_dados_jogador(id),
    
    primary key(id),
    unique index(id)
    
);



create table tbl_publicacao_jogador(
	id int not null auto_increment,
    nome_publicacao varchar(100) not null,
    inicio_horario_publicacao datetime not null,
    inicio_horario_disponivel datetime not null,
    fim_horario_disponivel datetime not null,
    descricao text(5000) not null,
    foto text,
    video text,
    id_jogador int not null,
    
    constraint FK_Jogador_PublicacaoJogador
    foreign key (id_jogador)
    references tbl_jogador(id),
    
    primary key(id),
    unique index(id)
);

create table tbl_propostas_jogador(
	id int not null auto_increment,
    propostas text(5000),
    id_publicacao_jogador int not null,
    id_time int not null,
    
    constraint FK_PublicacaoJogador_PropostasJogador
    foreign key(id_publicacao_jogador)
    references tbl_publicacao_jogador(id),
    
    constraint FK_Time_PropostasJogador
    foreign key(id_time)
    references tbl_time(id),
    
    primary key(id),
    unique index(id)
);

create table tbl_highlights(
	id int not null primary key auto_increment,
    highlights text,
    foto text,
    unique index(id)
    
);

create table tbl_highlights_time(
	id int not null auto_increment,
    id_highlights int not null,
    id_time int not null,
    
    constraint FK_Highlights_HighlightsTime
    foreign key(id_highlights)
    references tbl_highlights(id),
    
    constraint FK_Time_HighlightsTime
    foreign key(id_time)
    references tbl_time(id),
    
    primary key(id),
    unique index(id)
    
);

create table tbl_highlights_jogador(
	id int not null auto_increment,
    id_highlights int not null,
    id_jogador int not null,
    
    constraint FK_Highlights_HighlightsJogador
    foreign key(id_highlights)
    references tbl_highlights(id),
    
    constraint FK_Jogador_HighlightsJogador
    foreign key(id_jogador)
    references tbl_jogador(id),
    
    primary key(id),
    unique index(id)
    
);

create table tbl_titulos_campeonatos(
	id int not null primary key auto_increment,
    nome_titulo varchar(100) not null,
    foto_titulo text not null,
    posicao int,
    data_titulo datetime,
    unique index(id)
);

create table tbl_campeonato(
	id int not null auto_increment,
    nome_campeonato varchar(100) not null,
    formato text(2000) not null,
    foto_capa_campeonato text not null,
    data_hora datetime not null,
    inicio datetime not null,
    fim datetime not null,
    andamento tinyint not null,
    descricao text(5000) not null,
    regras text(5000) not null,
    avaliacao double,
    id_organizador int not null,
    id_titulos_campeonatos int not null,
    id_tag_rede_social int not null,
    
    constraint FK_Organizador_Campeonato
    foreign key(id_organizador)
    references tbl_organizador(id),
    
    constraint FK_TitulosCampeonatos_Campeonato
    foreign key(id_titulos_campeonatos)
    references tbl_titulos_campeonatos(id),
    
    constraint FK_TagRedeSocial_Campeonato
    foreign key(id_tag_rede_social)
    references tbl_tag_rede_social(id),
    
    primary key(id),
    unique index(id)
    
);

create table tbl_time_campeonato(
	id int not null auto_increment,
    id_campeonato int not null,
    id_time int not null,
    
    constraint FK_Campeonato_TimeCampeonato
    foreign key(id_campeonato)
    references tbl_campeonato(id),
    
    constraint FK_Time_TimeCampeonato
    foreign key(id_time)
    references tbl_time(id),
    
    primary key(id),
    unique index(id)
    
);

create table tbl_peneira_time_jogador (
	id int not null auto_increment,
    id_peneira_time int not null,
    id_jogador int not null,
    
    constraint FK_Peneiratime_PeneiraTimeJogador
    foreign key (id_peneira_time)
    references tbl_peneira_time(id),
    
    constraint FK_Jogador_PeneiraTimeJogador
    foreign key(id_jogador)
    references tbl_jogador(id),
    
    primary key(id),
    unique index(id)
);

##################### MANIPULAÇÃO DE INSERT

### TESTE INSERT NA TABELA DE GENERO
insert into tbl_genero (nome_genero, icone_genero)
	values("masculino", "icone masculino");
    
insert into tbl_genero (nome_genero, icone_genero)
	values("feminino", "icone feminino");

insert into tbl_genero (nome_genero, icone_genero)
	values("outro", "icone outro");
    
select * from tbl_genero;

### TESTE INSERT NA TABELA DE PERFIL
### ORGANIZADOR
insert into tbl_perfil (nome_usuario, nome_completo, email, senha, data_nascimento, foto_perfil, foto_capa, id_genero)
	values(
			"gustavogameplay", 
			"gustavo prevelate", 
			"gustavo@gmail.com",  
			"12345678",  
			"2004-12-15",  
			"foto goku",  
			"capa dragonball",  
			1);
            
### JOGADOR
insert into tbl_perfil (nome_usuario, nome_completo, email, senha, data_nascimento, foto_perfil, foto_capa, id_genero)
	values(
			"eduardogameplay", 
			"eduardo ribeiro", 
			"eduardo@gmail.com",  
			"87654321",  
			"2004-09-08",  
			"foto rengoku",  
			"capa demonslayer",  
			1);
            
select * from tbl_perfil;

### TESTE INSERT NA TABELA DE REDE SOCIAL
insert into tbl_rede_social (nome_rede_social, icone_rede_social)
	values("Facebook", "Icone facebook");
    
insert into tbl_rede_social (nome_rede_social, icone_rede_social)
	values("Discord", "Icone discord");
    
insert into tbl_rede_social (nome_rede_social, icone_rede_social)
	values("instagram", "Icone instagram");
    
insert into tbl_rede_social (nome_rede_social, icone_rede_social)
	values("Twitter", "Icone twitter");
    
select * from tbl_rede_social;

### TESTE INSERT NA TABELA DE TAG DA REDE SOCIAL
insert into tbl_tag_rede_social (tag, id_rede_social)
	values("Linkfacebook#@fa1565", "1");
    
insert into tbl_tag_rede_social (tag, id_rede_social)
	values("linkdiscord#5234", "2");

insert into tbl_tag_rede_social (tag, id_rede_social)
	values("linkinstagram#2354", "3");
    
insert into tbl_tag_rede_social (tag, id_rede_social)
	values("linktwitter#3525", "4");

select * from tbl_tag_rede_social;

### TESTE INSERT NA TABELA DE ORGANIZADOR
insert into tbl_organizador (nome_organizacao, foto_organizacao, biografia, id_perfil, id_tag_rede_social)
	values(
			"gustavo empresario", 
			"foto goku drip", 
			"ser ou nao ser, so sei que nada sei",  
			1,  
			2);
            
select * from tbl_organizador;

### TESTE INSERT NA TABELA DE JOGO
insert into tbl_jogo (nome_jogo, foto_jogo)
	values("league of legens", "foto do faz o L");
    
insert into tbl_jogo (nome_jogo, foto_jogo)
	values("counter stricker", "foto de soldado tr");
    
insert into tbl_jogo (nome_jogo, foto_jogo)
	values("valorant", "foto da jet");
    
select * from tbl_jogo;

### TESTE INSERT NA TABELA DE TIME
insert into tbl_time (nome_time, foto_time, foto_capa, biografia, id_jogo, id_organizador, id_tag_rede_social)
	values(
			"time padrao", 
			"foto padrao", 
			"foto capa padrao",  
			"biografia padrao",  
		    1,  
			1,  
			4);
	
select * from tbl_time;

### TESTE INSERT NA TABELA DE FUNÇÃO JOGO
insert into tbl_funcao_jogo (foto_funcao, id_jogo)
	values("foto top", "1");

insert into tbl_funcao_jogo (foto_funcao, id_jogo)
	values("foto jungler", "2");

insert into tbl_funcao_jogo (foto_funcao, id_jogo)
	values("foto mid", "3");
    
insert into tbl_funcao_jogo (foto_funcao, id_jogo)
	values("foto adc", "2");
    
insert into tbl_funcao_jogo (foto_funcao, id_jogo)
	values("foto suporte", "1");
    
select * from tbl_funcao_jogo;

### TESTE INSERT NA TABELA DE RANK JOGO
insert into tbl_rank_jogo (icone_rank, id_jogo)
	values("icone prata 1", "2");

insert into tbl_rank_jogo (icone_rank, id_jogo)
	values("icone ouro 2", "2");
    
insert into tbl_rank_jogo (icone_rank, id_jogo)
	values("icone platina 3", "3");
    
insert into tbl_rank_jogo (icone_rank, id_jogo)
	values("icone diamante 4", "1");
    
insert into tbl_rank_jogo (icone_rank, id_jogo)
	values("icone global 5", "1");
    
select * from tbl_rank_jogo;

### TESTE INSERT NA TABELA DE RANK JOGO
insert into tbl_dados_jogador (id_funcao_jogo, id_rank_jogo)
	values("1", "1");
    
insert into tbl_dados_jogador (id_funcao_jogo, id_rank_jogo)
	values("2", "1");
    
insert into tbl_dados_jogador (id_funcao_jogo, id_rank_jogo)
	values("2", "3");
    
insert into tbl_dados_jogador (id_funcao_jogo, id_rank_jogo)
	values("3", "2");
    
insert into tbl_dados_jogador (id_funcao_jogo, id_rank_jogo)
	values("3", "2");

select * from tbl_dados_jogador;

### TESTE INSERT NA TABELA DE JOGADOR
insert into tbl_jogador (nickname, biografia, id_perfil, id_tag_rede_social, id_time, id_dados_jogador)
	values(
			"eduardogameplay2023", 
			"jogo varios jogos", 
			2,  
			2,  
		    1,  
			2);
		
select * from tbl_jogador;

### TESTE DE INSERT PARA CADASTRAR USUARIO EFETIVAMENTE



##################### MANIPULAÇÃO DE SELECT

SELECT tbl_perfil.id,
		tbl_perfil.nome_usuario,
		tbl_perfil.senha
FROM tbl_perfil where id = 1;

UPDATE tbl_perfil set senha = "1234" where id = 1;

		

