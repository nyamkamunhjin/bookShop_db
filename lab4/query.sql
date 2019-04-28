-- select * from customers;
-- select * from branch;
-- select * from product_branch;
-- select * from category;
-- select * from products;
-- select * from shopping_cart;
-- select * from orders;

drop trigger if exists customer_id_auto_increment;

create trigger customer_id_auto_increment
    before insert on customers
    for each row
    begin
        if((select customer_id from customers limit 1) is null) then
            set new.customer_id = 'c0';
        else
            if((select email from customers order by customer_id desc limit 1) = new.email) then
                signal sqlstate  '45000'
                set message_text = 'This email already registered';
            else
                set @id = (select substring((select customer_id from customers order by customer_id desc limit 1), 2, 5));

                set new.customer_id = concat('c', (select cast(@id as unsigned) + 1));
            end if;
        end if;
    end;

create trigger branch_id_auto_increment
    before insert on branch
    for each row
    begin
        if((select branch_id from branch limit 1) is null) then
            set new.branch_id = 'b0';
        else
            if((select branch_name from branch order by branch_id desc limit 1) = new.branch_name) then
                signal sqlstate  '45000'
                set message_text = 'This branch already registered';
            else
                set @id = (select substring((select branch_id from branch order by branch_id desc limit 1), 2, 5));

                set new.branch_id = concat('b', (select cast(@id as unsigned) + 1));
            end if;
        end if;
    end;