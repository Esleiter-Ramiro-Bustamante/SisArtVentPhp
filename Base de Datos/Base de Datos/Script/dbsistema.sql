-- MySQL Script generated by MySQL Workbench
-- 01/19/17 19:01:49
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema dbsistema
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dbsistema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dbsistema` DEFAULT CHARACTER SET utf8 ;
USE `dbsistema` ;

-- -----------------------------------------------------
-- Table `dbsistema`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbsistema`.`categoria` (
  `idcategoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(256) NULL,
  `condicion` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idcategoria`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbsistema`.`articulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbsistema`.`articulo` (
  `idarticulo` INT NOT NULL AUTO_INCREMENT,
  `idcategoria` INT NOT NULL,
  `codigo` VARCHAR(50) NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `stock` INT NOT NULL,
  `descripcion` VARCHAR(256) NULL,
  `imagen` VARCHAR(50) NULL,
  `condicion` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idarticulo`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC),
  INDEX `fk_articulo_categoria_idx` (`idcategoria` ASC),
  CONSTRAINT `fk_articulo_categoria`
    FOREIGN KEY (`idcategoria`)
    REFERENCES `dbsistema`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbsistema`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbsistema`.`persona` (
  `idpersona` INT NOT NULL AUTO_INCREMENT,
  `tipo_persona` VARCHAR(20) NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `tipo_documento` VARCHAR(20) NULL,
  `num_documento` VARCHAR(20) NULL,
  `direccion` VARCHAR(70) NULL,
  `telefono` VARCHAR(20) NULL,
  `email` VARCHAR(50) NULL,
  PRIMARY KEY (`idpersona`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbsistema`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbsistema`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `tipo_documento` VARCHAR(20) NOT NULL,
  `num_documento` VARCHAR(20) NOT NULL,
  `direccion` VARCHAR(70) NULL,
  `telefono` VARCHAR(20) NULL,
  `email` VARCHAR(50) NULL,
  `cargo` VARCHAR(20) NULL,
  `login` VARCHAR(20) NOT NULL,
  `clave` VARCHAR(64) NOT NULL,
  `condicion` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idusuario`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbsistema`.`ingreso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbsistema`.`ingreso` (
  `idingreso` INT NOT NULL AUTO_INCREMENT,
  `idproveedor` INT NOT NULL,
  `idusuario` INT NOT NULL,
  `tipo_comprobante` VARCHAR(20) NOT NULL,
  `serie_comprobante` VARCHAR(7) NULL,
  `num_comprobante` VARCHAR(10) NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  `impuesto` DECIMAL(4,2) NOT NULL,
  `total_compra` DECIMAL(11,2) NOT NULL,
  `estado` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idingreso`),
  INDEX `fk_ingreso_persona_idx` (`idproveedor` ASC),
  INDEX `fk_ingreso_usuario_idx` (`idusuario` ASC),
  CONSTRAINT `fk_ingreso_persona`
    FOREIGN KEY (`idproveedor`)
    REFERENCES `dbsistema`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingreso_usuario`
    FOREIGN KEY (`idusuario`)
    REFERENCES `dbsistema`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbsistema`.`detalle_ingreso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbsistema`.`detalle_ingreso` (
  `iddetalle_ingreso` INT NOT NULL AUTO_INCREMENT,
  `idingreso` INT NOT NULL,
  `idarticulo` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `precio_compra` DECIMAL(11,2) NOT NULL,
  `precio_venta` DECIMAL(11,2) NOT NULL,
  PRIMARY KEY (`iddetalle_ingreso`),
  INDEX `fk_detalle_ingreso_ingreso_idx` (`idingreso` ASC),
  INDEX `fk_detalle_ingreso_articulo_idx` (`idarticulo` ASC),
  CONSTRAINT `fk_detalle_ingreso_ingreso`
    FOREIGN KEY (`idingreso`)
    REFERENCES `dbsistema`.`ingreso` (`idingreso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_ingreso_articulo`
    FOREIGN KEY (`idarticulo`)
    REFERENCES `dbsistema`.`articulo` (`idarticulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbsistema`.`venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbsistema`.`venta` (
  `idventa` INT NOT NULL AUTO_INCREMENT,
  `idcliente` INT NOT NULL,
  `idusuario` INT NOT NULL,
  `tipo_comprobante` VARCHAR(20) NOT NULL,
  `serie_comprobante` VARCHAR(7) NULL,
  `num_comprobante` VARCHAR(10) NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  `impuesto` DECIMAL(4,2) NOT NULL,
  `total_venta` DECIMAL(11,2) NOT NULL,
  `estado` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idventa`),
  INDEX `fk_venta_persona_idx` (`idcliente` ASC),
  INDEX `fk_venta_usuario_idx` (`idusuario` ASC),
  CONSTRAINT `fk_venta_persona`
    FOREIGN KEY (`idcliente`)
    REFERENCES `dbsistema`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venta_usuario`
    FOREIGN KEY (`idusuario`)
    REFERENCES `dbsistema`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbsistema`.`detalle_venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbsistema`.`detalle_venta` (
  `iddetalle_venta` INT NOT NULL AUTO_INCREMENT,
  `idventa` INT NOT NULL,
  `idarticulo` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `precio_venta` DECIMAL(11,2) NOT NULL,
  `descuento` DECIMAL(11,2) NOT NULL,
  PRIMARY KEY (`iddetalle_venta`),
  INDEX `fk_detalle_venta_venta_idx` (`idventa` ASC),
  INDEX `fk_detalle_venta_articulo_idx` (`idarticulo` ASC),
  CONSTRAINT `fk_detalle_venta_venta`
    FOREIGN KEY (`idventa`)
    REFERENCES `dbsistema`.`venta` (`idventa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_venta_articulo`
    FOREIGN KEY (`idarticulo`)
    REFERENCES `dbsistema`.`articulo` (`idarticulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbsistema`.`permiso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbsistema`.`permiso` (
  `idpermiso` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`idpermiso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbsistema`.`usuario_permiso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbsistema`.`usuario_permiso` (
  `idusuario_permiso` INT NOT NULL AUTO_INCREMENT,
  `idusuario` INT NOT NULL,
  `idpermiso` INT NOT NULL,
  PRIMARY KEY (`idusuario_permiso`),
  INDEX `fk_usuario_permiso_permiso_idx` (`idpermiso` ASC),
  INDEX `fk_usuario_permiso_usuario_idx` (`idusuario` ASC),
  CONSTRAINT `fk_usuario_permiso_permiso`
    FOREIGN KEY (`idpermiso`)
    REFERENCES `dbsistema`.`permiso` (`idpermiso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_permiso_usuario`
    FOREIGN KEY (`idusuario`)
    REFERENCES `dbsistema`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
