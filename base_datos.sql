-- Creacion de la base de datos
CREATE SCHEMA `cuentomislukas` ;

-- Creacion de la tabla rol
CREATE TABLE `cuentomislukas`.`rol` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`));

-- Creacion de la tabla usuarios
CREATE TABLE `cuentomislukas`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `documento` VARCHAR(12) NOT NULL,
  `nombreCompleto` VARCHAR(100) NOT NULL,
  `edad` INT NOT NULL,
  `genero` TINYINT NOT NULL DEFAULT 0,
  `email` VARCHAR(50) NOT NULL,
  `nombreUsuario` VARCHAR(30) NOT NULL,
  `claveAcceso` VARCHAR(20) NOT NULL,
  `estado` TINYINT NOT NULL DEFAULT 0,
  `idRol` INT NOT NULL,
  PRIMARY KEY (`id`));

-- Realacion de llaves foraneas entre la tabla usuario y rol
ALTER TABLE `cuentomislukas`.`usuarios` 
ADD INDEX `fk_usuarios_rol_id_idx` (`idRol` ASC) ;
;
ALTER TABLE `cuentomislukas`.`usuarios` 
ADD CONSTRAINT `fk_usuarios_rol_id`
  FOREIGN KEY (`idRol`)
  REFERENCES `cuentomislukas`.`rol` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;
  
ALTER TABLE `cuentomislukas`.`usuarios` 
CHANGE COLUMN `edad` `edad` INT(3) NOT NULL ;

-- Creacion de la tabla modulo
CREATE TABLE `cuentomislukas`.`modulo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));

-- Creacion de la tabla operaciones
CREATE TABLE `cuentomislukas`.`operaciones` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `idModulo` INT NOT NULL,
  PRIMARY KEY (`id`));

-- Realacion de llaves foraneas entre la tabla modulo y operaciones
ALTER TABLE `cuentomislukas`.`operaciones` 
ADD INDEX `fk_operaciones_modulo_id_idx` (`idModulo` ASC) ;
;
ALTER TABLE `cuentomislukas`.`operaciones` 
ADD CONSTRAINT `fk_operaciones_modulo_id`
  FOREIGN KEY (`idModulo`)
  REFERENCES `cuentomislukas`.`modulo` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

-- Creación de la tabla rol_operacion
CREATE TABLE `cuentomislukas`.`rol_operacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idRol` INT NOT NULL,
  `idOperacion` INT NOT NULL,
  PRIMARY KEY (`id`));

-- Realacion de llaves foraneas entre la tabla rol y rol_operaciones
ALTER TABLE `cuentomislukas`.`rol_operacion` 
ADD INDEX `id_rol_roloperacion_id_idx` (`idRol` ASC);
;
ALTER TABLE `cuentomislukas`.`rol_operacion` 
ADD CONSTRAINT `id_rol_roloperacion_id`
  FOREIGN KEY (`idRol`)
  REFERENCES `cuentomislukas`.`rol` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

-- Realacion de llaves foraneas entre la tabla operaciones y rol_operaciones
ALTER TABLE `cuentomislukas`.`rol_operacion` 
ADD INDEX `id_operacion_roloperacion_id_idx` (`idOperacion` ASC);
;
ALTER TABLE `cuentomislukas`.`rol_operacion` 
ADD CONSTRAINT `id_operacion_roloperacion_id`
  FOREIGN KEY (`idOperacion`)
  REFERENCES `cuentomislukas`.`operaciones` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;
  
-- Seleccion de la tabla rol para realizar la insercion de datos
SELECT * FROM cuentomislukas.rol;

-- Creacion de los roles que se manejaran en el aplicativo
INSERT INTO cuentomislukas.rol (nombre) VALUES ('Administrador'), ('Gerente'), ('Usuario');

