create database trigger_demo;
use trigger_demo;
-- tạo bảng product
create table product(
	product_id char(5) primary key,
    product_name varchar(50) not null,
    price float not null
);
-- tạo trigger before insert
delimiter //
create trigger before_insert_product before insert on product for each row
begin
	if(new.price < 0) then
    SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'Bạn sắp insert giá nhỏ hơn không';
    end if;
end //
delimiter ;
select * from product;
insert into product
values ("P0003","Quan Ao",-10);
-- tạo trigger before update
delimiter //
create trigger before_update_product before update on product for each row
begin
	if(new.price < 0) then
	set new.price = 0 ;
    end if;
end //
delimiter ;
 drop trigger before_update_product;
update product
set product_name = "Gay Dep",
	price = -100
where product_id = "P0002";