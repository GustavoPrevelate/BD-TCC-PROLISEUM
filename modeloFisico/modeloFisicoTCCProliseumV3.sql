create database db_tcc_proliseum_v3;

use db_tcc_proliseum_v3;

create table tbl_genero(
	id int not null primary key auto_increment,
    nome_genero varchar(100),
    icone_genero varchar(255),
    unique index(id)
);

create table tbl_perfil(
	id int not null auto_increment,
    nome_usuario varchar(100) not null,
    nome_completo varchar(100) not null,
    email varchar(255),
    senha varchar(64) not null,
    data_nascimento date not null,
    foto_perfil varchar(255),
    foto_capa varchar(255),
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
    icone_rede_social varchar(255),
    unique index(id)
    
);

create table tbl_tag_rede_social(
	id int not null auto_increment,
    tag varchar(255),
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
    foto_organizacao varchar(255),
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
    foto_jogo varchar(255) not null,
    unique index(id)
);

create table tbl_time(
	id int not null auto_increment,
    nome_time varchar(100) not null,
    foto_time varchar(255),
    foto_capa varchar(255),
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

create table tbl_publicacao_time(
	id int not null auto_increment,
    nome_publicacao varchar(100) not null,
    inicio_horario_publicacao datetime not null,
    inicio_horario_disponivel datetime not null,
    fim_horario_disponivel datetime not null,
    descricao text(5000) not null,
    foto varchar(255),
    video varchar(255),
    id_time int not null,
    
    constraint FK_Time_PublicacaoTime
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
    icone_rank varchar(255) not null,
    id_jogo int not null,
    
    constraint FK_Jogo_RankJogo
    foreign key(id_jogo)
    references tbl_jogo(id),
    
    primary key(id),
    unique index(id)
    
);

create table tbl_funcao_jogo(
	id int not null auto_increment,
    foto_funcao varchar(255) not null,
    id_jogo int not null,
    
    constraint FK_Jogo_FuncaoJogo
    foreign key(id_jogo)
    references tbl_jogo(id),
    
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
    
    constraint FK_Perfil_Jogador
    foreign key (id_perfil)
    references tbl_perfil(id),
    
    constraint FK_TagRedeSocial_Jogador
    foreign key (id_tag_rede_social)
    references tbl_tag_rede_social(id),
    
    constraint FK_Time_Jogador
    foreign key (id_time)
    references tbl_time(id),
    
    primary key(id),
    unique index(id)
    
);

create table tbl_dados_jogador(
	id int not null auto_increment,
    id_funcao_jogo int not null,
    id_rank_jogo int not null,
    id_jogador int not null,
    
    constraint FK_FuncaoJogo_DadosJogador
    foreign key (id_funcao_jogo)
    references tbl_funcao_jogo(id),
    
    constraint FK_RankJogo_DadosJogador
    foreign key (id_rank_jogo)
    references tbl_rank_jogo(id),
    
    constraint FK_Jogador_DadosJogador
    foreign key(id_jogador)
    references tbl_jogador(id),
    
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
    foto varchar(255),
    video varchar(255),
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
    highlights varchar(255),
    foto varchar(255),
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
    foto_titulo varchar(255) not null,
    posicao int,
    data_titulo datetime,
    unique index(id)
);

create table tbl_campeonato(
	id int not null auto_increment,
    nome_campeonato varchar(100) not null,
    formato text(2000) not null,
    foto_capa_campeonato varchar(255) not null,
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

