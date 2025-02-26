



CREATE TABLE Ogretmen(
OgretmenId int PRIMARY KEY,
Ad varchar(50) NOT NULL,
Soyad varchar(50) NOT NULL,
Brans varchar(50),
Email varchar(100),
Telefon varchar(15))

CREATE TABLE DERS(
DersID int PRIMARY KEY NOT NULL,
DersAdi varchar(100)NOT NULL,
Kredi  int ,
Bolum  varchar(50) ,
OgretmenId int NOT NULL,
FOREIGN KEY(OgretmenId)REFERENCES Ogretmen(OgretmenId))








CREATE TABLE Ogrenci(
OgrenciID int PRIMARY KEY NOT NULL,
Ad varchar(50) NOT NULL,
Soyad varchar(50) NOT NULL,
DogumTarihi date ,
Cinsiyet char(1) ,
Telefon varchar(15) ,
Email varchar(100) 	,
Adres varchar(255) )



CREATE TABLE SinavSonuclari(
SonucID int Primary key,
OgrenciID int NOT NULL,
DersID int NOT NULL,
SinavTarihi date,
Puan int,
FOREIGN KEY(OgrenciID) REFERENCES Ogrenci(OgrenciID),
FOREIGN KEY(DersID) REFERENCES DERS(DersID))

