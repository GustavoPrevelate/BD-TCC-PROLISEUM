create database db_tcc_proliseum_v4;

show databases;
show tables;

use db_tcc_proliseum_v4;

drop database db_tcc_proliseum_v4;

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
    
    constraint FK_Perfil_Organizador
    foreign key (id_perfil)
    references tbl_perfil(id),
    
    primary key(id),
    unique index(id)

);

create table tbl_tag_rede_social_organizador(
	id int not null auto_increment,
    id_organizador int not null,
    id_tag_rede_social int not null,
    
    constraint FK_Organizador_TagRedeSocialOrganizador
    foreign key (id_organizador)
    references tbl_organizador(id),
    
    constraint FK_TagRedeSocial_TagRedeSocialOrganizador
    foreign key (id_tag_rede_social)
    references tbl_tag_rede_social(id),
    
    unique index(id),
    primary key(id)
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
    
    constraint FK_Jogo_Time
    foreign key (id_jogo)
    references tbl_jogo(id),
    
    constraint FK_Organizador_Time
    foreign key (id_organizador)
    references tbl_organizador(id),
    
    primary key(id),
    unique index(id)
    
);

create table tbl_tag_rede_social_time(
	id int not null auto_increment,
    id_time int not null,
    id_tag_rede_social int not null,
    
    constraint FK_Time_TagRedeSocialTime
    foreign key (id_time)
    references tbl_time(id),
    
    constraint FK_TagRedeSocial_TagRedeSocialTime
    foreign key (id_tag_rede_social)
    references tbl_tag_rede_social(id),
    
    unique index(id),
    primary key(id)
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
    id_dados_jogador int not null,
    
    constraint FK_Perfil_Jogador
    foreign key (id_perfil)
    references tbl_perfil(id),
    
    constraint FK_DadosJogador_Jogador
    foreign key(id_dados_jogador)
    references tbl_dados_jogador(id),
    
    primary key(id),
    unique index(id)
    
);

create table tbl_tag_rede_social_jogador(
	id int not null auto_increment,
    id_jogador int not null,
    id_tag_rede_social int not null,
    
    constraint FK_Jogador_TagRedeSocialJogador
    foreign key (id_jogador)
    references tbl_jogador(id),
    
    constraint FK_TagRedeSocial_TagRedeSocialJogador
    foreign key (id_tag_rede_social)
    references tbl_tag_rede_social(id),
    
    unique index(id),
    primary key(id)
);

create table tbl_jogador_time(
	id int not null auto_increment,
    id_jogador int not null,
    id_time int not null,

	constraint FK_Jogador_JogadorTime
    foreign key(id_jogador)
    references tbl_jogador(id),
    
    constraint FK_Time_JogadorTime
    foreign key(id_time)
    references tbl_time(id),
    
    unique index(id),
    primary key(id)
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
    
    constraint FK_Organizador_Campeonato
    foreign key(id_organizador)
    references tbl_organizador(id),
    
    constraint FK_TitulosCampeonatos_Campeonato
    foreign key(id_titulos_campeonatos)
    references tbl_titulos_campeonatos(id),
    
    primary key(id),
    unique index(id)
    
);

create table tbl_tag_rede_social_campeonato(
	id int not null auto_increment,
    id_campeonato int not null,
    id_tag_rede_social int not null,
    
    constraint FK_Campeonato_TagRedeSocialCampeonato
    foreign key (id_campeonato)
    references tbl_campeonato(id),
    
    constraint FK_TagRedeSocial_TagRedeSocialCampeonato
    foreign key (id_tag_rede_social)
    references tbl_tag_rede_social(id),
    
    unique index(id),
    primary key(id)
);

create table tbl_campeonatos_organizadores(
	id int not null auto_increment,
    id_organizador int not null,
    id_campeonato int not null,
    
    constraint FK_Organizador_CampeonatosOrganizadores
    foreign key(id_organizador)
    references tbl_organizador(id),
    
    constraint FK_Campeonato_CampeonatosOrganizadores
    foreign key(id_campeonato)
    references tbl_campeonato(id),
    
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
	values("Masculino", "https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosGenero%2FiconeGeneroMasculino.png?alt=media&token=e6219e9d-55ad-4ca0-a12e-209afa0f14ad");
    
insert into tbl_genero (nome_genero, icone_genero)
	values("Feminino", "https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosGenero%2FiconeGeneroFeminino.png?alt=media&token=18aaa92e-e40e-4def-9652-36b85b12a862");

insert into tbl_genero (nome_genero, icone_genero)
	values("Indefinido", "https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosGenero%2FiconeGeneroIndefinido.png?alt=media&token=98738604-9e2b-4d06-95b0-2a7298e1e33e");
    
select * from tbl_genero;

### TESTE INSERT NA TABELA DE PERFIL
### ORGANIZADOR
insert into tbl_perfil (nome_usuario, nome_completo, email, senha, data_nascimento, foto_perfil, foto_capa, id_genero)
	values(
			"Gustavo", 
			"Gustavo Prevelate", 
			"guprevelate@gmail.com",  
			"12345678",  
			"2004-12-15",  
			"https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosPadraonizadas%2FfotoPadraoPerfilUsuario.png?alt=media&token=df04182f-35f3-4901-8b3a-c0d1501e2f58",  
			"https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosPadraonizadas%2FfotoCapaPadrao.png?alt=media&token=93f1229b-e007-45c1-bb7a-363ce09b9027",  
			1);
            
### JOGADOR
insert into tbl_perfil (nome_usuario, nome_completo, email, senha, data_nascimento, foto_perfil, foto_capa, id_genero)
	values(
			"Eduardo", 
			"Eduardo Ribeiro", 
			"eduardo@gmail.com",  
			"87654321",  
			"2004-09-08",  
			"https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosPadraonizadas%2FfotoPadraoPerfilUsuario.png?alt=media&token=df04182f-35f3-4901-8b3a-c0d1501e2f58",  
			"https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosPadraonizadas%2FfotoCapaPadrao.png?alt=media&token=93f1229b-e007-45c1-bb7a-363ce09b9027",  
			1);
            
select * from tbl_perfil;

### TESTE INSERT NA TABELA DE REDE SOCIAL
insert into tbl_rede_social (nome_rede_social, icone_rede_social)
	values("Facebook", "https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/redesSociais%2FiconeFacebook.png?alt=media&token=7467dbab-f5a4-41bc-af73-0ae0d4df0d8f");
    
insert into tbl_rede_social (nome_rede_social, icone_rede_social)
	values("Discord", "https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/redesSociais%2FiconeDiscord.png?alt=media&token=0fe1e30c-c8b6-46d7-bc3d-ec94a0d5ab38");
    
insert into tbl_rede_social (nome_rede_social, icone_rede_social)
	values("Instagram", "https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/redesSociais%2FiconeInstagram.png?alt=media&token=64d145e0-aef5-4c7c-95ee-4aa5d59a2996");
    
insert into tbl_rede_social (nome_rede_social, icone_rede_social)
	values("Twitter", "https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/redesSociais%2FiconeTwitter.png?alt=media&token=b4eb738d-82d0-4cf0-838a-082e5cb763b7");

insert into tbl_rede_social (nome_rede_social, icone_rede_social)
	values("Twitch", "https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/redesSociais%2FiconeTwitch.png?alt=media&token=56e0cedb-d818-49bf-9fd4-ac7f835312d1");
    
select * from tbl_rede_social;

### TESTE INSERT NA TABELA DE TAG DA REDE SOCIAL
insert into tbl_tag_rede_social (tag, id_rede_social)
	values("TesteLinkFacebook#@fa1562", "1");
    
insert into tbl_tag_rede_social (tag, id_rede_social)
	values("TesteLinkDiscord#5234", "2");

select * from tbl_tag_rede_social;

### TESTE INSERT NA TABELA DE ORGANIZADOR
insert into tbl_organizador (nome_organizacao, foto_organizacao, biografia, id_perfil)
	values(
			"Gustavo", 
			"https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosPadraonizadas%2FfotoPadraoPerfilUsuario.png?alt=media&token=df04182f-35f3-4901-8b3a-c0d1501e2f58", 
			"Biografia padrao",  
			1);
            
select * from tbl_organizador;

### TESTE INSERT NA TABELA DE TAG DA REDE SOCIAL ORGANIZADOR
insert into tbl_tag_rede_social_organizador (id_organizador, id_tag_rede_social)
	values("1", "2");
    
select * from tbl_tag_rede_social_organizador;

### TESTE INSERT NA TABELA DE JOGO
insert into tbl_jogo (nome_jogo, foto_jogo)
	values("League Of Legends", "https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosJogo%2FfotosJogo%2FfotoLOL.png?alt=media&token=4ecad36a-cfce-4f4b-a04b-fc1f602e1a1b");
    
insert into tbl_jogo (nome_jogo, foto_jogo)
	values("Counter Stricker Global Ofensive", "https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosJogo%2FfotosJogo%2FfotoCSGO.png?alt=media&token=3bfdd9f3-930b-46b5-bcad-ef4b37ef38fd");
    
insert into tbl_jogo (nome_jogo, foto_jogo)
	values("Valorant", "https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosJogo%2FfotosJogo%2FfotoValorant.png?alt=media&token=b9a16cc1-0394-4d2b-8e75-1942edf0a5bb");
    
select * from tbl_jogo;

### TESTE INSERT NA TABELA DE TIME
insert into tbl_time (nome_time, foto_time, foto_capa, biografia, id_jogo, id_organizador)
	values(
			"Time padrão", 
			"https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosPadraonizadas%2FfotoPadraoPerfilUsuario.png?alt=media&token=df04182f-35f3-4901-8b3a-c0d1501e2f58", 
			"https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosPadraonizadas%2FfotoCapaPadrao.png?alt=media&token=93f1229b-e007-45c1-bb7a-363ce09b9027",  
			"Biografia padrão",  
		    1,  
			1);
	
select * from tbl_time;

### TESTE INSERT NA TABELA DE TAG DA REDE SOCIAL TIME
insert into tbl_tag_rede_social_time (id_time, id_tag_rede_social)
	values("1", "2");
    
select * from tbl_tag_rede_social_time;

### TESTE INSERT NA TABELA DE FUNÇÃO JOGO
insert into tbl_funcao_jogo (foto_funcao, id_jogo)
	values("https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosJogo%2FfotosFuncoes%2FiconeADC.png?alt=media&token=23b354d5-d34c-42fa-a786-32b98577de05", "1");

insert into tbl_funcao_jogo (foto_funcao, id_jogo)
	values("https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosJogo%2FfotosFuncoes%2FiconeJungle.png?alt=media&token=9535260a-33a8-4558-89b4-2ac0c675d2c2", "1");

insert into tbl_funcao_jogo (foto_funcao, id_jogo)
	values("https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosJogo%2FfotosFuncoes%2FiconeMidLane.png?alt=media&token=1e76f4c8-f37b-48cd-a54e-718fb17acdc8", "1");
    
insert into tbl_funcao_jogo (foto_funcao, id_jogo)
	values("https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosJogo%2FfotosFuncoes%2FiconeSupport.png?alt=media&token=49de403d-e193-4ced-9ee6-89d2545b8baf", "1");
    
insert into tbl_funcao_jogo (foto_funcao, id_jogo)
	values("https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosJogo%2FfotosFuncoes%2FiconeTopLane.png?alt=media&token=7f506e08-e656-4265-975f-ba5a4e48ba35", "1");
    
select * from tbl_funcao_jogo;

### TESTE INSERT NA TABELA DE RANK JOGO
insert into tbl_rank_jogo (icone_rank, id_jogo)
	values("https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosJogo%2FfotosRank%2FiconeIron.png?alt=media&token=a04e9c08-22a8-43f1-b071-f418ed4b546a", "1");

insert into tbl_rank_jogo (icone_rank, id_jogo)
	values("https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosJogo%2FfotosRank%2FiconeBronze.png?alt=media&token=917fc331-3889-4a98-8e5e-919faa5358d5", "1");
    
insert into tbl_rank_jogo (icone_rank, id_jogo)
	values("https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosJogo%2FfotosRank%2FiconeSilver.png?alt=media&token=48d01edf-4d92-4ab8-8b2d-763a342682bf", "1");
    
insert into tbl_rank_jogo (icone_rank, id_jogo)
	values("https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosJogo%2FfotosRank%2FiconeGold.png?alt=media&token=1da37cea-cf0b-4d9d-84f1-343b9284cb37", "1");
    
insert into tbl_rank_jogo (icone_rank, id_jogo)
	values("https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosJogo%2FfotosRank%2FiconePlatinum.png?alt=media&token=e8400502-d64c-432a-a74a-f69e490e2ed1", "1");
    
insert into tbl_rank_jogo (icone_rank, id_jogo)
	values("https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosJogo%2FfotosRank%2FiconeDiamond.png?alt=media&token=1ac616f2-6dd8-4db3-809d-58a638bbcac0", "1");
    
insert into tbl_rank_jogo (icone_rank, id_jogo)
	values("https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosJogo%2FfotosRank%2FiconeMaster.png?alt=media&token=fe7fef4d-8953-49d0-a898-9e0f4abc7055", "1");
    
insert into tbl_rank_jogo (icone_rank, id_jogo)
	values("https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosJogo%2FfotosRank%2FiconeGrandmaster.png?alt=media&token=0a143ba3-7aec-40c4-aab3-5f5c13ab966a", "1");
    
insert into tbl_rank_jogo (icone_rank, id_jogo)
	values("https://firebasestorage.googleapis.com/v0/b/proliseum.appspot.com/o/fotosJogo%2FfotosRank%2FiconeChallenger.png?alt=media&token=9447d278-41be-4869-8eaf-9e37fe552fc3", "1");
    
select * from tbl_rank_jogo;

### TESTE INSERT NA TABELA DE RANK JOGO
insert into tbl_dados_jogador (id_funcao_jogo, id_rank_jogo)
	values("5", "5");
    


select * from tbl_dados_jogador;

### TESTE INSERT NA TABELA DE JOGADOR
insert into tbl_jogador (nickname, biografia, id_perfil, id_dados_jogador)
	values(
			"EduardoGamer", 
			"Biografia padrao",
            2,
			1);
		
select * from tbl_jogador;

### TESTE INSERT NA TABELA DE TAG DA REDE SOCIAL JOGADOR
insert into tbl_tag_rede_social_jogador (id_jogador, id_tag_rede_social)
	values("1", "2");
    
select * from tbl_tag_rede_social_jogador;

### TESTE DE INSERT DA TABELA INTERMEDIARIA ENTRE JOGADOR E TIME
insert into tbl_jogador_time(id_jogador, id_time)
	values(
			1,
            1);

select * from tbl_jogador_time;

##################### MANIPULAÇÃO DE SELECT 

SELECT tbl_perfil.id,
		tbl_perfil.nome_usuario,
		tbl_perfil.senha
FROM tbl_perfil where id = 1;

UPDATE tbl_perfil set senha = "1234" where id = 1;

###################################### INNER JOIN 

### INNER JOIN TABELA DE ORGANIZADOR
SELECT tbl_organizador.id,
		tbl_organizador.nome_organizacao,
		tbl_organizador.foto_organizacao,
        tbl_organizador.biografia,
        tbl_perfil.nome_usuario,
        tbl_perfil.nome_completo,
        tbl_perfil.email,
        tbl_perfil.senha,
        tbl_perfil.data_nascimento,
        tbl_perfil.foto_perfil,
        tbl_perfil.foto_capa,
        tbl_genero.nome_genero,
        tbl_genero.icone_genero,
        tbl_tag_rede_social.tag,
        tbl_rede_social.nome_rede_social,
        tbl_rede_social.icone_rede_social
FROM tbl_organizador
INNER JOIN tbl_perfil
		ON tbl_organizador.id = tbl_perfil.id
INNER JOIN tbl_genero
		ON tbl_perfil.id = tbl_genero.id
INNER JOIN tbl_tag_rede_social_organizador
        ON tbl_organizador.id = tbl_tag_rede_social_organizador.id
INNER JOIN tbl_tag_rede_social
		ON tbl_tag_rede_social_organizador.id = tbl_tag_rede_social.id
INNER JOIN tbl_rede_social
		ON tbl_tag_rede_social.id = tbl_rede_social.id;
        
### INNER JOIN TABELA JOGADOR

SELECT tbl_jogador.id,
    tbl_jogador.nickname,
    tbl_jogador.biografia,
    tbl_perfil.nome_usuario,
    tbl_perfil.nome_completo,
    tbl_perfil.email,
    tbl_perfil.senha,
    tbl_perfil.data_nascimento,
    tbl_perfil.foto_perfil,
    tbl_perfil.foto_capa,
    tbl_genero.nome_genero,
    tbl_genero.icone_genero,
    tbl_tag_rede_social.tag,
    tbl_rede_social.nome_rede_social,
    tbl_rede_social.icone_rede_social
FROM tbl_jogador
LEFT JOIN tbl_perfil
    ON tbl_jogador.id = tbl_perfil.id
LEFT JOIN tbl_genero
    ON tbl_perfil.id = tbl_genero.id
LEFT JOIN tbl_tag_rede_social_jogador
    ON tbl_jogador.id = tbl_tag_rede_social_jogador.id
LEFT JOIN tbl_tag_rede_social
	ON tbl_tag_rede_social_jogador.id = tbl_tag_rede_social.id
LEFT JOIN tbl_rede_social
    ON tbl_tag_rede_social.id = tbl_rede_social.id;
    
