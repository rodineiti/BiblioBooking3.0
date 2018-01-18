SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `bdbiblioteca` DEFAULT CHARACTER SET latin1 ;
USE `bdbiblioteca` ;

-- -----------------------------------------------------
-- Table `bdbiblioteca`.`tbcurso`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `bdbiblioteca`.`tbcurso` (
  `curId` INT(11) NOT NULL AUTO_INCREMENT ,
  `curDescricao` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`curId`) )
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `bdbiblioteca`.`tbturma`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `bdbiblioteca`.`tbturma` (
  `turId` INT(11) NOT NULL AUTO_INCREMENT ,
  `turDescricao` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`turId`) )
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `bdbiblioteca`.`tbaluno`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `bdbiblioteca`.`tbaluno` (
  `aluId` INT(11) NOT NULL AUTO_INCREMENT ,
  `curId` INT(11) NOT NULL ,
  `turId` INT(11) NOT NULL ,
  `aluNome` VARCHAR(60) NOT NULL ,
  `aluEmail` VARCHAR(60) NOT NULL ,
  `aluCPF` VARCHAR(11) NOT NULL ,
  `aluSenha` VARCHAR(20) NOT NULL ,
  `aluEndereco` VARCHAR(60) NULL DEFAULT NULL ,
  `aluBairro` VARCHAR(60) NULL DEFAULT NULL ,
  `aluCidade` VARCHAR(60) NULL DEFAULT NULL ,
  `aluUF` CHAR(2) NULL DEFAULT NULL ,
  `aluCEP` VARCHAR(10) NULL DEFAULT NULL ,
  `aluFone` VARCHAR(20) NULL DEFAULT NULL ,
  `aluCelular` VARCHAR(20) NULL DEFAULT NULL ,
  `aluSituacao` CHAR(1) NOT NULL ,
  `aluObservacao` LONGTEXT NULL DEFAULT NULL ,
  `aluCadastro` DATETIME NULL DEFAULT NULL ,
  `aluAlteracao` DATETIME NULL DEFAULT NULL ,
  `aluUltAcesso` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`aluId`) ,
  INDEX `curId_idx` (`curId` ASC) ,
  INDEX `turId_idx` (`turId` ASC) ,
  CONSTRAINT `alunoCurId`
    FOREIGN KEY (`curId` )
    REFERENCES `bdbiblioteca`.`tbcurso` (`curId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `alunoTurId`
    FOREIGN KEY (`turId` )
    REFERENCES `bdbiblioteca`.`tbturma` (`turId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `bdbiblioteca`.`tbautor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `bdbiblioteca`.`tbautor` (
  `autId` INT(11) NOT NULL AUTO_INCREMENT ,
  `autNome` VARCHAR(50) NOT NULL ,
  `autNomeCientifico` VARCHAR(50) NULL DEFAULT NULL ,
  `autBibliografia` LONGTEXT NULL DEFAULT NULL ,
  PRIMARY KEY (`autId`) )
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `bdbiblioteca`.`tbcategoria`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `bdbiblioteca`.`tbcategoria` (
  `catId` INT(11) NOT NULL AUTO_INCREMENT ,
  `catDescricao` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`catId`) )
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `bdbiblioteca`.`tbeditora`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `bdbiblioteca`.`tbeditora` (
  `ediId` INT(11) NOT NULL AUTO_INCREMENT ,
  `ediNome` VARCHAR(60) NOT NULL ,
  `ediEndereco` VARCHAR(60) NULL DEFAULT NULL ,
  `ediBairro` VARCHAR(60) NULL DEFAULT NULL ,
  `ediCidade` VARCHAR(60) NULL DEFAULT NULL ,
  `ediCEP` VARCHAR(10) NULL DEFAULT NULL ,
  `ediFone` VARCHAR(20) NULL DEFAULT NULL ,
  `ediUF` CHAR(2) NULL DEFAULT NULL ,
  PRIMARY KEY (`ediId`) )
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `bdbiblioteca`.`tbreserva`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `bdbiblioteca`.`tbreserva` (
  `resId` INT(11) NOT NULL AUTO_INCREMENT ,
  `aluId` INT(11) NOT NULL ,
  `resDataReserva` DATETIME NOT NULL ,
  `resStatus` CHAR(1) NOT NULL DEFAULT 'S' ,
  PRIMARY KEY (`resId`) ,
  INDEX `reservaAluId_idx` (`aluId` ASC) ,
  CONSTRAINT `reservaAluId`
    FOREIGN KEY (`aluId` )
    REFERENCES `bdbiblioteca`.`tbaluno` (`aluId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `bdbiblioteca`.`tbemprestimo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `bdbiblioteca`.`tbemprestimo` (
  `empId` INT(11) NOT NULL AUTO_INCREMENT ,
  `resId` INT(11) NOT NULL ,
  `empData` DATETIME NOT NULL ,
  `empPrevDevolucao` DATE NOT NULL ,
  `empDataDevolucao` DATETIME NOT NULL ,
  `empStatus` CHAR(1) NOT NULL DEFAULT 'S' ,
  PRIMARY KEY (`empId`, `resId`) ,
  INDEX `EmprestimoResId_idx` (`resId` ASC) ,
  CONSTRAINT `EmprestimoResId`
    FOREIGN KEY (`resId` )
    REFERENCES `bdbiblioteca`.`tbreserva` (`resId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `bdbiblioteca`.`tbtipolivro`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `bdbiblioteca`.`tbtipolivro` (
  `tipId` INT(11) NOT NULL AUTO_INCREMENT ,
  `tipDescricao` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`tipId`) )
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `bdbiblioteca`.`tblivro`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `bdbiblioteca`.`tblivro` (
  `livId` INT(11) NOT NULL AUTO_INCREMENT ,
  `autId` INT(11) NOT NULL ,
  `ediId` INT(11) NOT NULL ,
  `catId` INT(11) NOT NULL ,
  `tipId` INT(11) NOT NULL ,
  `livISBN` BIGINT(20) NOT NULL ,
  `livTitulo` VARCHAR(255) NOT NULL ,
  `livAno` INT(11) NOT NULL ,
  `livEdicao` VARCHAR(50) NULL DEFAULT NULL ,
  `livLocalizacao` VARCHAR(30) NOT NULL ,
  `livCapa` VARCHAR(45) NULL DEFAULT NULL ,
  `livObservacao` LONGTEXT NULL DEFAULT NULL ,
  `livPaginas` INT(11) NULL DEFAULT NULL ,
  `livDataCadastro` DATETIME NULL DEFAULT NULL ,
  `livStatus` CHAR(1) NOT NULL ,
  PRIMARY KEY (`livId`) ,
  INDEX `livroAutId_idx` (`autId` ASC) ,
  INDEX `livroEdiId_idx` (`ediId` ASC) ,
  INDEX `livroCatId_idx` (`catId` ASC) ,
  INDEX `livroTipId_idx` (`tipId` ASC) ,
  CONSTRAINT `livroAutId`
    FOREIGN KEY (`autId` )
    REFERENCES `bdbiblioteca`.`tbautor` (`autId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `livroCatId`
    FOREIGN KEY (`catId` )
    REFERENCES `bdbiblioteca`.`tbcategoria` (`catId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `livroEdiId`
    FOREIGN KEY (`ediId` )
    REFERENCES `bdbiblioteca`.`tbeditora` (`ediId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `livroTipId`
    FOREIGN KEY (`tipId` )
    REFERENCES `bdbiblioteca`.`tbtipolivro` (`tipId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `bdbiblioteca`.`tbitemreserva`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `bdbiblioteca`.`tbitemreserva` (
  `iteId` INT(11) NOT NULL AUTO_INCREMENT ,
  `livId` INT(11) NOT NULL ,
  `resId` INT(11) NOT NULL ,
  `iteData` DATETIME NOT NULL ,
  PRIMARY KEY (`iteId`) ,
  INDEX `itemReservaLivId_idx` (`livId` ASC) ,
  INDEX `itemReservaResId` (`resId` ASC) ,
  CONSTRAINT `itemReservaLivId`
    FOREIGN KEY (`livId` )
    REFERENCES `bdbiblioteca`.`tblivro` (`livId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `itemReservaResId`
    FOREIGN KEY (`resId` )
    REFERENCES `bdbiblioteca`.`tbreserva` (`resId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = latin1;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
