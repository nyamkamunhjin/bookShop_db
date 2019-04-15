
/* exercise 1 and 3 */
-- 1. Ажилтны дэлгэрэнгүй мэдээллийг хэвлэж гаргах stored procedure бич
-- 3. Өмнөх (1) гэсэн даалгавраар хийсэн stored procedure өмнө нь өгөгдлийн санд
-- үүссэн бол устгаад шинээр үүсгэдэг байхаар (1) гэсэн stored procedure-ийн
-- кодыг өөрчил
drop procedure if exists showEmployeeInfo;

create procedure showEmployeeInfo()
    begin
        select * 
        from Employees;
    end;
call showEmployeeInfo();


/* exercise 2 */
-- 2. 1998 оны шилдэг ажилтанг захиалга хүргэж өгсөн тоо, хүргэж өгдөг дундаж
-- хугацаагаар нь шалгаруулан олох stored procedure бич
drop procedure if exists showEmpOfTheYear;
create procedure showEmpOfTheYear()
    begin
        select 
            o.EmployeeID, 
            e.LastName, 
            e.FirstName, 
            count(o.EmployeeID) as delivery,
            avg(datediff(o.ShippedDate, o.OrderDate)) as avgTime
        from 
            Orders o
            inner join Employees e
                on o.EmployeeID = e.EmployeeID
        where 
            o.ShippedDate like '1998%' 
        group by 
            o.EmployeeID
        order by 
            delivery desc, avgTime asc;

    end;
call showEmpOfTheYear;

/* exercise 4 */
-- 4. Оны шилдэг захиалагчийг өөрийн сонгон шалгаруулалтаар олох stored procedure бич
drop procedure if exists customerOfTheYear;
create procedure customerOfTheYear (
    in year varchar(4)
)
begin
    select 
        CustomerID,
        count(CustomerID) as OrderCount
    from 
        Orders
    where 
        OrderDate like concat(year,'%')
    group by 
        CustomerID
    order by 
        OrderCount desc
    limit 1;
end;
call customerOfTheYear(1997);

/* exercise 5 */
-- 5. (4) даалгавраар хийсэн stored procedure ашиглан бүх оны шилдгийн шилдэг
-- захиалагчийн тухай мэдээллийг хэвлэж гаргах stored procedure бич.
drop procedure if exists customerOfTheAllInfo;
create procedure customerOfTheAllInfo ()
begin
    select 
        o.CustomerID,
        c.*,
        count(o.CustomerID) as OrderCount
    from 
        Orders o
        right join Customers c
            on o.CustomerID = c.CustomerID
    where 
        OrderDate like concat('%', 199, '%')
    group by 
        o.CustomerID
    order by 
        OrderCount desc;
end;
call customerOfTheAllInfo();

/* exercise 6 */
-- 6. Хамгийн их орлого оруулсан үйлчлүүлэгчдийг нийт орлогын 3 хувьтай
-- тэнцэх мөнгийг олгохоор болжээ. Энэ жагсаалтыг үйлчлүүлэгчийн нэр, орлогын
-- нийт мөнгөн дүн, 3 хувьтай тэнцэх мөнгөн дүн зэргээр хэвлэж гаргах stored procedure бич.
drop procedure if exists bonus;
create procedure bonus()
    begin
        select
            CustomerID, 
            ShipName,  
            ExtendedPrice,
            (ExtendedPrice / 100 * 3) as bonus
        from 
            Invoices
        order by ExtendedPrice desc
        limit 5;
    end;
call bonus();


