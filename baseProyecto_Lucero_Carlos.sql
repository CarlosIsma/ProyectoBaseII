CREATE DATABASE formulario_edg_2015;

-- Table: public.ubicacion

-- DROP TABLE public.ubicacion;

CREATE TABLE public.ubicacion
(
    id_ubicacion serial NOT NULL,
    provincia character varying(128) COLLATE pg_catalog."default" NOT NULL,
    canton character varying(128) COLLATE pg_catalog."default" NOT NULL,
    parroquia character varying(128) COLLATE pg_catalog."default" NOT NULL,
    localidad character varying(128) COLLATE pg_catalog."default",
    dpa_inec character varying(6) COLLATE pg_catalog."default" NOT NULL,
    localidad_inec character varying(3) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT ubicacion_pkey PRIMARY KEY (id_ubicacion)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

-- Table: public.persona

-- DROP TABLE public.persona;

CREATE TABLE public.persona
(
    id_persona serial NOT NULL,
    cedula character varying(10) COLLATE pg_catalog."default" NOT NULL,
    nombre character varying(128) COLLATE pg_catalog."default" NOT NULL,
    nacionalidad character varying(100) COLLATE pg_catalog."default" NOT NULL,
    sexo character varying(60) COLLATE pg_catalog."default" NOT NULL,
    fecha_nacimiento date NOT NULL,
    id_ubicacion integer NOT NULL,
    direccion character varying(250) COLLATE pg_catalog."default" NOT NULL,
    estado_civil character varying(20) COLLATE pg_catalog."default",
    etnia character varying(50) COLLATE pg_catalog."default",
    leer_escribir boolean,
    instruccion character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT persona_pkey PRIMARY KEY (id_persona),
    CONSTRAINT persona_id_ubicacion_fkey FOREIGN KEY (id_ubicacion)
        REFERENCES public.ubicacion (id_ubicacion) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

-- Table: public.oficina

-- DROP TABLE public.oficina;

CREATE TABLE public.oficina
(
    id_oficina serial NOT NULL,
    nombre character varying(256) COLLATE pg_catalog."default" NOT NULL,
    uso_inec character varying(6) COLLATE pg_catalog."default" NOT NULL,
    id_ubicacion integer,
    CONSTRAINT oficina_pkey PRIMARY KEY (id_oficina),
    CONSTRAINT oficina_id_ubicacion_fkey FOREIGN KEY (id_ubicacion)
        REFERENCES public.ubicacion (id_ubicacion) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

-- Table: public.formulario

-- DROP TABLE public.formulario;

CREATE TABLE public.formulario
(
    id_formulario serial NOT NULL,
    numero_formulario bigint NOT NULL,
    fecha_inec date NOT NULL,
    fecha_inscripcion date NOT NULL,
    acta_inscripcion character varying(15) COLLATE pg_catalog."default",
    fecha_fallecimiento date,
    edad character varying(50) COLLATE pg_catalog."default",
    mortalidad_materna character varying(100) COLLATE pg_catalog."default",
    tipo_accidente character varying(100) COLLATE pg_catalog."default",
    lugar_accidente character varying(200) COLLATE pg_catalog."default",
    descripcion_accidente character varying(250) COLLATE pg_catalog."default",
    autopsia boolean,
    inscrito_por character varying(200) COLLATE pg_catalog."default",
    nombre_defuncion character varying(200) COLLATE pg_catalog."default",
    direccion_defuncion character varying(200) COLLATE pg_catalog."default",
    telefono_defuncion character varying(10) COLLATE pg_catalog."default",
    nombre_solicitante character varying(100) COLLATE pg_catalog."default",
    edad_solicitante integer,
    parentesco character varying(100) COLLATE pg_catalog."default",
    observacion character varying(250) COLLATE pg_catalog."default",
    codigo_critico integer,
    lugar_fallecimiento character varying(100) COLLATE pg_catalog."default",
    nombre_lugar character varying(200) COLLATE pg_catalog."default",
    id_ubicacion integer,
    direccion_lugar character varying(250) COLLATE pg_catalog."default",
    telefono_lugar character varying(10) COLLATE pg_catalog."default",
    codigo_inec_lugar character varying(7) COLLATE pg_catalog."default",
    id_oficina integer,
    id_persona integer,
    CONSTRAINT formulario_pkey PRIMARY KEY (id_formulario),
    CONSTRAINT formulario_id_oficina_fkey FOREIGN KEY (id_oficina)
        REFERENCES public.oficina (id_oficina) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT formulario_id_persona_fkey FOREIGN KEY (id_persona)
        REFERENCES public.persona (id_persona) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT formulario_id_ubicacion_fkey FOREIGN KEY (id_ubicacion)
        REFERENCES public.ubicacion (id_ubicacion) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

-- Table: public.formulario_certificado

-- DROP TABLE public.formulario_certificado;

CREATE TABLE public.formulario_certificado
(
    id_certificado_formulario serial NOT NULL,
    id_formulario integer,
    causa character varying(250) COLLATE pg_catalog."default",
    tiempo character varying(50) COLLATE pg_catalog."default",
    codigo_cie character varying(50) COLLATE pg_catalog."default",
    tipo character varying(50) COLLATE pg_catalog."default",
    codigo_causa_inec character varying(4) COLLATE pg_catalog."default",
    CONSTRAINT formulario_certificado_pkey PRIMARY KEY (id_certificado_formulario),
    CONSTRAINT formulario_certificado_id_formulario_fkey FOREIGN KEY (id_formulario)
        REFERENCES public.formulario (id_formulario) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;


-- Table: public.formulario_testigo

-- DROP TABLE public.formulario_testigo;

CREATE TABLE public.formulario_testigo
(
    id_formulario_testigo serial NOT NULL,
    id_formulario integer NOT NULL,
    causa character varying(250) COLLATE pg_catalog."default",
    nombre character varying(100) COLLATE pg_catalog."default",
    direccion character varying(200) COLLATE pg_catalog."default",
    telefono character varying(10) COLLATE pg_catalog."default",
    sintoma character varying(200) COLLATE pg_catalog."default",
    CONSTRAINT formulario_testigo_pkey PRIMARY KEY (id_formulario_testigo),
    CONSTRAINT formulario_testigo_id_formulario_fkey FOREIGN KEY (id_formulario)
        REFERENCES public.formulario (id_formulario) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;


-- Table: public.auditoria_formulario

-- DROP TABLE public.auditoria_formulario;

CREATE TABLE public.auditoria_formulario
(
    id_auditoria_formulario serial NOT NULL,
    id_formulario integer,
    numero_formulario bigint,
    fecha_inec date,
    fecha_inscripcion date,
    acta_inscripcion character varying(15) COLLATE pg_catalog."default",
    fecha_fallecimiento date,
    edad character varying(50) COLLATE pg_catalog."default",
    mortalidad_materna character varying(100) COLLATE pg_catalog."default",
    tipo_accidente character varying(100) COLLATE pg_catalog."default",
    lugar_accidente character varying(200) COLLATE pg_catalog."default",
    descripcion_accidente character varying(250) COLLATE pg_catalog."default",
    autopsia boolean,
    inscrito_por character varying(200) COLLATE pg_catalog."default",
    nombre_defuncion character varying(200) COLLATE pg_catalog."default",
    direccion_defuncion character varying(200) COLLATE pg_catalog."default",
    telefono_defuncion character varying(10) COLLATE pg_catalog."default",
    nombre_solicitante character varying(100) COLLATE pg_catalog."default",
    edad_solicitante integer,
    parentesco character varying(100) COLLATE pg_catalog."default",
    observacion character varying(250) COLLATE pg_catalog."default",
    codigo_critico integer,
    lugar_fallecimiento character varying(100) COLLATE pg_catalog."default",
    nombre_lugar character varying(200) COLLATE pg_catalog."default",
    id_ubicacion integer,
    direccion_lugar character varying(250) COLLATE pg_catalog."default",
    telefono_lugar character varying(10) COLLATE pg_catalog."default",
    codigo_inec_lugar character varying(7) COLLATE pg_catalog."default",
    id_oficina integer,
    id_persona integer,
    CONSTRAINT auditoria_formulario_pkey PRIMARY KEY (id_auditoria_formulario)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

CREATE OR REPLACE FUNCTION public.funcion_insertar_auditoria_formulario_edg(
    _id_formulario integer,
    _numero_formulario bigint,
    _fecha_inec date,
    _fecha_inscripcion date,
    _acta_inscripcion character varying,
    _fecha_fallecimiento date,
    _edad character varying,
    _mortalidad_materna character varying,
    _tipo_accidente character varying,
    _lugar_accidente character varying,
    _descripcion_accidente character varying,
    _autopsia boolean,
    _inscrito_por character varying,
    _nombre_defuncion character varying,
    _direccion_defuncion character varying,
    _telefono_defuncion character varying,
    _nombre_solicitante character varying,
    _edad_solicitante integer,
    _parentesco character varying,
    _observacion character varying,
    _codigo_critico integer,
    _lugar_fallecimiento character varying,
    _nombre_lugar character varying,
    _id_ubicacion integer,
    _direccion_lugar character varying,
    _telefono_lugar character varying,
    _codigo_inec_lugar character varying,
    _id_oficina integer,
    _id_persona integer)
  RETURNS void AS
$BODY$
BEGIN
	INSERT INTO public.auditoria_formulario(
	id_formulario, numero_formulario, fecha_inec, fecha_inscripcion, acta_inscripcion, fecha_fallecimiento, edad, mortalidad_materna, tipo_accidente, lugar_accidente, descripcion_accidente, autopsia, inscrito_por, nombre_defuncion, direccion_defuncion, telefono_defuncion, nombre_solicitante, edad_solicitante, parentesco, observacion, codigo_critico, lugar_fallecimiento, nombre_lugar, id_ubicacion, direccion_lugar, telefono_lugar, codigo_inec_lugar, id_oficina, id_persona)
	VALUES (_id_formulario, _numero_formulario, _fecha_inec, _fecha_inscripcion, _acta_inscripcion, _fecha_fallecimiento, _edad, _mortalidad_materna, _tipo_accidente,
    _lugar_accidente, _descripcion_accidente, _autopsia, _inscrito_por, _nombre_defuncion, _direccion_defuncion, _telefono_defuncion, _nombre_solicitante, _edad_solicitante,
    _parentesco, _observacion, _codigo_critico, _lugar_fallecimiento, _nombre_lugar, _id_ubicacion, _direccion_lugar, _telefono_lugar, _codigo_inec_lugar, _id_oficina,
    _id_persona);
		
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

  
  CREATE OR REPLACE FUNCTION public.t_auditoria_formulario()
  RETURNS trigger AS
$BODY$ 
BEGIN
	
	PERFORM public.funcion_insertar_auditoria_formulario_edg(NEW.id_formulario, NEW.numero_formulario, NEW.fecha_inec, NEW.fecha_inscripcion, NEW.acta_inscripcion, NEW.fecha_fallecimiento, NEW.edad, NEW.mortalidad_materna, NEW.tipo_accidente,
    NEW.lugar_accidente, NEW.descripcion_accidente, NEW.autopsia, NEW.inscrito_por, NEW.nombre_defuncion, NEW.direccion_defuncion, NEW.telefono_defuncion, NEW.nombre_solicitante, NEW.edad_solicitante,
    NEW.parentesco, NEW.observacion, NEW.codigo_critico, NEW.lugar_fallecimiento, NEW.nombre_lugar, NEW.id_ubicacion, NEW.direccion_lugar, NEW.telefono_lugar, NEW.codigo_inec_lugar, NEW.id_oficina,
    NEW.id_persona);	
	
RETURN NEW;
END; 
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

  
  
CREATE TRIGGER t_auditoriaformulario_edg
  AFTER INSERT
  ON public.formulario
  FOR EACH ROW
  EXECUTE PROCEDURE public.t_auditoria_formulario();

alter table persona add constraint persona_sexo_check check (
sexo='Hombre' or sexo= 'Mujer');



