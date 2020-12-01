drop schema bowling cascade;
create schema if not exists bowling;
-- Alley Table 
set search_path to 'bowling';
create table if not exists bowling.Alley (
PhoneNum varchar(15),
Name varchar(100) not null,
constraint pk_Alley primary key (PhoneNum)
--constraint uk_Alley_Name unique (Name)
);
insert into bowling.Alley (PhoneNum, Name)
    values ('763-503-2695', 'Brunswick Zone Brooklyn Park');
    
-- Game Table     
create table if not exists bowling.Game (
AlleyPhoneNum varchar(15),
Time varchar(100),
LaneNum varchar(3),
constraint pk_Game primary key (AlleyPhoneNum, Time, LaneNum),
constraint fk_Game_AlleyPhoneNum foreign key (AlleyPhoneNum) references bowling.Alley(PhoneNum)
);
insert into bowling.Game (AlleyPhoneNum, Time, LaneNum)
    values ('763-503-2695', '1567952467', '43');
    
-- Line Table 
create table if not exists bowling.Line (
GameAlleyPhoneNum varchar(15),
GameTime varchar(100),
GameLaneNum varchar(3),
PlayerNum varchar(2),
PlayerName varchar(20) not null,
constraint pk_Line primary key (GameAlleyPhoneNum, GameTime, GameLaneNum, PlayerNum),
--constraint uk_Line_PlayerName unique (PlayerName),
constraint fk_Line foreign key (GameAlleyPhoneNum, GameTime, GameLaneNum) references bowling.Game(AlleyPhoneNum, Time, LaneNum)
);
insert into bowling.Line values
('763-503-2695','1567952467', 43, 2, 'MADDIE'),
('763-503-2695','1567952467', 43, 1, 'COOPER'),
('763-503-2695','1567952467', 43, 3, 'DAD');

--Frame Table
create table if not exists bowling.Frame (
LineAlleyPhoneNum varchar(15),
LineGameTime varchar(100),
LineGameLaneNum varchar(3),
LinePlayerNum varchar(2),
FrameNum int not null,
Roll1Score int not null,
Roll2Score int,
Roll3Score int,
isSplit varchar(5),
constraint pk_Frame primary key (LineAlleyPhoneNum, LineGameTime, LineGameLaneNum, LinePlayerNum, FrameNum),
--constraint uk_Frame_Roll1Score unique (Roll1Score),
--constraint uk_Frame_Roll2Score unique (Roll2Score),
--constraint uk_Frame_Roll3Score unique (Roll3Score),
--constraint uk_Frame_isSplit unique (isSplit),
constraint fk_Frame foreign key (LineAlleyPhoneNum, LineGameTime, LineGameLaneNum, LinePLayerNum) references bowling.Line(GameAlleyPhoneNum, GameTime, GameLaneNum, PlayerNum)
);
insert into bowling.Frame values
('763-503-2695','1567952467', 43, 2, 2, 0, 9, NULL, FALSE),
('763-503-2695','1567952467', 43, 2, 8, 10, NULL, NULL, FALSE),
('763-503-2695','1567952467', 43, 1, 6, 8, 0, NULL, TRUE),
('763-503-2695','1567952467', 43, 3, 10, 10, 8, 0, FALSE),
('763-503-2695','1567952467', 43, 1, 1, 3, 7, NULL, FALSE);

drop schema menu cascade;
create schema if not exists menu;
-- Menu Table
set search_path to 'menu';
create table if not exists menu.Menu (
Restaurant_Name varchar(100),
URL varchar(100) not null,
description varchar(100) not null,
constraint pk_Menu primary key (Restaurant_Name)
--constraint uk_Menu_URL unique (URL),
--constraint uk_Menu_description unique (description)
);
insert into menu.Menu (Restaurant_Name, URL, description)
    values ('Sally''s', 'https://sallyssaloon.net/menu/', 'Thanks for dining with us! 700 Wash Ave');
    
--Category Table 
create table if not exists menu.Category (
R_name varchar(100),
Name varchar(50),
Description varchar(100),
constraint pk_Category primary key (R_name, Name),
--constraint uk_Category_Description unique (Description),
constraint fk_Category_R_name foreign key (R_name) references menu.Menu(Restaurant_Name)
);
insert into menu.Category values
('Sally''s', 'Appetizers', NULL),
('Sally''s', 'Sandwiches & Wraps', 'Served with kettle chips (unless otherwise noted)'),
('Sally''s', 'Saloon Daily Specials', 'Subject to change on Event Days.');

-- Upgrade Table 
create table if not exists menu.Upgrade (
R_Name varchar(100),
Name varchar(50),
Cost varchar(20) not null,
constraint pk_Upgrade primary key (R_Name, Name),
--constraint uk_Upgrade_Cost unique (Cost),
constraint fk_Upgrade_R_Name foreign key (R_Name) references menu.Menu(Restaurant_Name)
);
insert into menu.Upgrade values
('Sally''s', 'Fries', 2),
('Sally''s', 'Tater Tots', 2),
('Sally''s', 'House Salad', 3),
('Sally''s', 'Cup of Soup', 3),
('Sally''s', 'Chicken', 1),
('Sally''s', 'Taco beef', 1);

-- Dish Table 
create table if not exists menu.Dish (
R_name varchar(100),
CategoryName varchar(50),
Title varchar(50),
Description varchar(50),
Option varchar(100),
constraint pk_Dish primary key (R_name, CategoryName, Title),
--constraint uk_Dish_Description unique (Description),
--constraint uk_Dish_Option unique (Option),
constraint fk_Dish foreign key (R_name, CategoryName) references menu.Category(R_name, Name)
);
insert into menu.Dish values
('Sally''s', 'Appetizers', 'Sally"s Wings', 'oven baked...bleu cheese.', NULL),
('Sally''s', 'Appetizers', 'Nachos', 'cheese...friendly', NULL),
('Sally''s', 'Sandwiches & Wraps', 'Smoked Pork Sandwich', 'smoked...bun.', NULL),
('Sally''s', 'Saloon Daily Specials', 'Street Taco Tuesday', NULL, NULL);

-- Dish Price Table 
create table if not exists menu.DishPrice (
R_name varchar(100),
CategoryName varchar(50),
DishTitle varchar(50),
Size varchar(50),
Cost varchar(20) not null,
constraint pk_DishPrice primary key (R_name, CategoryName, DishTitle, Size),
--constraint uk_DishPrice_Cost unique (Cost),
constraint fk_DishPrice foreign key (R_name, CategoryName, DishTitle) references menu.Dish(R_name, CategoryName, Title)
);
insert into menu.DishPrice values
('Sally''s', 'Appetizers', 'Sally"s Wings', '6 pc', 7),
('Sally''s', 'Appetizers', 'Sally"s Wings', '12 pc', 12),
('Sally''s', 'Appetizers', 'Nachos', '', 12),
('Sally''s', 'Sandwiches & Wraps', 'Smoked Pork Sandwich','', 10),
('Sally''s', 'Saloon Daily Specials', 'Street Taco Tuesday','', 5);

-- Special Table 
create table if not exists menu.Special (
R_name varchar(100),
CategoryName varchar(50),
DishTitle varchar(50),
weekDay varchar(20) not null,
startTime varchar(20) not null,
endTime varchar(20) not null,
constraint pk_Special primary key (R_name, CategoryName, DishTitle),
--constraint uk_Special_weekDay unique (weekDay),
--constraint uk_Special_startTime unique (startTime),
--constraint uk_Special_endTime unique (endTime),
constraint fk_Special foreign Key (R_name, CategoryName, DishTitle) references menu.Dish(R_name, CategoryName, Title)
--Foreign Relation to Category is implied through Dish Relation
);
insert into Special (R_name, CategoryName, DishTitle, weekDay, startTime, endTime) 
	values ('Sally''s', 'Saloon Daily Specials', 'Street Taco Tuesday', 'Tuesday', '5pm', 'Midnight');

-- CategoryUpgrade 
create table if not exists menu.CategoryUpgrade (
R_name varchar(100),
CategoryName varchar(50),
UpgradeName varchar(50),
constraint pk_CategoryUpgrade primary key (R_name, CategoryName, UpgradeName),
constraint fk_Category foreign key (R_name, CategoryName) references menu.Category(R_name, Name),
constraint fk_Upgrade foreign key (R_name, UpgradeName) references menu.Upgrade(R_name, Name)
);
insert into CategoryUpgrade values
('Sally''s', 'Sandwiches & Wraps', 'Tater Tots'),
('Sally''s', 'Sandwiches & Wraps', 'House Salad');

-- DishUpgrade 
create table if not exists menu.DishUpgrade (
R_name varchar(100),
CategoryName varchar(50),
DishTitle varchar(50),
UpgradeName varchar(50),
constraint pk_DishUpgrade primary key (R_name, CategoryName, DishTitle, UpgradeName),
constraint fk_Dish foreign key (R_name, CategoryName, DishTitle) references menu.Dish(R_name, CategoryName, Title),
constraint fk_Upgrade foreign key (R_name, UpgradeName) references menu.Upgrade(R_name, Name)
);
insert into DishUpgrade values
('Sally''s', 'Appetizers', 'Nachos', 'Chicken'),
('Sally''s', 'Appetizers', 'Nachos', 'Taco beef');
