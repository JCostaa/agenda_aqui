-- MySQL Script generated by MySQL Workbench
-- Thu Apr  1 16:24:38 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`features_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`features_category` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`features`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`features` (
  `id` INT NOT NULL,
  `features_category_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_features_features_category1_idx` (`features_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_features_features_category1`
    FOREIGN KEY (`features_category_id`)
    REFERENCES `mydb`.`features_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`permissions` (
  `id` INT NOT NULL,
  `features_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_permissions_features1_idx` (`features_id` ASC) VISIBLE,
  CONSTRAINT `fk_permissions_features1`
    FOREIGN KEY (`features_id`)
    REFERENCES `mydb`.`features` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`roles` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`plans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`plans` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`subscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`subscriptions` (
  `id` INT NOT NULL,
  `plans_id` INT NOT NULL,
  PRIMARY KEY (`id`, `plans_id`),
  INDEX `fk_subscriptions_plans1_idx` (`plans_id` ASC) VISIBLE,
  CONSTRAINT `fk_subscriptions_plans1`
    FOREIGN KEY (`plans_id`)
    REFERENCES `mydb`.`plans` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`users_has_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users_has_roles` (
  `users_id` INT NOT NULL,
  `roles_id` INT NOT NULL,
  PRIMARY KEY (`users_id`, `roles_id`),
  INDEX `fk_users_has_roles_roles1_idx` (`roles_id` ASC) VISIBLE,
  INDEX `fk_users_has_roles_users_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_roles_users`
    FOREIGN KEY (`users_id`)
    REFERENCES `mydb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_roles_roles1`
    FOREIGN KEY (`roles_id`)
    REFERENCES `mydb`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`roles_has_permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`roles_has_permissions` (
  `roles_id` INT NOT NULL,
  `permissions_id` INT NOT NULL,
  PRIMARY KEY (`roles_id`, `permissions_id`),
  INDEX `fk_roles_has_permissions_permissions1_idx` (`permissions_id` ASC) VISIBLE,
  INDEX `fk_roles_has_permissions_roles1_idx` (`roles_id` ASC) VISIBLE,
  CONSTRAINT `fk_roles_has_permissions_roles1`
    FOREIGN KEY (`roles_id`)
    REFERENCES `mydb`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_roles_has_permissions_permissions1`
    FOREIGN KEY (`permissions_id`)
    REFERENCES `mydb`.`permissions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`subsidiaries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`subsidiaries` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`companies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`companies` (
  `id` INT NOT NULL,
  `subsidiaries_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_companies_subsidiaries1_idx` (`subsidiaries_id` ASC) VISIBLE,
  CONSTRAINT `fk_companies_subsidiaries1`
    FOREIGN KEY (`subsidiaries_id`)
    REFERENCES `mydb`.`subsidiaries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customers` (
  `id` INT NOT NULL,
  `companies_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_customers_companies1_idx` (`companies_id` ASC) VISIBLE,
  CONSTRAINT `fk_customers_companies1`
    FOREIGN KEY (`companies_id`)
    REFERENCES `mydb`.`companies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`companies_has_subscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`companies_has_subscriptions` (
  `companies_id` INT NOT NULL,
  `subscriptions_id` INT NOT NULL,
  `subscriptions_plans_id` INT NOT NULL,
  PRIMARY KEY (`companies_id`, `subscriptions_id`, `subscriptions_plans_id`),
  INDEX `fk_companies_has_subscriptions_subscriptions1_idx` (`subscriptions_id` ASC, `subscriptions_plans_id` ASC) VISIBLE,
  INDEX `fk_companies_has_subscriptions_companies1_idx` (`companies_id` ASC) VISIBLE,
  CONSTRAINT `fk_companies_has_subscriptions_companies1`
    FOREIGN KEY (`companies_id`)
    REFERENCES `mydb`.`companies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_companies_has_subscriptions_subscriptions1`
    FOREIGN KEY (`subscriptions_id` , `subscriptions_plans_id`)
    REFERENCES `mydb`.`subscriptions` (`id` , `plans_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`features_has_plans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`features_has_plans` (
  `features_id` INT NOT NULL,
  `plans_id` INT NOT NULL,
  PRIMARY KEY (`features_id`, `plans_id`),
  INDEX `fk_features_has_plans_plans1_idx` (`plans_id` ASC) VISIBLE,
  INDEX `fk_features_has_plans_features1_idx` (`features_id` ASC) VISIBLE,
  CONSTRAINT `fk_features_has_plans_features1`
    FOREIGN KEY (`features_id`)
    REFERENCES `mydb`.`features` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_features_has_plans_plans1`
    FOREIGN KEY (`plans_id`)
    REFERENCES `mydb`.`plans` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`agendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`agendas` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`calendars`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`calendars` (
  `id` INT NOT NULL,
  `agendas_id` INT NOT NULL,
  PRIMARY KEY (`id`, `agendas_id`),
  INDEX `fk_calendars_agendas1_idx` (`agendas_id` ASC) VISIBLE,
  CONSTRAINT `fk_calendars_agendas1`
    FOREIGN KEY (`agendas_id`)
    REFERENCES `mydb`.`agendas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`schedules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`schedules` (
  `id` INT NOT NULL,
  `calendars_id` INT NOT NULL,
  PRIMARY KEY (`id`, `calendars_id`),
  INDEX `fk_schedules_calendars1_idx` (`calendars_id` ASC) VISIBLE,
  CONSTRAINT `fk_schedules_calendars1`
    FOREIGN KEY (`calendars_id`)
    REFERENCES `mydb`.`calendars` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`employees` (
  `id` INT NOT NULL,
  `subsidiaries_id` INT NOT NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`id`, `subsidiaries_id`),
  INDEX `fk_employees_subsidiaries1_idx` (`subsidiaries_id` ASC) VISIBLE,
  INDEX `fk_employees_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_employees_subsidiaries1`
    FOREIGN KEY (`subsidiaries_id`)
    REFERENCES `mydb`.`subsidiaries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employees_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `mydb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`services` (
  `id` INT NOT NULL,
  `companies_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_services_companies1_idx` (`companies_id` ASC) VISIBLE,
  CONSTRAINT `fk_services_companies1`
    FOREIGN KEY (`companies_id`)
    REFERENCES `mydb`.`companies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`services_has_subsidiaries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`services_has_subsidiaries` (
  `services_id` INT NOT NULL,
  `subsidiaries_id` INT NOT NULL,
  PRIMARY KEY (`services_id`, `subsidiaries_id`),
  INDEX `fk_services_has_subsidiaries_subsidiaries1_idx` (`subsidiaries_id` ASC) VISIBLE,
  INDEX `fk_services_has_subsidiaries_services1_idx` (`services_id` ASC) VISIBLE,
  CONSTRAINT `fk_services_has_subsidiaries_services1`
    FOREIGN KEY (`services_id`)
    REFERENCES `mydb`.`services` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_services_has_subsidiaries_subsidiaries1`
    FOREIGN KEY (`subsidiaries_id`)
    REFERENCES `mydb`.`subsidiaries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`opening_hours`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`opening_hours` (
  `id` INT NOT NULL,
  `subsidiaries_id` INT NOT NULL,
  `start_time` TIME NULL,
  `end_time` TIME NULL,
  `day` VARCHAR(45) NULL,
  `open` TINYINT NULL,
  PRIMARY KEY (`id`, `subsidiaries_id`),
  INDEX `fk_opening_hours_subsidiaries1_idx` (`subsidiaries_id` ASC) VISIBLE,
  CONSTRAINT `fk_opening_hours_subsidiaries1`
    FOREIGN KEY (`subsidiaries_id`)
    REFERENCES `mydb`.`subsidiaries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`special_opening_hours`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`special_opening_hours` (
  `id` INT NOT NULL,
  `date` DATETIME NULL,
  `start_time` TIME NULL,
  `end_time` TIME NULL,
  `subsidiaries_id` INT NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`id`, `subsidiaries_id`),
  INDEX `fk_special_opening_hours_subsidiaries1_idx` (`subsidiaries_id` ASC) VISIBLE,
  CONSTRAINT `fk_special_opening_hours_subsidiaries1`
    FOREIGN KEY (`subsidiaries_id`)
    REFERENCES `mydb`.`subsidiaries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`work_hours`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`work_hours` (
  `id` INT NOT NULL,
  `employees_id` INT NOT NULL,
  `date` DATETIME NULL,
  `start_time` TIME NULL,
  `end_time` TIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_work_hours_employees1_idx` (`employees_id` ASC) VISIBLE,
  CONSTRAINT `fk_work_hours_employees1`
    FOREIGN KEY (`employees_id`)
    REFERENCES `mydb`.`employees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`special_work_hours`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`special_work_hours` (
  `id` INT NOT NULL,
  `date` DATETIME NULL,
  `start_time` TIME NULL,
  `end_time` TIME NULL,
  `description` VARCHAR(45) NULL,
  `employees_id` INT NOT NULL,
  `employees_subsidiaries_id` INT NOT NULL,
  PRIMARY KEY (`id`, `employees_id`, `employees_subsidiaries_id`),
  INDEX `fk_special_work_hours_employees1_idx` (`employees_id` ASC, `employees_subsidiaries_id` ASC) VISIBLE,
  CONSTRAINT `fk_special_work_hours_employees1`
    FOREIGN KEY (`employees_id` , `employees_subsidiaries_id`)
    REFERENCES `mydb`.`employees` (`id` , `subsidiaries_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`services_has_employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`services_has_employees` (
  `services_id` INT NOT NULL,
  `employees_id` INT NOT NULL,
  PRIMARY KEY (`services_id`, `employees_id`),
  INDEX `fk_services_has_employees_employees1_idx` (`employees_id` ASC) VISIBLE,
  INDEX `fk_services_has_employees_services1_idx` (`services_id` ASC) VISIBLE,
  CONSTRAINT `fk_services_has_employees_services1`
    FOREIGN KEY (`services_id`)
    REFERENCES `mydb`.`services` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_services_has_employees_employees1`
    FOREIGN KEY (`employees_id`)
    REFERENCES `mydb`.`employees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;