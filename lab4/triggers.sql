drop trigger if exists shopping_cart_updater;
create  trigger shopping_cart_updater 
    after insert on orders
    for each row
    begin
        insert into shopping_cart(customer_id, order_id)
        values(new.customer_id, new.order_id);
    end;



drop trigger if exists book_quanity_updater;
create trigger book_quanity_updater
    before update on orders
    for each row
    begin
        if(new.isConfirmed = 1) then
            if(old.required_date is null) then
                set new.required_date = date_add(now(), interval 3 day);
            end if;

            update product_branch
            set quantity = quantity - new.quantity
            where product_id = new.product_id;

            if(select quantity from product_branch where product_id = new.product_id) < 1 then
                delete from product_branch where product_id = new.product_id;
            end if;

            update products
            set quantity = quantity - new.quantity
            where product_id = new.product_id;

            delete from shopping_cart 
            where customer_id = new.customer_id;
        end if;

    end;

drop trigger if exists create_order_date;
create trigger create_order_date
    before insert on orders
    for each row
    begin
        set new.order_date = now();
        set new.price = (select price from products where product_id = new.product_id) * new.quantity;
    end;
