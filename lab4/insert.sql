insert into branch(branch_name, city, region, phone_number, schedule)
values('Shangri-La', 'UB', 'Tuv', '70707070', '1-7 9-5');

insert into category(name, featured)
values
  	('COMPUTING & INFORMATION TECHNOLOGY',0),
    ('LANGUAGE & LINGUISTICS', 0),
    ('LIFESTYLE, HOBBIES & LEISURE', 0);

insert into customers(last_name, first_name, gender, email, phone)
values ('Munkhjin', 'Nyamdorj', 'male', 'nyamkamunhjin@gmail.com', 99999991);

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
    quantity
    )
values (
    'FOOD YOU CAN FORAGE',
    'When you know where to look',
    'english',
    9781472941206,
    40750,
    '2018-05-14 00:00:00',
    3,
    246,
    0,
    189,
    256,
    755,
    10
);

insert into product_branch(
    product_id,
    branch_id,
    quantity
)
values (
    1,
    1,
    10
);

insert into orders(
    customer_id,
    product_id,
    branch_id,
    quantity,
    ship_address,
    ship_city,
    ship_region,
    postal_code,
    isConfirmed
)
values(
    1,
    1,
    1,
    3,
    'North hwy 20 P.O 10',
    'Island Park',
    'Idaho',
    '83429',
    0
);