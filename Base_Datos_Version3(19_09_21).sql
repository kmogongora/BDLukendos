-- Creacion de la Base de Datos
CREATE SCHEMA `cuentomislukas` ;

-- Creacion de la tabla rol
CREATE TABLE `cuentomislukas`.`rol` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`));

-- Seleccion de la tabla rol para realizar la insercion de datos
SELECT * FROM cuentomislukas.rol;

-- Creacion de los roles que se manejaran en el aplicativo
INSERT INTO cuentomislukas.rol (nombre) VALUES ('Admin'), ('Manager'), ('User');

-- Creacion de la tabla genero
CREATE TABLE `cuentomislukas`.`genero` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`));

-- Seleccion de la tabla genero
SELECT * FROM cuentomislukas.genero;

-- Creacion de los generos que se manejaran
INSERT INTO cuentomislukas.genero (nombre) VALUES ('Femenino'), ('Masculino'), ('Otro');

-- Creacion de la tabla usuarios
CREATE TABLE `cuentomislukas`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `documento` VARCHAR(12) NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `apellido` VARCHAR(100) NOT NULL,
  `fechaNacimiento` DATE NOT NULL,
  `idGenero` INT NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `nombreUsuario` VARCHAR(30) NOT NULL,
  `claveAcceso` VARCHAR(20) NOT NULL,
  `estado` VARCHAR(10) NOT NULL,
  `idRol` INT NOT NULL,
  PRIMARY KEY (`id`));

-- Realacion de llaves foraneas entre la tabla usuario y genero
ALTER TABLE `cuentomislukas`.`usuarios` 
ADD INDEX `fk_usuarios_genero_id_idx` (`idGenero` ASC) ;
;
ALTER TABLE `cuentomislukas`.`usuarios` 
ADD CONSTRAINT `fk_usuarios_genero_id`
  FOREIGN KEY (`idGenero`)
  REFERENCES `cuentomislukas`.`genero` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
-- Realacion de llaves foraneas entre la tabla usuario y rol
ALTER TABLE `cuentomislukas`.`usuarios` 
ADD INDEX `fk_usuarios_rol_id_idx` (`idRol` ASC) ;
;
ALTER TABLE `cuentomislukas`.`usuarios` 
ADD CONSTRAINT `fk_usuarios_rol_id`
  FOREIGN KEY (`idRol`)
  REFERENCES `cuentomislukas`.`rol` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
-- Seleccion de la tabla usuarios
SELECT * FROM cuentomislukas.usuarios;

-- Insertamos un registro en la tabla de tipo Administrador
INSERT INTO cuentomislukas.usuarios (documento, nombre, apellido, fechaNacimiento, idGenero, email, nombreUsuario, claveAcceso, estado, idRol) VALUES ('123', 'User1', 'Prueba1', '1990-12-03', 2, 'user1@gmail.com', 'User01', '12e34', 'Activo', 1);


-- Creacion de la tabla modulo
CREATE TABLE `cuentomislukas`.`modulo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`));

-- Creacion de la tabla operaciones
CREATE TABLE `cuentomislukas`.`operaciones` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  `idModulo` INT NOT NULL,
  PRIMARY KEY (`id`));

-- Realacion de llaves foraneas entre la tabla operaciones y modulo
ALTER TABLE `cuentomislukas`.`operaciones` 
ADD INDEX `fk_operaciones_modulo_id_idx` (`idModulo` ASC) ;
;
ALTER TABLE `cuentomislukas`.`operaciones` 
ADD CONSTRAINT `fk_operaciones_modulo_id`
  FOREIGN KEY (`idModulo`)
  REFERENCES `cuentomislukas`.`modulo` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- Creacion de la tabla rol_operacion
CREATE TABLE `cuentomislukas`.`rol_operacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idRol` INT NOT NULL,
  `idOperacion` INT NOT NULL,
  PRIMARY KEY (`id`));

-- Realacion de llaves foraneas entre la tabla rol y rol_operaciones
ALTER TABLE `cuentomislukas`.`rol_operacion` 
ADD INDEX `fk_roloperacion_rol_id_idx` (`idRol` ASC) ;
;
ALTER TABLE `cuentomislukas`.`rol_operacion` 
ADD CONSTRAINT `fk_roloperacion_rol_id`
  FOREIGN KEY (`idRol`)
  REFERENCES `cuentomislukas`.`rol` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- Realacion de llaves foraneas entre la tabla operaciones y rol_operaciones
ALTER TABLE `cuentomislukas`.`rol_operacion` 
ADD INDEX `fk_roloperacion_operaciones_id_idx` (`idOperacion` ASC) ;
;
ALTER TABLE `cuentomislukas`.`rol_operacion` 
ADD CONSTRAINT `fk_roloperacion_operaciones_id`
  FOREIGN KEY (`idOperacion`)
  REFERENCES `cuentomislukas`.`operaciones` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  -- Creacion de la tabla ingreso
  CREATE TABLE `cuentomislukas`.`ingreso` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipoIngreso` VARCHAR(20) NOT NULL,
  `idCategoriaIngreso` INT NOT NULL,
  `fechaIngreso` DATE NOT NULL,
  `valorIngreso` DOUBLE NOT NULL,
  `descripcion` VARCHAR(60) NULL,
  `idUsuario` INT NOT NULL,
  PRIMARY KEY (`id`));
  
  -- Creacion de la tabla categoria de los ingresos
  CREATE TABLE `cuentomislukas`.`categoria_ingresos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`));

-- Seleccion de la tabla categoria_ingresos para realizar la insercion de datos
SELECT * FROM cuentomislukas.categoria_ingresos;

-- Creacion de las categorias que se manejaran en la opcion de ingresos
INSERT INTO cuentomislukas.categoria_ingresos (nombre) VALUES ('Salario'), ('Inversiones'), ('Regalos'), ('Premios'), ('Otros');

-- Realacion de llaves foraneas entre la tabla ingresos y categoria_ingresos
ALTER TABLE `cuentomislukas`.`ingreso` 
ADD INDEX `fk_ingreso_categoria_id_idx` (`idCategoriaIngreso` ASC) ;
;
ALTER TABLE `cuentomislukas`.`ingreso` 
ADD CONSTRAINT `fk_ingreso_categoria_id`
  FOREIGN KEY (`idCategoriaIngreso`)
  REFERENCES `cuentomislukas`.`categoria_ingresos` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- Realacion de llaves foraneas entre la tabla ingresos y usuarios
ALTER TABLE `cuentomislukas`.`ingreso` 
ADD INDEX `fk_ingreso_usuarios_id_idx` (`idUsuario` ASC) ;
;
ALTER TABLE `cuentomislukas`.`ingreso` 
ADD CONSTRAINT `fk_ingreso_usuarios_id`
  FOREIGN KEY (`idUsuario`)
  REFERENCES `cuentomislukas`.`usuarios` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
-- Creacion de la tabla egreso
  CREATE TABLE `cuentomislukas`.`egreso` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipoEgreso` VARCHAR(25) NOT NULL,
  `idCategoriaEgreso` INT NOT NULL,
  `fechaEgreso` DATE NOT NULL,
  `valorEgreso` DOUBLE NOT NULL,
  `descripcion` VARCHAR(60) NULL,
  `idUsuario` INT NOT NULL,
  PRIMARY KEY (`id`));

-- Creacion de la tabla categoria de los egresos
CREATE TABLE `cuentomislukas`.`categoria_egresos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`));

-- Seleccion de la tabla categoria_egresos para realizar la insercion de datos
SELECT * FROM cuentomislukas.categoria_egresos;

-- Creacion de las categorias que se manejaran en la opcion de egresos
INSERT INTO cuentomislukas.categoria_egresos (nombre) VALUES ('Arriendo'), ('Mercado'), ('Servicios'), ('Salud'), ('Transportes'), ('Educación'), ('Ropa'), ('Viaje'), ('Otros');

-- Realacion de llaves foraneas entre la tabla egresos y categoria_ingresos
ALTER TABLE `cuentomislukas`.`egreso` 
ADD INDEX `fk_egreso_categoria_id_idx` (`idCategoriaEgreso` ASC) ;
;
ALTER TABLE `cuentomislukas`.`egreso` 
ADD CONSTRAINT `fk_egreso_categoria_id`
  FOREIGN KEY (`idCategoriaEgreso`)
  REFERENCES `cuentomislukas`.`categoria_egresos` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- Realacion de llaves foraneas entre la tabla egresos y usuarios
ALTER TABLE `cuentomislukas`.`egreso` 
ADD INDEX `fk_egreso_usuario_idx` (`idUsuario` ASC) ;
;
ALTER TABLE `cuentomislukas`.`egreso` 
ADD CONSTRAINT `fk_egreso_usuario`
  FOREIGN KEY (`idUsuario`)
  REFERENCES `cuentomislukas`.`usuarios` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
-- Creacion de la tabla ahorro
CREATE TABLE `cuentomislukas`.`ahorro` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `valorResidual` DOUBLE NOT NULL,
  `porcentajeAhorro` INT NOT NULL,
  `fechaRegistro` DATE NOT NULL,
  `valorAhorro` DOUBLE NOT NULL,
  `idUsuario` INT NOT NULL,
  PRIMARY KEY (`id`));
  
-- Realacion de llaves foraneas entre la tabla ahorro y usuarios
ALTER TABLE `cuentomislukas`.`ahorro` 
ADD INDEX `fk_ahorro_usuario_id_idx` (`idUsuario` ASC) ;
;
ALTER TABLE `cuentomislukas`.`ahorro` 
ADD CONSTRAINT `fk_ahorro_usuario_id`
  FOREIGN KEY (`idUsuario`)
  REFERENCES `cuentomislukas`.`usuarios` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- Creacion de la tabla metas
CREATE TABLE `cuentomislukas`.`metas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `valorTotalMeta` DOUBLE NOT NULL,
  `Categoria` VARCHAR(20) NOT NULL,
  `descripcion` VARCHAR(60) NULL,
  `fechaInicio` DATE NOT NULL,
  `fechaFinal` DATE NOT NULL,
  `idUsuario` INT NOT NULL,
  PRIMARY KEY (`id`));
 
-- Realacion de llaves foraneas entre la tabla metas y usuarios
ALTER TABLE `cuentomislukas`.`metas` 
ADD INDEX `fk_metas_usuario_id_idx` (`idUsuario` ASC) ;
;
ALTER TABLE `cuentomislukas`.`metas` 
ADD CONSTRAINT `fk_metas_usuario_id`
  FOREIGN KEY (`idUsuario`)
  REFERENCES `cuentomislukas`.`usuarios` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


