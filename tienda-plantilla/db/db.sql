create table categorias (
  id     bigint generated always as identity primary key,
  nombre text not null unique
);

create table productos (
  id           bigint generated always as identity primary key,
  nombre       text not null,
  descripcion  text,
  precio       numeric(10,2) not null check (precio >= 0),
  stock        int not null default 0 check (stock >= 0),
  imagen_url   text,
  categoria_id bigint references categorias(id),
  activo       boolean not null default true
);

create table perfiles (
  id     uuid primary key references auth.users(id) on delete cascade,
  nombre text not null,
  rol    text not null default 'cliente' check (rol in ('cliente', 'admin'))
);

create table pedidos (
  id         bigint generated always as identity primary key,
  usuario_id uuid not null references auth.users(id),
  total      numeric(10,2) not null check (total >= 0),
  estado     text not null default 'pendiente'
             check (estado in ('pendiente', 'confirmado', 'cancelado')),
  creado     timestamptz not null default now()
);

create table pedido_items (
  id              bigint generated always as identity primary key,
  pedido_id       bigint not null references pedidos(id) on delete cascade,
  producto_id     bigint not null references productos(id),
  cantidad        int not null check (cantidad > 0),
  precio_unitario numeric(10,2) not null check (precio_unitario >= 0)
);


insert into categorias (nombre) values ('instrumentos'), ('accesorios'), ('repuestos');

insert into productos (id,nombre, descripcion, precio, stock, imagen_url,categoria_id, activo) values
(1,'gitarra electrica', 'Guitarra eléctrica de alta calidad', 499.99, 10, 'https://qwpztmbaclmeljhjoupn.supabase.co/storage/v1/object/public/productos/1.jpg', 1, true),
(2,'bajo electrico', 'Bajo eléctrico con sonido potente', 399.99, 5, 'https://qwpztmbaclmeljhjoupn.supabase.co/storage/v1/object/public/productos/2.jpg', 1, true),
(3,'piano digital', 'Piano digital con teclas sensibles al tacto', 799.99, 3, 'https://qwpztmbaclmeljhjoupn.supabase.co/storage/v1/object/public/productos/3.jpg', 1, true),
(4,'cable de guitarra', 'Cable de guitarra de 3 metros', 19.99, 50, 'https://qwpztmbaclmeljhjoupn.supabase.co/storage/v1/object/public/productos/4.jpg', 2, true),
(5,'afinador de guitarra', 'Afinador de guitarra preciso y fácil de usar', 29.99, 20, 'https://qwpztmbaclmeljhjoupn.supabase.co/storage/v1/object/public/productos/5.jpg', 2, true),
(6,'violin', 'Violin de alta calidad para principiantes y profesionales', 299.99, 7, 'https://qwpztmbaclmeljhjoupn.supabase.co/storage/v1/object/public/productos/6.jpg', 1, true),
(7,'cuerda de guitarra', 'Cuerda de guitarra acústica de acero', 14.99, 30, 'https://qwpztmbaclmeljhjoupn.supabase.co/storage/v1/object/public/productos/7.jpg', 2, true),
(8,'atril para partituras', 'Atril ajustable para partituras y libros de música', 49.99, 15, 'https://qwpztmbaclmeljhjoupn.supabase.co/storage/v1/object/public/productos/8.jpg', 2, true);