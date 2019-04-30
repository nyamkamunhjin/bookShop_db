-- new triggers 
-- auto increment ids triggers
drop trigger if exists customer_id_auto_increment;

create trigger customer_id_auto_increment
    before insert on customers
    for each row
    begin
        if((select customer_id from customers limit 1) is null) then
            set new.customer_id = 'c0';
        else
            if((select email from customers where email = new.email limit 1) is not null) then
                signal sqlstate  '45000'
                set message_text = 'This email already registered';
            else
                set @id = (select max(cast(substring(customer_id, 2, 5) as unsigned)) from customers);

                set new.customer_id = concat('c', (select cast(@id as unsigned) + 1));
            end if;
        end if;
    end;

drop trigger if exists branch_id_auto_increment;
create trigger branch_id_auto_increment
    before insert on branch
    for each row
    begin
        if((select branch_id from branch limit 1) is null) then
            set new.branch_id = 'b0';
        else
            if((select branch_name from branch where branch_name = new.branch_name limit 1) is not null) then
                signal sqlstate  '45000'
                set message_text = 'This branch already registered';
            else
                set @id = (select max(cast(substring(branch_id, 2, 5) as unsigned)) from branch);

                set new.branch_id = concat('b', (select cast(@id as unsigned) + 1));
            end if;
        end if;
    end;

drop trigger if exists address_id_auto_increment;
create trigger address_id_auto_increment
    before insert on shipping_addresses
    for each row
    begin
        if((select address_id from shipping_addresses limit 1) is null) then
            set new.address_id = 'a0';
        else
            if((select ship_address from shipping_addresses where ship_address = new.ship_address limit 1) is not null) then
                signal sqlstate  '45000'
                set message_text = 'This shipping_address already registered';
            else
                set @id = (select max(cast(substring(address_id, 2, 5) as unsigned)) from shipping_addresses);

                set new.address_id = concat('a', (select cast(@id as unsigned) + 1));
            end if;
        end if;
    end;

drop procedure if exists shopping_cart_updater;
create procedure shopping_cart_updater(
    in customer_id_in varchar(5),
    in product_id_in varchar(5),
    in address_id_in varchar(5),
    in quantity_in int
)
    begin
        update shopping_cart 
        set quantity = (select quantity where customer_id = customer_id_in and product_id = product_id_in and address_id = address_id_in) + quantity_in
        where customer_id = customer_id_in and product_id = product_id_in and address_id = address_id_in;
    end;

drop trigger if exists cart_id_auto_increment;
create trigger cart_id_auto_increment
    before insert on shopping_cart
    for each row
    begin
        if((select cart_id from shopping_cart limit 1) is null) then
            set new.cart_id = 's0';
            set new.isOrdered = 0;
        else -- if customer adds same product to the cart add quantity 
            set @current_quantity = (select quantity from shopping_cart where customer_id = new.customer_id and product_id = new.product_id and address_id = new.address_id limit 1);

            if(@current_quantity is not null) then
                signal sqlstate  '45000'
                set message_text = 'This item already registered';
            else
                set @id = (select max(cast(substring(cart_id, 2, 5) as unsigned)) from shopping_cart);

                set new.cart_id = concat('s', (select cast(@id as unsigned) + 1));
                set new.isOrdered = 0;
            end if;
        end if;
    end;

drop trigger if exists product_id_auto_increment;
create trigger product_id_auto_increment
    before insert on products
    for each row
    begin
        if((select product_id from products limit 1) is null) then
            set new.product_id = 'p0';
        else
            if((select product_name from products where product_name = new.product_name limit 1) is not null) then
                signal sqlstate  '45000'
                set message_text = 'This product already registered';
            else
                set @id = (select max(cast(substring(product_id, 2, 5) as unsigned)) from products);

                set new.product_id = concat('p', (select cast(@id as unsigned) + 1));
            end if;
        end if;
    end;

drop trigger if exists category_id_auto_increment;
create trigger category_id_auto_increment
    before insert on category
    for each row
    begin
        if((select category_id from category limit 1) is null) then
            set new.category_id = 'ca0';
        else
            if((select name from category where name = new.name limit 1) is not null) then
                signal sqlstate  '45000'
                set message_text = 'This category already registered';
            else
                set @id = (select max(cast(substring(category_id, 3, 5) as unsigned)) from category);

                set new.category_id = concat('ca', (select cast(@id as unsigned) + 1));
            end if;
        end if;
    end;

drop trigger if exists order_id_auto_increment;
create trigger order_id_auto_increment
    before insert on orders
    for each row
    begin
        if((select order_id from orders limit 1) is null) then
            set new.order_id = 'o0';
        else
            if((select cart_id from orders where cart_id = new.cart_id limit 1) is not null) then
                signal sqlstate  '45000'
                set message_text = 'This order already registered';
            else
                set @id = (select max(cast(substring(order_id, 2, 5) as unsigned)) from orders);

                set new.order_id = concat('o', (select cast(@id as unsigned) + 1));
            end if;
        end if;
    end;

drop trigger if exists blog_id_auto_increment;
create trigger blog_id_auto_increment
    before insert on blog
    for each row
    begin
        if((select blog_id from blog limit 1) is null) then
            set new.blog_id = 'bl0';
        else
            if((select blog_name from blog where blog_name = new.blog_name limit 1) is not null) then
                signal sqlstate  '45000'
                set message_text = 'This blog already registered';
            else
                set @id = (select max(cast(substring(blog_id, 3, 5) as unsigned)) from blog);

                set new.blog_id = concat('bl', (select cast(@id as unsigned) + 1));
            end if;
        end if;
    end;

drop trigger if exists publisher_id_auto_increment;
create trigger publisher_id_auto_increment
    before insert on publisher
    for each row
    begin
        if((select publisher_id from publisher limit 1) is null) then
            set new.publisher_id = 'pu0';
        else
            if((select publisher_name from publisher where publisher_name = new.publisher_name limit 1) is not null) then
                signal sqlstate  '45000'
                set message_text = 'This publisher already registered';
            else
                set @id = (select max(cast(substring(publisher_id, 3, 5) as unsigned)) from publisher);

                set new.publisher_id = concat('pu', (select cast(@id as unsigned) + 1));
            end if;
        end if;
    end;

-- order being created from shopping_cart isOrdered = 1
drop trigger if exists order_creater;
create trigger order_creater
after update on shopping_cart
for each row
    begin
        if(new.isOrdered = 1) then
            insert into orders(cart_id, payment_type)
            values(new.cart_id, 1);
        end if;
    end;

-- order auto date and price
drop trigger if exists order_auto_value;
create trigger order_auto_value
    before insert on orders
    for each row
    begin
        -- create date 
        set new.order_date = now();
        set new.required_date = date_add(now(), interval 3 day);

        set @temp_quantity = (select quantity from shopping_cart where new.cart_id = cart_id);
        -- calculate payment price for order
        set new.total_price = @temp_quantity * (select price from products where product_id = (select product_id from shopping_cart where new.cart_id = cart_id));

        -- subtract ordered quantity of products
        update products
        set reserved_quantity = reserved_quantity - @temp_quantity
        where product_id = (select product_id from shopping_cart where new.cart_id = cart_id);
    end;