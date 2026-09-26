-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema tp_bases_datos_1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tp_bases_datos_1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tp_bases_datos_1` DEFAULT CHARACTER SET utf8mb4 ;
USE `tp_bases_datos_1` ;

-- -----------------------------------------------------
-- Table `tp_bases_datos_1`.`modelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bases_datos_1`.`modelo` (
  `id_modelo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_modelo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bases_datos_1`.`linea_de_montaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bases_datos_1`.`linea_de_montaje` (
  `idlinea_de_montaje` INT NOT NULL AUTO_INCREMENT,
  `capacidad_mensual` INT NOT NULL,
  `modelo_id_modelo` INT NOT NULL,
  PRIMARY KEY (`idlinea_de_montaje`),
  INDEX `fk_linea_de_montaje_modelo_idx` (`modelo_id_modelo` ASC) VISIBLE,
  UNIQUE INDEX `modelo_UNIQUE` (`modelo_id_modelo` ASC) VISIBLE,
  CONSTRAINT `fk_linea_de_montaje_modelo`
    FOREIGN KEY (`modelo_id_modelo`)
    REFERENCES `tp_bases_datos_1`.`modelo` (`id_modelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bases_datos_1`.`concesionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bases_datos_1`.`concesionario` (
  `id_concesionario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_concesionario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bases_datos_1`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bases_datos_1`.`pedido` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT,
  `fecha_hora_pedido_realizado` DATETIME NOT NULL,
  `fecha_entrega_estimada` DATETIME NULL,
  `concesionario_id_concesionario` INT NOT NULL,
  PRIMARY KEY (`id_pedido`),
  INDEX `fk_pedido_concesionario1_idx` (`concesionario_id_concesionario` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_concesionario1`
    FOREIGN KEY (`concesionario_id_concesionario`)
    REFERENCES `tp_bases_datos_1`.`concesionario` (`id_concesionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bases_datos_1`.`automovil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bases_datos_1`.`automovil` (
  `numero_de_chasis` INT NOT NULL,
  `patente` VARCHAR(45) NOT NULL,
  `fecha_finalizacion` DATETIME NULL,
  `pedido_id_pedido` INT NOT NULL,
  `modelo_id_modelo` INT NOT NULL,
  PRIMARY KEY (`numero_de_chasis`),
  INDEX `fk_automovil_pedido1_idx` (`pedido_id_pedido` ASC) VISIBLE,
  INDEX `fk_automovil_modelo1_idx` (`modelo_id_modelo` ASC) VISIBLE,
  UNIQUE INDEX `patente_UNIQUE` (`patente` ASC) VISIBLE,
  CONSTRAINT `fk_automovil_pedido1`
    FOREIGN KEY (`pedido_id_pedido`)
    REFERENCES `tp_bases_datos_1`.`pedido` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_automovil_modelo1`
    FOREIGN KEY (`modelo_id_modelo`)
    REFERENCES `tp_bases_datos_1`.`modelo` (`id_modelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bases_datos_1`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bases_datos_1`.`proveedor` (
  `id_proveedor` INT NOT NULL AUTO_INCREMENT,
  `nombre_proveedor` VARCHAR(45) NOT NULL,
  `direccion_proveedor` VARCHAR(45) NOT NULL,
  `telefono_proveedor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_proveedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bases_datos_1`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bases_datos_1`.`compra` (
  `id_compra` INT NOT NULL AUTO_INCREMENT,
  `fecha_hora` DATETIME NOT NULL,
  `proveedor_id_proveedor` INT NOT NULL,
  PRIMARY KEY (`id_compra`),
  INDEX `fk_compra_proveedor1_idx` (`proveedor_id_proveedor` ASC) VISIBLE,
  CONSTRAINT `fk_compra_proveedor1`
    FOREIGN KEY (`proveedor_id_proveedor`)
    REFERENCES `tp_bases_datos_1`.`proveedor` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bases_datos_1`.`insumo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bases_datos_1`.`insumo` (
  `codigo_insumo` INT NOT NULL,
  `descripcion_insumo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codigo_insumo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bases_datos_1`.`estacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bases_datos_1`.`estacion` (
  `id_estacion` INT NOT NULL AUTO_INCREMENT,
  `orden` INT NOT NULL,
  `linea_de_montaje_idlinea_de_montaje` INT NOT NULL,
  PRIMARY KEY (`id_estacion`),
  INDEX `fk_estacion_linea_de_montaje1_idx` (`linea_de_montaje_idlinea_de_montaje` ASC) VISIBLE,
  CONSTRAINT `fk_estacion_linea_de_montaje1`
    FOREIGN KEY (`linea_de_montaje_idlinea_de_montaje`)
    REFERENCES `tp_bases_datos_1`.`linea_de_montaje` (`idlinea_de_montaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bases_datos_1`.`automovil_en_estacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bases_datos_1`.`automovil_en_estacion` (
  `automovil_numero_de_chasis` INT NOT NULL,
  `estacion_id_estacion` INT NOT NULL,
  `fecha_hora_ingreso` DATETIME NOT NULL,
  `fecha_hora_egreso` DATETIME NULL,
  PRIMARY KEY (`automovil_numero_de_chasis`, `estacion_id_estacion`),
  INDEX `fk_automovil_has_estacion_estacion1_idx` (`estacion_id_estacion` ASC) VISIBLE,
  INDEX `fk_automovil_has_estacion_automovil1_idx` (`automovil_numero_de_chasis` ASC) VISIBLE,
  CONSTRAINT `fk_automovil_has_estacion_automovil1`
    FOREIGN KEY (`automovil_numero_de_chasis`)
    REFERENCES `tp_bases_datos_1`.`automovil` (`numero_de_chasis`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_automovil_has_estacion_estacion1`
    FOREIGN KEY (`estacion_id_estacion`)
    REFERENCES `tp_bases_datos_1`.`estacion` (`id_estacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bases_datos_1`.`detalle_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bases_datos_1`.`detalle_pedido` (
  `modelo_id_modelo` INT NOT NULL,
  `pedido_id_pedido` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`modelo_id_modelo`, `pedido_id_pedido`),
  INDEX `fk_modelo_has_pedido_pedido1_idx` (`pedido_id_pedido` ASC) VISIBLE,
  INDEX `fk_modelo_has_pedido_modelo1_idx` (`modelo_id_modelo` ASC) VISIBLE,
  CONSTRAINT `fk_modelo_has_pedido_modelo1`
    FOREIGN KEY (`modelo_id_modelo`)
    REFERENCES `tp_bases_datos_1`.`modelo` (`id_modelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_modelo_has_pedido_pedido1`
    FOREIGN KEY (`pedido_id_pedido`)
    REFERENCES `tp_bases_datos_1`.`pedido` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bases_datos_1`.`detalle_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bases_datos_1`.`detalle_compra` (
  `insumo_codigo_insumo` INT NOT NULL,
  `compra_id_compra` INT NOT NULL,
  `precio` FLOAT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`insumo_codigo_insumo`, `compra_id_compra`),
  INDEX `fk_insumo_has_compra_compra1_idx` (`compra_id_compra` ASC) VISIBLE,
  INDEX `fk_insumo_has_compra_insumo1_idx` (`insumo_codigo_insumo` ASC) VISIBLE,
  CONSTRAINT `fk_insumo_has_compra_insumo1`
    FOREIGN KEY (`insumo_codigo_insumo`)
    REFERENCES `tp_bases_datos_1`.`insumo` (`codigo_insumo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_insumo_has_compra_compra1`
    FOREIGN KEY (`compra_id_compra`)
    REFERENCES `tp_bases_datos_1`.`compra` (`id_compra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bases_datos_1`.`estacion_has_insumo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bases_datos_1`.`estacion_has_insumo` (
  `estacion_id_estacion` INT NOT NULL,
  `insumo_codigo_insumo` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`estacion_id_estacion`, `insumo_codigo_insumo`),
  INDEX `fk_estacion_has_insumo_insumo1_idx` (`insumo_codigo_insumo` ASC) VISIBLE,
  INDEX `fk_estacion_has_insumo_estacion1_idx` (`estacion_id_estacion` ASC) VISIBLE,
  CONSTRAINT `fk_estacion_has_insumo_estacion1`
    FOREIGN KEY (`estacion_id_estacion`)
    REFERENCES `tp_bases_datos_1`.`estacion` (`id_estacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estacion_has_insumo_insumo1`
    FOREIGN KEY (`insumo_codigo_insumo`)
    REFERENCES `tp_bases_datos_1`.`insumo` (`codigo_insumo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bases_datos_1`.`proveedor_insumo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bases_datos_1`.`proveedor_insumo` (
  `proveedor_id_proveedor` INT NOT NULL,
  `insumo_codigo_insumo` INT NOT NULL,
  `precio` FLOAT NOT NULL,
  PRIMARY KEY (`proveedor_id_proveedor`, `insumo_codigo_insumo`),
  INDEX `fk_proveedor_has_insumo_insumo1_idx` (`insumo_codigo_insumo` ASC) VISIBLE,
  INDEX `fk_proveedor_has_insumo_proveedor1_idx` (`proveedor_id_proveedor` ASC) VISIBLE,
  CONSTRAINT `fk_proveedor_has_insumo_proveedor1`
    FOREIGN KEY (`proveedor_id_proveedor`)
    REFERENCES `tp_bases_datos_1`.`proveedor` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proveedor_has_insumo_insumo1`
    FOREIGN KEY (`insumo_codigo_insumo`)
    REFERENCES `tp_bases_datos_1`.`insumo` (`codigo_insumo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



DROP PROCEDURE IF EXISTS sp_altaConcesionario;

DELIMITER //
CREATE PROCEDURE sp_altaConcesionario(
    IN p_nombre VARCHAR(45),
    IN p_direccion VARCHAR(45),
    OUT nResultado INT,
    OUT cMensaje VARCHAR(200)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET nResultado = -1;
        SET cMensaje = 'Error al insertar concesionario';
    END;

    START TRANSACTION;

    IF EXISTS(SELECT 1 FROM concesionario
              WHERE nombre = p_nombre AND direccion = p_direccion) THEN
        SET nResultado = -2;
        SET cMensaje = 'Ya existe un concesionario con ese nombre y direccion';
        ROLLBACK;
    ELSE
        INSERT INTO concesionario(nombre, direccion)
        VALUES (p_nombre, p_direccion);

        SET nResultado = 0;
        SET cMensaje = '';
        COMMIT;
    END IF;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_modificarConcesionario;

DELIMITER //
CREATE PROCEDURE sp_modificarConcesionario(
    IN p_id INT,
    IN p_nombre VARCHAR(45),
    IN p_direccion VARCHAR(45),
    OUT nResultado INT,
    OUT cMensaje VARCHAR(200)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET nResultado = -1;
        SET cMensaje = 'Error al modificar concesionario';
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM concesionario WHERE id_concesionario = p_id) THEN
        SET nResultado = -2;
        SET cMensaje = 'No existe el concesionario';
        ROLLBACK;
    ELSEIF EXISTS(SELECT 1 FROM concesionario
                  WHERE nombre = p_nombre AND direccion = p_direccion
                  AND id_concesionario <> p_id) THEN
        SET nResultado = -3;
        SET cMensaje = 'Ya existe otro concesionario con ese nombre y direccion';
        ROLLBACK;
    ELSE
        UPDATE concesionario
        SET nombre = p_nombre, direccion = p_direccion
        WHERE id_concesionario = p_id;

        SET nResultado = 0;
        SET cMensaje = '';
        COMMIT;
    END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_bajaConcesionario;

DELIMITER //
CREATE PROCEDURE sp_bajaConcesionario(
    IN p_id INT,
    OUT nResultado INT,
    OUT cMensaje VARCHAR(200)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET nResultado = -1;
        SET cMensaje = 'Error al eliminar concesionario';
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM concesionario WHERE id_concesionario = p_id) THEN
        SET nResultado = -2;
        SET cMensaje = 'No existe el concesionario';
        ROLLBACK;
    ELSEIF EXISTS(SELECT 1 FROM pedido WHERE concesionario_id_concesionario = p_id) THEN
        SET nResultado = -3;
        SET cMensaje = 'No se puede eliminar el concesionario, ya que tiene pedidos asociados';
        ROLLBACK;
    ELSE
        DELETE FROM concesionario WHERE id_concesionario = p_id;

        SET nResultado = 0;
        SET cMensaje = '';
        COMMIT;
    END IF;
END //
DELIMITER ;


-- =========================================================
-- ALTA de Pedido (cabecera)
-- =========================================================
DROP PROCEDURE IF EXISTS sp_altaPedido;

DELIMITER //
CREATE PROCEDURE sp_altaPedido(
    IN p_id_concesionario INT,
    OUT p_id_pedido INT,
    OUT nResultado INT,
    OUT cMensaje VARCHAR(200)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET nResultado = -1;
        SET cMensaje = 'Error al insertar pedido';
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM concesionario WHERE id_concesionario = p_id_concesionario) THEN
        SET nResultado = -2;
        SET cMensaje = 'No existe el concesionario';
        ROLLBACK;
    ELSE
        INSERT INTO pedido(fecha_hora_pedido_realizado, fecha_entrega_estimada, concesionario_id_concesionario)
        VALUES (NOW(), NULL, p_id_concesionario);

        SET p_id_pedido = LAST_INSERT_ID();
        SET nResultado = 0;
        SET cMensaje = '';
        COMMIT;
    END IF;
END //
DELIMITER ;


-- =========================================================
-- MODIFICACION de Pedido (cabecera)
-- =========================================================
DROP PROCEDURE IF EXISTS sp_modificarPedido;

DELIMITER //
CREATE PROCEDURE sp_modificarPedido(
    IN p_id_pedido INT,
    IN p_id_concesionario INT,
    OUT nResultado INT,
    OUT cMensaje VARCHAR(200)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET nResultado = -1;
        SET cMensaje = 'Error al modificar pedido';
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM pedido WHERE id_pedido = p_id_pedido) THEN
        SET nResultado = -2;
        SET cMensaje = 'No existe el pedido';
        ROLLBACK;
    ELSEIF NOT EXISTS(SELECT 1 FROM concesionario WHERE id_concesionario = p_id_concesionario) THEN
        SET nResultado = -3;
        SET cMensaje = 'No existe el concesionario';
        ROLLBACK;
    ELSE
        UPDATE pedido
        SET concesionario_id_concesionario = p_id_concesionario
        WHERE id_pedido = p_id_pedido;

        SET nResultado = 0;
        SET cMensaje = '';
        COMMIT;
    END IF;
END //
DELIMITER ;


-- =========================================================
-- BAJA de Pedido (cabecera)
-- =========================================================
DROP PROCEDURE IF EXISTS sp_bajaPedido;

DELIMITER //
CREATE PROCEDURE sp_bajaPedido(
    IN p_id_pedido INT,
    OUT nResultado INT,
    OUT cMensaje VARCHAR(200)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET nResultado = -1;
        SET cMensaje = 'Error al eliminar pedido';
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM pedido WHERE id_pedido = p_id_pedido) THEN
        SET nResultado = -2;
        SET cMensaje = 'No existe el pedido';
        ROLLBACK;
    ELSEIF EXISTS(SELECT 1 FROM automovil WHERE pedido_id_pedido = p_id_pedido) THEN
        SET nResultado = -3;
        SET cMensaje = 'No se puede eliminar el pedido, ya que tiene automoviles asociados';
        ROLLBACK;
    ELSE
        DELETE FROM detalle_pedido WHERE pedido_id_pedido = p_id_pedido;
        DELETE FROM pedido WHERE id_pedido = p_id_pedido;

        SET nResultado = 0;
        SET cMensaje = '';
        COMMIT;
    END IF;
END //
DELIMITER ;

-- =========================================================
-- ALTA de Detalle de Pedido
-- =========================================================
DROP PROCEDURE IF EXISTS sp_altaPedidoDetalle;

DELIMITER //
CREATE PROCEDURE sp_altaPedidoDetalle(
    IN p_id_pedido INT,
    IN p_id_modelo INT,
    IN p_cantidad INT,
    OUT nResultado INT,
    OUT cMensaje VARCHAR(200)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET nResultado = -1;
        SET cMensaje = 'Error al insertar detalle del pedido';
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM pedido WHERE id_pedido = p_id_pedido) THEN
        SET nResultado = -2;
        SET cMensaje = 'No existe el pedido';
        ROLLBACK;
    ELSEIF NOT EXISTS(SELECT 1 FROM modelo WHERE id_modelo = p_id_modelo) THEN
        SET nResultado = -3;
        SET cMensaje = 'No existe el modelo';
        ROLLBACK;
    ELSEIF EXISTS(SELECT 1 FROM detalle_pedido
                  WHERE pedido_id_pedido = p_id_pedido AND modelo_id_modelo = p_id_modelo) THEN
        SET nResultado = -4;
        SET cMensaje = 'Ese modelo ya esta cargado en este pedido';
        ROLLBACK;
    ELSE
        INSERT INTO detalle_pedido(modelo_id_modelo, pedido_id_pedido, cantidad)
        VALUES (p_id_modelo, p_id_pedido, p_cantidad);

        SET nResultado = 0;
        SET cMensaje = '';
        COMMIT;
    END IF;
END //
DELIMITER ;


-- =========================================================
-- MODIFICACION de Detalle de Pedido
-- =========================================================
DROP PROCEDURE IF EXISTS sp_modificarPedidoDetalle;

DELIMITER //
CREATE PROCEDURE sp_modificarPedidoDetalle(
    IN p_id_pedido INT,
    IN p_id_modelo INT,
    IN p_cantidad INT,
    OUT nResultado INT,
    OUT cMensaje VARCHAR(200)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET nResultado = -1;
        SET cMensaje = 'Error al modificar detalle del pedido';
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM detalle_pedido
                  WHERE pedido_id_pedido = p_id_pedido AND modelo_id_modelo = p_id_modelo) THEN
        SET nResultado = -2;
        SET cMensaje = 'No existe ese detalle para el pedido indicado';
        ROLLBACK;
    ELSE
        UPDATE detalle_pedido
        SET cantidad = p_cantidad
        WHERE pedido_id_pedido = p_id_pedido AND modelo_id_modelo = p_id_modelo;

        SET nResultado = 0;
        SET cMensaje = '';
        COMMIT;
    END IF;
END //
DELIMITER ;


-- =========================================================
-- BAJA de Detalle de Pedido
-- =========================================================
DROP PROCEDURE IF EXISTS sp_bajaPedidoDetalle;

DELIMITER //
CREATE PROCEDURE sp_bajaPedidoDetalle(
    IN p_id_pedido INT,
    IN p_id_modelo INT,
    OUT nResultado INT,
    OUT cMensaje VARCHAR(200)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET nResultado = -1;
        SET cMensaje = 'Error al eliminar detalle del pedido';
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM detalle_pedido
                  WHERE pedido_id_pedido = p_id_pedido AND modelo_id_modelo = p_id_modelo) THEN
        SET nResultado = -2;
        SET cMensaje = 'No existe ese detalle para el pedido indicado';
        ROLLBACK;
    ELSEIF EXISTS(SELECT 1 FROM automovil
                  WHERE pedido_id_pedido = p_id_pedido AND modelo_id_modelo = p_id_modelo) THEN
        SET nResultado = -3;
        SET cMensaje = 'No se puede eliminar, ya se generaron automoviles para ese modelo en este pedido';
        ROLLBACK;
    ELSE
        DELETE FROM detalle_pedido
        WHERE pedido_id_pedido = p_id_pedido AND modelo_id_modelo = p_id_modelo;

        SET nResultado = 0;
        SET cMensaje = '';
        COMMIT;
    END IF;
END //
DELIMITER ;

-- -----------------------------------------------------
-- Procedimientos ABM para Modelo
-- -----------------------------------------------------

DROP PROCEDURE IF EXISTS sp_altaModelo;

DELIMITER //
CREATE PROCEDURE sp_altaModelo(
    IN p_nombre VARCHAR(45),
    OUT nResultado INT,
    OUT cMensaje VARCHAR(200)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET nResultado = -1;
        SET cMensaje = 'Error al insertar modelo';
    END;

    START TRANSACTION;

    IF EXISTS(SELECT 1 FROM modelo WHERE nombre = p_nombre) THEN
        SET nResultado = -2;
        SET cMensaje = 'Ya existe un modelo con ese nombre';
        ROLLBACK;
    ELSE
        INSERT INTO modelo(nombre)
        VALUES (p_nombre);

        SET nResultado = 0;
        SET cMensaje = '';
        COMMIT;
    END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_modificarModelo;

DELIMITER //
CREATE PROCEDURE sp_modificarModelo(
    IN p_id_modelo INT,
    IN p_nombre VARCHAR(45),
    OUT nResultado INT,
    OUT cMensaje VARCHAR(200)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET nResultado = -1;
        SET cMensaje = 'Error al modificar modelo';
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM modelo WHERE id_modelo = p_id_modelo) THEN
        SET nResultado = -2;
        SET cMensaje = 'No existe el modelo';
        ROLLBACK;
    ELSEIF EXISTS(SELECT 1 FROM modelo WHERE nombre = p_nombre AND id_modelo <> p_id_modelo) THEN
        SET nResultado = -3;
        SET cMensaje = 'Ya existe otro modelo con ese nombre';
        ROLLBACK;
    ELSE
        UPDATE modelo
        SET nombre = p_nombre
        WHERE id_modelo = p_id_modelo;

        SET nResultado = 0;
        SET cMensaje = '';
        COMMIT;
    END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_bajaModelo;

DELIMITER //
CREATE PROCEDURE sp_bajaModelo(
    IN p_id_modelo INT,
    OUT nResultado INT,
    OUT cMensaje VARCHAR(200)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET nResultado = -1;
        SET cMensaje = 'Error al eliminar modelo';
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM modelo WHERE id_modelo = p_id_modelo) THEN
        SET nResultado = -2;
        SET cMensaje = 'No existe el modelo';
        ROLLBACK;
    ELSEIF EXISTS(SELECT 1 FROM linea_de_montaje WHERE modelo_id_modelo = p_id_modelo) THEN
        SET nResultado = -3;
        SET cMensaje = 'No se puede eliminar el modelo, tiene una linea de montaje asociada';
        ROLLBACK;
    ELSEIF EXISTS(SELECT 1 FROM automovil WHERE modelo_id_modelo = p_id_modelo) THEN
        SET nResultado = -4;
        SET cMensaje = 'No se puede eliminar el modelo, ya que tiene automoviles asociados';
        ROLLBACK;
    ELSEIF EXISTS(SELECT 1 FROM detalle_pedido WHERE modelo_id_modelo = p_id_modelo) THEN
        SET nResultado = -5;
        SET cMensaje = 'No se puede eliminar el modelo, ya que tiene pedidos asociados';
        ROLLBACK;
    ELSE
        DELETE FROM modelo WHERE id_modelo = p_id_modelo;

        SET nResultado = 0;
        SET cMensaje = '';
        COMMIT;
    END IF;
END //
DELIMITER ;

-- -----------------------------------------------------
-- Procedimientos ABM para Proveedor
-- -----------------------------------------------------

DROP PROCEDURE IF EXISTS sp_altaProveedor;

DELIMITER //
CREATE PROCEDURE sp_altaProveedor(
    IN p_nombre VARCHAR(45),
    IN p_direccion VARCHAR(45),
    IN p_telefono VARCHAR(45),
    OUT nResultado INT,
    OUT cMensaje VARCHAR(200)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET nResultado = -1;
        SET cMensaje = 'Error al insertar proveedor';
    END;

    START TRANSACTION;

    IF EXISTS(SELECT 1 FROM proveedor 
              WHERE nombre_proveedor = p_nombre AND direccion_proveedor = p_direccion) THEN
        SET nResultado = -2;
        SET cMensaje = 'Ya existe un proveedor con ese nombre y dirección';
        ROLLBACK;
    ELSE
        INSERT INTO proveedor(nombre_proveedor, direccion_proveedor, telefono_proveedor)
        VALUES (p_nombre, p_direccion, p_telefono);

        SET nResultado = 0;
        SET cMensaje = '';
        COMMIT;
    END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_modificarProveedor;

DELIMITER //
CREATE PROCEDURE sp_modificarProveedor(
    IN p_id_proveedor INT,
    IN p_nombre VARCHAR(45),
    IN p_direccion VARCHAR(45),
    IN p_telefono VARCHAR(45),
    OUT nResultado INT,
    OUT cMensaje VARCHAR(200)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET nResultado = -1;
        SET cMensaje = 'Error al modificar proveedor';
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM proveedor WHERE id_proveedor = p_id_proveedor) THEN
        SET nResultado = -2;
        SET cMensaje = 'No existe el proveedor';
        ROLLBACK;
    ELSEIF EXISTS(SELECT 1 FROM proveedor 
                  WHERE nombre_proveedor = p_nombre AND direccion_proveedor = p_direccion 
                  AND id_proveedor <> p_id_proveedor) THEN
        SET nResultado = -3;
        SET cMensaje = 'Ya existe otro proveedor con ese nombre y dirección';
        ROLLBACK;
    ELSE
        UPDATE proveedor
        SET nombre_proveedor = p_nombre,
            direccion_proveedor = p_direccion,
            telefono_proveedor = p_telefono
        WHERE id_proveedor = p_id_proveedor;

        SET nResultado = 0;
        SET cMensaje = '';
        COMMIT;
    END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_bajaProveedor;

DELIMITER //
CREATE PROCEDURE sp_bajaProveedor(
    IN p_id_proveedor INT,
    OUT nResultado INT,
    OUT cMensaje VARCHAR(200)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET nResultado = -1;
        SET cMensaje = 'Error al eliminar proveedor';
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM proveedor WHERE id_proveedor = p_id_proveedor) THEN
        SET nResultado = -2;
        SET cMensaje = 'No existe el proveedor';
        ROLLBACK;
    ELSEIF EXISTS(SELECT 1 FROM compra WHERE proveedor_id_proveedor = p_id_proveedor) THEN
        SET nResultado = -3;
        SET cMensaje = 'No se puede eliminar el proveedor, tiene compras asociadas';
        ROLLBACK;
    ELSEIF EXISTS(SELECT 1 FROM proveedor_insumo WHERE proveedor_id_proveedor = p_id_proveedor) THEN
        SET nResultado = -4;
        SET cMensaje = 'No se puede eliminar el proveedor, tiene insumos asociados';
        ROLLBACK;
    ELSE
        DELETE FROM proveedor WHERE id_proveedor = p_id_proveedor;

        SET nResultado = 0;
        SET cMensaje = '';
        COMMIT;
    END IF;
END //
DELIMITER ;

-- -----------------------------------------------------
-- Procedimientos ABM para Insumo
-- -----------------------------------------------------

DROP PROCEDURE IF EXISTS sp_altaInsumo;

DELIMITER //
CREATE PROCEDURE sp_altaInsumo(
    IN p_codigo_insumo INT,
    IN p_descripcion VARCHAR(45),
    OUT nResultado INT,
    OUT cMensaje VARCHAR(200)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET nResultado = -1;
        SET cMensaje = 'Error al insertar insumo';
    END;

    START TRANSACTION;

    IF EXISTS(SELECT 1 FROM insumo WHERE codigo_insumo = p_codigo_insumo) THEN
        SET nResultado = -2;
        SET cMensaje = 'Ya existe un insumo con ese código';
        ROLLBACK;
    ELSE
        INSERT INTO insumo(codigo_insumo, descripcion_insumo)
        VALUES (p_codigo_insumo, p_descripcion);

        SET nResultado = 0;
        SET cMensaje = '';
        COMMIT;
    END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_modificarInsumo;

DELIMITER //
CREATE PROCEDURE sp_modificarInsumo(
    IN p_codigo_insumo INT,
    IN p_descripcion VARCHAR(45),
    OUT nResultado INT,
    OUT cMensaje VARCHAR(200)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET nResultado = -1;
        SET cMensaje = 'Error al modificar insumo';
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM insumo WHERE codigo_insumo = p_codigo_insumo) THEN
        SET nResultado = -2;
        SET cMensaje = 'No existe el insumo';
        ROLLBACK;
    ELSE
        UPDATE insumo
        SET descripcion_insumo = p_descripcion
        WHERE codigo_insumo = p_codigo_insumo;

        SET nResultado = 0;
        SET cMensaje = '';
        COMMIT;
    END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_bajaInsumo;

DELIMITER //
CREATE PROCEDURE sp_bajaInsumo(
    IN p_codigo_insumo INT,
    OUT nResultado INT,
    OUT cMensaje VARCHAR(200)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET nResultado = -1;
        SET cMensaje = 'Error al eliminar insumo';
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM insumo WHERE codigo_insumo = p_codigo_insumo) THEN
        SET nResultado = -2;
        SET cMensaje = 'No existe el insumo';
        ROLLBACK;
    ELSEIF EXISTS(SELECT 1 FROM detalle_compra WHERE insumo_codigo_insumo = p_codigo_insumo) THEN
        SET nResultado = -3;
        SET cMensaje = 'No se puede eliminar el insumo, tiene detalles de compra asociados';
        ROLLBACK;
    ELSEIF EXISTS(SELECT 1 FROM estacion_has_insumo WHERE insumo_codigo_insumo = p_codigo_insumo) THEN
        SET nResultado = -4;
        SET cMensaje = 'No se puede eliminar el insumo, está asignado a una estación';
        ROLLBACK;
    ELSEIF EXISTS(SELECT 1 FROM proveedor_insumo WHERE insumo_codigo_insumo = p_codigo_insumo) THEN
        SET nResultado = -5;
        SET cMensaje = 'No se puede eliminar el insumo, tiene proveedores asociados';
        ROLLBACK;
    ELSE
        DELETE FROM insumo WHERE codigo_insumo = p_codigo_insumo;

        SET nResultado = 0;
        SET cMensaje = '';
        COMMIT;
    END IF;
END //
DELIMITER ;

