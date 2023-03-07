create table public.products
(
    id    integer      not null
        constraint products_pk
            primary key,
    name  varchar(100) not null,
    price integer      not null
);

alter table public.products
    owner to postgres;

create table public.stores
(
    id   integer     not null
        constraint stores_pk
            primary key,
    name varchar(50) not null
);

alter table public.stores
    owner to postgres;

create table public.orders
(
    id         integer not null
        constraint orders_pk
            primary key,
    store_id   integer not null
        constraint orders_stores_id_fk
            references public.stores,
    order_date date    not null,
    payment    integer not null
);

alter table public.orders
    owner to postgres;

create table public.sales
(
    order_id       integer not null
        constraint sales_orders_id_fk
            references public.orders,
    product_id     integer not null
        constraint sales_products_id_fk
            references public.products,
    price_per_unit integer not null,
    quantity       integer not null,
    total_price    integer not null,
    constraint sales_pk
        primary key (product_id, order_id)
);

alter table public.sales
    owner to postgres;

COPY public.stores(id, name) FROM '/csv/stores.csv'  with (format csv, header true);

