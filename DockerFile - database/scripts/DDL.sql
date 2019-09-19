
drop sequence if exists genero_id_genero_seq;
create sequence if not exists genero_id_genero_seq
  minvalue 1
  maxvalue 999999
  increment by 1; 

drop table IF EXISTS public.genero;
CREATE TABLE IF NOT EXISTS public.genero
(
  id_genero integer NOT NULL DEFAULT nextval('genero_id_genero_seq'::regclass),
  nombre character varying(20),
  CONSTRAINT genero_pkey PRIMARY KEY (id_genero)
);

drop sequence if exists cliente_id_cliente_seq;
create sequence if not exists cliente_id_cliente_seq
  minvalue 3
  maxvalue 999999
  increment by 1;

drop table IF EXISTS public.cliente;
  CREATE TABLE IF NOT EXISTS public.cliente (
  id_cliente integer NOT NULL DEFAULT nextval('cliente_id_cliente_seq'::regclass),
  apellidos character varying(80) NOT NULL,
  dni character varying(8) NOT NULL,
  fecha_nac date NOT NULL,
  nombres character varying(80) NOT NULL,
  CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente)
);

drop sequence if exists comida_id_comida_seq;
create sequence if not exists comida_id_comida_seq
  minvalue 1
  maxvalue 999999
  increment by 1;

drop table IF EXISTS public.comida;
  CREATE TABLE IF NOT EXISTS public.comida (
  id_comida integer NOT NULL DEFAULT nextval('comida_id_comida_seq'::regclass),
  foto bytea,
  nombre character varying(80) NOT NULL,
  precio numeric(5,2),
  CONSTRAINT comida_pkey PRIMARY KEY (id_comida)
);

drop sequence if exists config_id_config_seq;
create sequence if not exists config_id_config_seq
  minvalue 2
  maxvalue 999999
  increment by 1;

drop table IF EXISTS public.config;
  CREATE TABLE IF NOT EXISTS public.config (
  id_config integer NOT NULL DEFAULT nextval('config_id_config_seq'::regclass),
  parametro character varying(5),
  valor character varying(25),
  CONSTRAINT config_pkey PRIMARY KEY (id_config)
);

drop table IF EXISTS public.menu;
  CREATE TABLE IF NOT EXISTS public.menu (
  id_menu integer NOT NULL,
  icono character varying(20),
  nombre character varying(20),
  url character varying(50),
  CONSTRAINT menu_pkey PRIMARY KEY (id_menu)
);

drop table IF EXISTS public.rol;
CREATE TABLE IF NOT EXISTS public.rol
(
  id_rol integer NOT NULL,
  descripcion character varying(255),
  nombre character varying(255),
  CONSTRAINT rol_pkey PRIMARY KEY (id_rol)
);

drop table IF EXISTS public.menu_rol;
CREATE TABLE IF NOT EXISTS public.menu_rol
(
  id_menu integer NOT NULL,
  id_rol integer NOT NULL,
  CONSTRAINT fk_menu_rol_menu FOREIGN KEY (id_menu)
      REFERENCES public.menu (id_menu) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_menu_rol_rol FOREIGN KEY (id_rol)
      REFERENCES public.rol (id_rol) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

drop sequence if exists pelicula_id_pelicula_seq;
create sequence if not exists pelicula_id_pelicula_seq
  minvalue 4
  maxvalue 999999
  increment by 1;

drop table IF EXISTS public.pelicula;
CREATE TABLE IF NOT EXISTS public.pelicula
(
  id_pelicula integer NOT NULL DEFAULT nextval('pelicula_id_pelicula_seq'::regclass),
  duracion integer NOT NULL,
  fecha_publicacion date NOT NULL,
  nombre character varying(255) NOT NULL,
  resena character varying(255) NOT NULL,
  url_portada character varying(255) NOT NULL,
  id_genero integer NOT NULL,
  CONSTRAINT pelicula_pkey PRIMARY KEY (id_pelicula),
  CONSTRAINT fk_pelicula_genero FOREIGN KEY (id_genero)
      REFERENCES public.genero (id_genero) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT pelicula_duracion_check CHECK (duracion >= 1)
);

drop table IF EXISTS public.usuario;
CREATE TABLE IF NOT EXISTS public.usuario
(
  id_usuario integer NOT NULL,
  clave character varying(255) NOT NULL,
  estado boolean NOT NULL,
  nombre character varying(255) NOT NULL,
  CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario),
  CONSTRAINT fk_usuario_cliente FOREIGN KEY (id_usuario)
      REFERENCES public.cliente (id_cliente) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT uk_cto7dkti4t38iq8r4cqesbd8k UNIQUE (nombre)
);

drop table IF EXISTS public.usuario_rol;
CREATE TABLE IF NOT EXISTS public.usuario_rol
(
  id_usuario integer NOT NULL,
  id_rol integer NOT NULL,
  CONSTRAINT fk_usuario_rol_usuario FOREIGN KEY (id_usuario)
      REFERENCES public.usuario (id_usuario) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_usuario_rol_rol FOREIGN KEY (id_rol)
      REFERENCES public.rol (id_rol) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

drop sequence if exists venta_id_venta_seq;
create sequence if not exists venta_id_venta_seq
  minvalue 1
  maxvalue 999999
  increment by 1;

drop table IF EXISTS public.venta;
CREATE TABLE IF NOT EXISTS public.venta
(
  id_venta integer NOT NULL DEFAULT nextval('venta_id_venta_seq'::regclass),
  cantidad integer,
  fecha timestamp without time zone,
  total numeric(5,2),
  id_cliente integer NOT NULL,
  id_pelicula integer NOT NULL,
  CONSTRAINT venta_pkey PRIMARY KEY (id_venta),
  CONSTRAINT id_venta_cliente FOREIGN KEY (id_cliente)
      REFERENCES public.cliente (id_cliente) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT id_venta_pelicula FOREIGN KEY (id_pelicula)
      REFERENCES public.pelicula (id_pelicula) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

drop sequence if exists detalle_venta_id_detalle_seq;
create sequence if not exists detalle_venta_id_detalle_seq
  minvalue 1
  maxvalue 999999
  increment by 1;

drop table IF EXISTS public.detalle_venta;
  CREATE TABLE IF NOT EXISTS public.detalle_venta (
  id_detalle integer NOT NULL DEFAULT nextval('detalle_venta_id_detalle_seq'::regclass),
  asiento character varying(3),
  id_venta integer NOT NULL,
  CONSTRAINT detalle_venta_pkey PRIMARY KEY (id_detalle),
  CONSTRAINT fk_detalle_venta FOREIGN KEY (id_venta)
      REFERENCES public.venta (id_venta) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

drop table IF EXISTS public.venta_comida;
CREATE TABLE IF NOT EXISTS public.venta_comida
(
  id_comida integer NOT NULL,
  id_venta integer NOT NULL,
  CONSTRAINT venta_comida_pkey PRIMARY KEY (id_comida, id_venta),
  CONSTRAINT fk_comida_venta FOREIGN KEY (id_comida)
      REFERENCES public.comida (id_comida) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_venta_comida FOREIGN KEY (id_venta)
      REFERENCES public.venta (id_venta) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);


drop table IF EXISTS oauth_access_token;
CREATE TABLE IF NOT EXISTS oauth_access_token
(
  token_id character varying(256),
  token bytea,
  authentication_id character varying(256),
  user_name character varying(256),
  client_id character varying(256),
  authentication bytea,
  refresh_token character varying(256)
);




