-- criação do banco de dados biblioteca
create database biblioteca;
use biblioteca;

-- criação da tabela livros

CREATE TABLE livros (
titulo text,
autor text,
ISBN varchar (50),
edicao varchar (50),
editora varchar(50),
anoPublicacao year,
qtdePaginas int,
genero ENUM ('poesia', 'soneto', 'romance', 'fábula', 'novela', 'cronica', 'conto', 'ensaio', 'biografia', 'chicklit', 'fantasia', 'distopia', 'ficcao cientifica', 'horror', 'fantastica', 'infanto juvenil', 'young adult', 'suspense', 'autoajuda', 'negocios', 'tecnologia', 'hq', 'aventura'),
idioma varchar(50),
quantidade INT,
disponivel int);

desc livros;

INSERT INTO livros (titulo, autor, isbn, edicao, editora, anoPublicacao, qtdePaginas, genero, idioma, quantidade) VALUES ('orgulho e preconceito', 'jane austen', 978-8544001820, 'luxo', 'martin claret', 2018, 424, 'romance', 2);
INSERT INTO livros (titulo, autor, isbn, edicao, editora, anoPublicacao, qtdePaginas, genero, idioma, quantidade, disponivel) VALUES ('orgulho e preconceito', 'jane austen', '978-8544001820', 'luxo', 'martin claret', 2018, 424, 'romance', 'portugues', 2, 2);

SELECT * FROM livros;

INSERT INTO livros (titulo, autor, isbn, edicao, editora, anoPublicacao, qtdePaginas, genero, idioma, quantidade, disponivel) VALUES ('O maravilhoso mágico de Oz', 'L. Frank Baum', '9788596004329', 'slim', 'Salamandra', 2002, 324, 'fantasia', 'portugues', 4, 3),
('O pequeno príncipe', 'Antoine de Saint-Exupéry', '9788516084936', 'pocket', 'FTD', 2010, 124, 'aventura', 'portugues', 5, 5),
('Confissões de um vira-lata', 'Orígenes Lessa', '9788526016866', 'economico', 'FTD', 2020, 200, 'infanto juvenil', 'portugues', 3, 3),
('Vendedor de sustos', 'João Anzanello Carrascoza', '9788532292827', 'brochura', 'FTD', 2005, 115, 'suspense', 'portugues', 10, 6),
('O anjo linguarudo', 'Walcyr Carrasco', '8516023168', 'slim', 'Moderna', 2015, 225, 'ficcao cientifica', 'portugues', 9, 8),
('Mau começo', 'Lemony Snicket', '9788535900941', 'capa dura', 'Seguinte', 2010, 325, 'soneto', 'portugues', 7, 6),
('O Gato Malhado e a Andorinha Sinhá ', 'Jorge Amado', '9788574063423', 'luxo', 'Companhia Das Letrinhas', 2016, 305, 'fábula', 'portugues', 8, 6);

SELECT * FROM livros;

SELECT * from livros WHERE genero='suspense' AND disponivel>0;

SELECT titulo, autor, disponivel FROM livros WHERE genero='fantasia' AND disponivel>0;
