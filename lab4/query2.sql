-- test queries

insert into customers(last_name, first_name, gender, email, phone)
values  ('Munkhjin', 'Nyamdorj', 'male', 'nyamkamunhjin@gmail.com', 99999991),
        ('dsada', 'dsadasas', 'female', 'dsfsafasassd@gmail.com', 2131324);

insert into branch(branch_name, city, region, phone_number, schedule)
values  ('Shangri-La', 'UB', 'Tuv', 77777771, '1-7-11-5'),
        ('Sportiin-Tuv', 'UB', 'Tuv', 77777772, '1-6-10-6');

insert into shipping_addresses(customer_id, ship_address, ship_city, ship_region, postal_code)
values('c1', 'North Hwy 20, P.O 10', 'Island Park', 'Idaho', 83429);

insert into category(name, featured)
values  ('COMPUTING & INFORMATION TECHNOLOGY',0),
        ('LANGUAGE & LINGUISTICS', 0),
        ('LIFESTYLE, HOBBIES & LEISURE', 0);

insert into products(
    product_name,
    description,
    language,
    isbn,
    price,
    published_date,
    category_id,
    width,
    height,
    depth,
    total_page_num,
    weight,
    reserved_quantity
    )
values (
    'FOOD YOU CAN FORAGE',
    'When you know where to look',
    'english',
    9781472941206,
    40750,
    '2018-05-14 00:00:00',
    'ca2',
    246,
    0,
    189,
    256,
    755,
    10
);

insert into shopping_cart(customer_id, product_id, address_id, quantity)
values  ('c1', 'p0', 'a0', 5),
        ('c0', 'p0', 'a0', 5);

insert into publisher(publisher_name)
values  ('a'),
        ('b'),
        ('c');
