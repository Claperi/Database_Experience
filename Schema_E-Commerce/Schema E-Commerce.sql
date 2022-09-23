-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema E-Commerce
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema E-Commerce
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `E-Commerce` DEFAULT CHARACTER SET utf8 ;
USE `E-Commerce` ;

-- -----------------------------------------------------
-- Table `E-Commerce`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-Commerce`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Pnome` VARCHAR(10) NOT NULL,
  `Nome do meio` VARCHAR(3) NULL,
  `Sobrenome` VARCHAR(20) NULL,
  `CPF` CHAR(11) NOT NULL,
  `Endereço` VARCHAR(45) NULL COMMENT 'Atributo composto: Rua, BAirro, Complemento, CEP, Cidade, Estado',
  `Data de Nascimento` DATE NOT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `E-Commerce`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-Commerce`.`Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `Status do Pedido` ENUM('Cancelado', 'Confirmado', 'Processamento') NULL DEFAULT 'Processamento',
  `Descrição` VARCHAR(45) NULL,
  `Frete` FLOAT NULL DEFAULT 10,
  `Pagamento` TINYINT NULL DEFAULT 0,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idPedido`, `Cliente_idCliente`),
  INDEX `fk_Pedido_Cliente_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `E-Commerce`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `E-Commerce`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-Commerce`.`Produto` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(10) NULL,
  `Classificação` TINYINT NULL DEFAULT 0,
  `Categoria` ENUM('Vestimenta', 'Brinquedos', 'Alimentos') NOT NULL,
  `Avaliação` FLOAT NULL DEFAULT 0,
  `size` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `E-Commerce`.`Terceiro - Vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-Commerce`.`Terceiro - Vendedor` (
  `idTerceiro - Vendedor` INT NOT NULL AUTO_INCREMENT,
  `Razão Social` VARCHAR(45) NOT NULL,
  `Nome Fantasia` VARCHAR(45) NULL,
  `CNPJ` CHAR(15) NOT NULL,
  `CPF` CHAR(9) NULL,
  `Local` VARCHAR(45) NOT NULL,
  `Contato` CHAR(11) NULL,
  PRIMARY KEY (`idTerceiro - Vendedor`),
  UNIQUE INDEX `Razão Social_UNIQUE` (`Razão Social` ASC) VISIBLE,
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE,
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `E-Commerce`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-Commerce`.`Estoque` (
  `idEstoque` INT NOT NULL,
  `Local` VARCHAR(45) NOT NULL,
  `Quantidade` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idEstoque`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `E-Commerce`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-Commerce`.`Fornecedor` (
  `idFornecedor` INT NOT NULL,
  `Razão Social` VARCHAR(45) NOT NULL,
  `CNPJ` CHAR(15) NOT NULL,
  `Contato` CHAR(11) NOT NULL,
  PRIMARY KEY (`idFornecedor`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `E-Commerce`.`Produto/Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-Commerce`.`Produto/Pedido` (
  `Produto_idProduto` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Quantidade` VARCHAR(45) NULL,
  `Status` ENUM('Disponível', 'Sem Estoque') NULL DEFAULT 'Disponível',
  PRIMARY KEY (`Produto_idProduto`, `Pedido_idPedido`),
  INDEX `fk_Pedido_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Pedido_has_Produto_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_has_Produto_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `E-Commerce`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `E-Commerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `E-Commerce`.`Produto_Vendedor (Terceiro)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-Commerce`.`Produto_Vendedor (Terceiro)` (
  `Produto_idProduto` INT NOT NULL AUTO_INCREMENT,
  `Terceiro - Vendedor_idTerceiro - Vendedor` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Terceiro - Vendedor_idTerceiro - Vendedor`),
  INDEX `fk_Produto_has_Terceiro - Vendedor_Terceiro - Vendedor1_idx` (`Terceiro - Vendedor_idTerceiro - Vendedor` ASC) VISIBLE,
  INDEX `fk_Produto_has_Terceiro - Vendedor_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Terceiro - Vendedor_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `E-Commerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Terceiro - Vendedor_Terceiro - Vendedor1`
    FOREIGN KEY (`Terceiro - Vendedor_idTerceiro - Vendedor`)
    REFERENCES `E-Commerce`.`Terceiro - Vendedor` (`idTerceiro - Vendedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `E-Commerce`.`Produto em Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-Commerce`.`Produto em Estoque` (
  `Estoque_idEstoque` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Quantidade` INT NULL,
  `Localização` VARCHAR(45) NULL,
  `Produto em Estoquecol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Estoque_idEstoque`, `Produto_idProduto`),
  INDEX `fk_Produto_has_Estoque_Estoque1_idx` (`Estoque_idEstoque` ASC) VISIBLE,
  INDEX `fk_Produto_has_Estoque_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Estoque_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `E-Commerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Estoque_Estoque1`
    FOREIGN KEY (`Estoque_idEstoque`)
    REFERENCES `E-Commerce`.`Estoque` (`idEstoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `E-Commerce`.`Produto_Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-Commerce`.`Produto_Fornecedor` (
  `Fornecedor_idFornecedor` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`Fornecedor_idFornecedor`, `Produto_idProduto`),
  INDEX `fk_Produto_has_Fornecedor_Fornecedor1_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  INDEX `fk_Produto_has_Fornecedor_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Fornecedor_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `E-Commerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Fornecedor_Fornecedor1`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `E-Commerce`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `E-Commerce`.`Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-Commerce`.`Pagamento` (
  `idPagamento` INT NOT NULL,
  `Formas de Pagamento` ENUM('Boleto', 'Cartão', 'Dois Cartões') NOT NULL,
  `Pagamentocol` FLOAT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Pedido_Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idPagamento`, `Pedido_idPedido`, `Pedido_Cliente_idCliente`),
  INDEX `fk_Pagamento_Pedido1_idx` (`Pedido_idPedido` ASC, `Pedido_Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamento_Pedido1`
    FOREIGN KEY (`Pedido_idPedido` , `Pedido_Cliente_idCliente`)
    REFERENCES `E-Commerce`.`Pedido` (`idPedido` , `Cliente_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
