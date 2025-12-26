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
-- Table `mydb`.`payement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`payement` (
  `payement_id` INT NOT NULL,
  `amount` DECIMAL NULL,
  `payement_mode` VARCHAR(30) NULL,
  `payement_date` DATE NULL,
  PRIMARY KEY (`payement_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`food_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`food_order` (
  `order_id` INT NOT NULL,
  `item_name` VARCHAR(100) NOT NULL,
  `food_ordercol` VARCHAR(45) NOT NULL,
  `price` DECIMAL NULL,
  PRIMARY KEY (`order_id`, `item_name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ticket` (
  `ticket_id` INT NOT NULL,
  `travel_date` DATE NULL,
  `status` VARCHAR(20) NULL,
  `train_train_id` INT NOT NULL,
  `payement_payement_id` INT NOT NULL,
  `food_order_order_id` INT NOT NULL,
  `food_order_item_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ticket_id`, `payement_payement_id`, `food_order_order_id`, `food_order_item_name`),
  INDEX `fk_ticket_train1_idx` (`train_train_id` ASC) VISIBLE,
  INDEX `fk_ticket_payement1_idx` (`payement_payement_id` ASC) VISIBLE,
  INDEX `fk_ticket_food_order1_idx` (`food_order_order_id` ASC, `food_order_item_name` ASC) VISIBLE,
  CONSTRAINT `fk_ticket_train1`
    FOREIGN KEY (`train_train_id`)
    REFERENCES `mydb`.`train` (`train_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_payement1`
    FOREIGN KEY (`payement_payement_id`)
    REFERENCES `mydb`.`payement` (`payement_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_food_order1`
    FOREIGN KEY (`food_order_order_id` , `food_order_item_name`)
    REFERENCES `mydb`.`food_order` (`order_id` , `item_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`seat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`seat` (
  `seat_id` INT NOT NULL,
  `seat_number` VARCHAR(10) NULL,
  `ticket_ticket_id` INT NOT NULL,
  PRIMARY KEY (`seat_id`),
  INDEX `fk_seat_ticket1_idx` (`ticket_ticket_id` ASC) VISIBLE,
  CONSTRAINT `fk_seat_ticket1`
    FOREIGN KEY (`ticket_ticket_id`)
    REFERENCES `mydb`.`ticket` (`ticket_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`coach`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`coach` (
  `coach_id` VARCHAR(2) NOT NULL,
  `coach_type` VARCHAR(10) NULL,
  `capacity` INT NULL,
  `seat_seat_id` INT NOT NULL,
  PRIMARY KEY (`coach_id`),
  INDEX `fk_coach_seat1_idx` (`seat_seat_id` ASC) VISIBLE,
  CONSTRAINT `fk_coach_seat1`
    FOREIGN KEY (`seat_seat_id`)
    REFERENCES `mydb`.`seat` (`seat_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`duty_assignment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`duty_assignment` (
  `duty_date` DATE NOT NULL,
  PRIMARY KEY (`duty_date`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`train`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`train` (
  `train_id` INT NOT NULL,
  `train_number` VARCHAR(10) NULL,
  `train_name` VARCHAR(100) NULL,
  `train_type` VARCHAR(30) NULL,
  `coach_coach_id` VARCHAR(2) NOT NULL,
  `duty_assignment_duty_date` DATE NOT NULL,
  PRIMARY KEY (`train_id`),
  INDEX `fk_train_coach1_idx` (`coach_coach_id` ASC) VISIBLE,
  INDEX `fk_train_duty_assignment1_idx` (`duty_assignment_duty_date` ASC) VISIBLE,
  CONSTRAINT `fk_train_coach1`
    FOREIGN KEY (`coach_coach_id`)
    REFERENCES `mydb`.`coach` (`coach_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_train_duty_assignment1`
    FOREIGN KEY (`duty_assignment_duty_date`)
    REFERENCES `mydb`.`duty_assignment` (`duty_date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`passenger`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`passenger` (
  `passenger_id` INT NOT NULL,
  `name` VARCHAR(100) NULL,
  `age` INT NULL,
  `gender` CHAR(1) NULL,
  `mobile` VARCHAR(12) NULL,
  `ticket_ticket_id` INT NOT NULL,
  PRIMARY KEY (`passenger_id`),
  INDEX `fk_passenger_ticket_idx` (`ticket_ticket_id` ASC) VISIBLE,
  CONSTRAINT `fk_passenger_ticket`
    FOREIGN KEY (`ticket_ticket_id`)
    REFERENCES `mydb`.`ticket` (`ticket_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`station`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`station` (
  `station_id` INT NOT NULL,
  `station_code` CHAR(5) NULL,
  `station_name` VARCHAR(100) NULL,
  `state` VARCHAR(50) NULL,
  PRIMARY KEY (`station_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`route`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`route` (
  `route_id` INT NOT NULL,
  `route_name` VARCHAR(100) NULL,
  `train_train_id` INT NOT NULL,
  `station_station_id` INT NOT NULL,
  PRIMARY KEY (`route_id`, `station_station_id`),
  INDEX `fk_route_train1_idx` (`train_train_id` ASC) VISIBLE,
  INDEX `fk_route_station1_idx` (`station_station_id` ASC) VISIBLE,
  CONSTRAINT `fk_route_train1`
    FOREIGN KEY (`train_train_id`)
    REFERENCES `mydb`.`train` (`train_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_route_station1`
    FOREIGN KEY (`station_station_id`)
    REFERENCES `mydb`.`station` (`station_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`staff` (
  `staff_id` INT NOT NULL,
  `staff_name` VARCHAR(100) NULL,
  `role` VARCHAR(50) NULL,
  `duty_assignment_duty_date` DATE NOT NULL,
  PRIMARY KEY (`staff_id`),
  INDEX `fk_staff_duty_assignment1_idx` (`duty_assignment_duty_date` ASC) VISIBLE,
  CONSTRAINT `fk_staff_duty_assignment1`
    FOREIGN KEY (`duty_assignment_duty_date`)
    REFERENCES `mydb`.`duty_assignment` (`duty_date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`vendor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`vendor` (
  `vendor_id` INT NOT NULL,
  `vendor_name` VARCHAR(100) NULL,
  `food_order_order_id` INT NOT NULL,
  `food_order_item_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`vendor_id`),
  INDEX `fk_vendor_food_order1_idx` (`food_order_order_id` ASC, `food_order_item_name` ASC) VISIBLE,
  CONSTRAINT `fk_vendor_food_order1`
    FOREIGN KEY (`food_order_order_id` , `food_order_item_name`)
    REFERENCES `mydb`.`food_order` (`order_id` , `item_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
