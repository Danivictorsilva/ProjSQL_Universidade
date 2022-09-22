/* Criacao Database */
create database Universidade;
use Universidade;
go

/* Criacao tabelas */
create table Aluno (
	RA int not null primary key,
	Nome varchar(50) not null
);
go

create table Disciplina (
	Sigla char(3) not null primary key,
	Nome varchar(50) not null,
	CargaHoraria int not null
);
go

create table Matricula (
	RA int not null,
	Sigla char(3) not null,
	Data_Ano int not null,
	Data_Semestre int not null,
	Falta int null,
	Nota_N1 float,
	Nota_N2 float,
	Nota_Sub float,
	Nota_Media float,
	Frequencia float,
	Situacao bit,

	constraint FK_Aluno_Matricula foreign key (RA) references Aluno(RA),
	constraint FK_Disciplina_Matricula foreign key (Sigla) references Disciplina(Sigla),
	constraint PK_Matricula primary key (RA, Sigla, Data_Ano, Data_Semestre)
);
go

/* Criacao Triggers */
create trigger TGR_Master
on Matricula
for update
as
begin
	declare
		@RA int,
		@Nota_N2 float,
		@Sigla char(3),
		@CH int,
		@Faltas int,
		@Media float,
		@Freq float

	select @RA = RA from inserted
	select @Nota_N2 = Nota_N2 from inserted
	select @Sigla = Sigla from Inserted
	select @CH = CargaHoraria from Disciplina
	select @Faltas = Falta from inserted
	select @Media = Nota_Media from inserted
	select @Freq = Frequencia from inserted


	if @Nota_N2 is not null
	begin
		update Matricula
		set Nota_Media = (Nota_N1 + Nota_N2)/2
		where RA = @RA
	end
	if @Faltas is not null
	begin
		update Matricula 
		set Frequencia = 100 * (@CH - Falta) / @CH
		where RA = @RA
	end
	if @Media is not null and @Freq is not null
	begin
		if @Media > 5 and @Freq > 25
		begin
			update Matricula 
			set Situacao = 1
			where RA = @RA
		end
		else
		begin
			update Matricula 
			set Situacao = 0
			where RA = @RA
		end 
	end
end
go

/* Insert de dados */
insert into Aluno (RA, Nome)
values
	(1, 'Daniel'),
	(2, 'Gabriel'),
	(3, 'Arthur'),
	(4, 'Gustavo'),
	(5, 'Ricardo'),
	(6, 'Vinius'),
	(7, 'Rafael'),
	(8, 'Leticia'),
	(9, 'Bruno'),
	(10, 'Enzo');
go

insert into Disciplina(Sigla, Nome, CargaHoraria)
values
	('CA2', 'Calculo II', 100),
	('CIA', 'Circuitos Analogicos', 100),
	('CID', 'Circuitos Digitais', 100),
	('ESD', 'Estrutura de Dados', 100),
	('FI2', 'Fisica II', 100),
	('FET', 'Fenomenos Transporte', 100),
	('MAC', 'Matematica Computacional', 100),
	('MEG', 'Mecanica Geral', 100),
	('REM', 'Resistencia dos Materiais', 100),
	('DET', 'Desenho Tecnico', 100);
go

insert into Matricula (RA, Sigla, Data_Ano, Data_Semestre, Falta)
values 
	(1, 'FET', 2021, 1, 0),
	(2, 'REM', 2021, 1, 0),
	(3, 'DET', 2021, 2, 0),
	(4, 'FET', 2021, 1, 0),
	(5, 'CID', 2021, 2, 0),
	(6, 'MEG', 2021, 1, 0),
	(7, 'ESD', 2021, 2, 0),
	(8, 'CIA', 2021, 1, 0),
	(9, 'DET', 2021, 2, 0),
	(10, 'MAC', 2021, 1, 0);
go


/* Update Notas primeiro semestre */
update Matricula
set Nota_N1 = 3.5
where RA = 1;
go
update Matricula
set Nota_N1 = 8.5
where RA = 2;
go
update Matricula
set Nota_N1 = 4.0
where RA = 3;
go
update Matricula
set Nota_N1 = 4.0
where RA = 4;
go
update Matricula
set Nota_N1 = 8.5
where RA = 5;
go
update Matricula
set Nota_N1 = 2.0
where RA = 6;
go
update Matricula
set Nota_N1 = 1.0
where RA = 7;
go
update Matricula
set Nota_N1 = 8.5
where RA = 8;
go
update Matricula
set Nota_N1 = 4.5
where RA = 9;
go
update Matricula
set Nota_N1 = 9.0
where RA = 10;
go


/* Update Notas segundo semestre */
update Matricula
set Nota_N2 = 4.5
where RA = 1;
go
update Matricula
set Nota_N2 = 8.0
where RA = 2;
go
update Matricula
set Nota_N2 = 3.5
where RA = 3;
go
update Matricula
set Nota_N2 = 6.5
where RA = 4;
go
update Matricula
set Nota_N2 = 5.0
where RA = 5;
go
update Matricula
set Nota_N2 = 3.5
where RA = 6;
go
update Matricula
set Nota_N2 = 10.0
where RA = 7;
go
update Matricula
set Nota_N2 = 8.5
where RA = 8;
go
update Matricula
set Nota_N2 = 1.5
where RA = 9;
go
update Matricula
set Nota_N2 = 5.5
where RA = 10;
go


/* Update Faltas */
update Matricula
set Falta = 45
where RA = 1;
go
update Matricula
set Falta = 25
where RA = 2;
go
update Matricula
set Falta = 51
where RA = 3;
go
update Matricula
set Falta = 92
where RA = 4;
go
update Matricula
set Falta = 75
where RA = 5;
go
update Matricula
set Falta = 47
where RA = 6;
go
update Matricula
set Falta = 22
where RA = 7;
go
update Matricula
set Falta = 84
where RA = 8;
go
update Matricula
set Falta = 35
where RA = 9;
go
update Matricula
set Falta = 25
where RA = 10;
go

/* Vizualizar a tabela matricula */
select RA, Sigla, Data_Ano, Data_Semestre, Falta, Nota_N1, Nota_N2, Nota_Sub, Nota_Media, Frequencia 'Frequencia (%)', Situacao
from Matricula;
go

/*Consulta 1:  Alunos de uma determinada disciplina */
select a.RA, a.Nome, m.Nota_N1, m.Nota_N2, m.Nota_Media, m.Frequencia, m.Situacao 
from Aluno a join Matricula m on m.RA = a.RA and m.Sigla = 'MEG'

/*Consulta 2: Disciplinas de um determinado Aluno no 2° semestre */
select a.RA, a.Nome, m.Nota_N1, m.Nota_N2, m.Nota_Media, m.Frequencia, m.Situacao 
from Aluno a join Matricula m on m.RA = a.RA and m.RA = 3 and m.Data_Semestre = 2

/*Consulta 3:  Alunos reprovados por nota */
select a.RA, a.Nome, d.Nome, m.Nota_N1, m.Nota_N2, m.Nota_Media
from Aluno a join Matricula m on m.RA = a.RA and m.Nota_Media < 5
	join Disciplina d on m.Sigla = d.Sigla
