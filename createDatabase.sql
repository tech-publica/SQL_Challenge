

DROP TABLE IF EXISTS `academia`.`activity`;
DROP TABLE IF EXISTS `academia`.`student_feedback`;
DROP TABLE IF EXISTS `academia`.`teaching_assignment`;
DROP TABLE IF EXISTS `academia`.`competence`;
DROP TABLE IF EXISTS `academia`.`skill`;
DROP TABLE IF EXISTS `academia`.`lesson`; 
DROP TABLE IF EXISTS `academia`.`enrollment`;  
DROP TABLE IF EXISTS `academia`.`student`;    
DROP TABLE IF EXISTS `academia`.`client`;   
DROP TABLE IF EXISTS `academia`.`course_edition`;  
DROP TABLE IF EXISTS `academia`.`course`;  
DROP TABLE IF EXISTS `academia`.`area`;
DROP TABLE IF EXISTS `academia`.`project`;
DROP TABLE IF EXISTS `academia`.`classroom`;    
DROP TABLE IF EXISTS `academia`.`agent`;

CREATE TABLE `academia`.`agent` (
  `agent_id` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `sex` CHAR(1) NOT NULL,
  `birthdate` DATE NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(13) NOT NULL,
  `isEmployee` TINYINT NOT NULL DEFAULT 1,
  `hourlyRate` DECIMAL(13,2) NULL,
  `phone` VARCHAR(18) NOT NULL,
  `email` VARCHAR(18) NOT NULL,
  `website` VARCHAR(18) NULL,
  PRIMARY KEY (`agent_id`));


  CREATE TABLE `academia`.`classroom` (
  `classroom_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(18) NOT NULL,
  `capacity` INT NOT NULL DEFAULT 20,
  `computerized` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`classroom_id`));



  CREATE TABLE `academia`.`project` (
  `project_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `start` DATE NOT NULL,
  `end` DATE NULL,
  `budget` DECIMAL(13,2) NOT NULL,
  `isFinanced` TINYINT NOT NULL DEFAULT 0,
  `managerId` INT NOT NULL,
  PRIMARY KEY (`project_id`),
  INDEX `project_agent_idx` (`managerId` ASC) VISIBLE,
  CONSTRAINT `project_agent`
    FOREIGN KEY (`managerId`)
    REFERENCES `academia`.`agent` (`agent_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE);


CREATE TABLE `academia`.`area` (
  `area_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(18) NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`area_id`));



 CREATE TABLE `course` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(25) NOT NULL,
  `decription` VARCHAR(100) NOT NULL,
  `syllabus` VARCHAR(120) DEFAULT NULL,
  `area_id` INT NOT NULL,
  `numHours` INT NOT NULL,
  `level` TINYINT DEFAULT NULL,
  `cost` decimal(13,2) NOT NULL,
  `project_id` INT NOT NULL,
  PRIMARY KEY (`course_id`),
  KEY `course_area_idx` (`area_id`),
  KEY `course_project_idx` (`project_id`),
  CONSTRAINT `course_area` FOREIGN KEY (`area_id`) REFERENCES `area` (`area_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `course_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`)
 );



CREATE TABLE `course_edition` (
  `course_edition_id` INT NOT NULL AUTO_INCREMENT,
  `start` DATE NOT NULL,
  `end` DATE NOT NULL,
  `cost` decimal(13,2) NOT NULL,
  `isExternal` TINYINT NOT NULL,
  `address` VARCHAR(45) DEFAULT NULL,
  `city` VARCHAR(45) DEFAULT NULL,
  `zip` VARCHAR(45) DEFAULT NULL,
  `lead_teacher_id` INT DEFAULT NULL,
  `manager_id` INT NOT NULL,
  `main_classroom_id` INT DEFAULT NULL,
  `course_id` INT NOT NULL,
  PRIMARY KEY (`course_edition_id`),
  KEY `course_edition_agent_idx` (`lead_teacher_id`),
  KEY `course_edition_agent_ manager_idx` (`manager_id`),
  KEY `course_edition_classroom_idx` (`main_classroom_id`),
  KEY `course_edition_course_idx` (`course_id`),
  CONSTRAINT `course_edition_agent_ manager` FOREIGN KEY (`manager_id`) REFERENCES `agent` (`agent_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `course_edition_agent_teacher` FOREIGN KEY (`lead_teacher_id`) REFERENCES `agent` (`agent_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `course_edition_classroom` FOREIGN KEY (`main_classroom_id`) REFERENCES `classroom` (`classroom_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `course_edition_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE RESTRICT ON UPDATE CASCADE
);



 CREATE TABLE `academia`.`client` (
  `client_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `p_iva` VARCHAR(45) NOT NULL,
  `fiscal_code` VARCHAR(45) NOT NULL,
  `addess` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(18) NOT NULL,
  `phone` VARCHAR(18) NOT NULL,
  `email` VARCHAR(32) NOT NULL,
  `manager_id` INT NULL,
  PRIMARY KEY (`client_id`),
  INDEX `client_agent_idx` (`manager_id` ASC) VISIBLE,
  CONSTRAINT `client_agent`
    FOREIGN KEY (`manager_id`)
    REFERENCES `academia`.`agent` (`agent_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);


CREATE TABLE `academia`.`student` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `DATE_of_birth` VARCHAR(45) NOT NULL,
  `sex` CHAR(1) NOT NULL,
  `degree_type` TINYINT NOT NULL,
  `degree_title` VARCHAR(45) NOT NULL,
  `is_private` TINYINT NOT NULL DEFAULT 1,
  `client_id` INT NULL,
  `email` VARCHAR(24) NULL,
  `phone` VARCHAR(24) NOT NULL,
  PRIMARY KEY (`student_id`)
);



CREATE TABLE `academia`.`enrollment` (
  `enrollment_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NOT NULL,
  `course_edition_id` INT NOT NULL,
  `enrollment_DATE` DATE NOT NULL,
  `withdrawed` TINYINT NOT NULL DEFAULT 0,
  `withdrawal_DATE` DATE NULL,
  `passed` TINYINT NULL,
  `final_score` INT NULL,
  `assessment` VARCHAR(45) NULL,
  `course_fee_paid` TINYINT NULL,
  PRIMARY KEY (`enrollment_id`),
  INDEX `enrollment_student_idx` (`student_id` ASC) VISIBLE,
  INDEX `enrollment_course_edition_idx` (`course_edition_id` ASC) VISIBLE,
  CONSTRAINT `enrollment_student`
    FOREIGN KEY (`student_id`)
    REFERENCES `academia`.`student` (`student_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `enrollment_course_edition`
    FOREIGN KEY (`course_edition_id`)
    REFERENCES `academia`.`course_edition` (`course_edition_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE);
   
   
   
  
CREATE TABLE `academia`.`lesson` (
  `lesson_id` INT NOT NULL AUTO_INCREMENT,
  `start` DATETIME NOT NULL,
  `end` DATETIME NOT NULL,
  `subject` VARCHAR(45) NULL,
  `instructor_id` INT NULL,
  `course_edition_id` INT NOT NULL,
  `classroom_id` INT NULL,
  PRIMARY KEY (`lesson_id`),
  INDEX `lesson_teacher_idx` (`instructor_id` ASC) VISIBLE,
  INDEX `lesson_classroom_idx` (`classroom_id` ASC) VISIBLE,
  INDEX `lesson_course_edition_idx` (`course_edition_id` ASC) VISIBLE,
  CONSTRAINT `lesson_instructor`
    FOREIGN KEY (`instructor_id`)
    REFERENCES `academia`.`agent` (`agent_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `lesson_classroom`
    FOREIGN KEY (`classroom_id`)
    REFERENCES `academia`.`classroom` (`classroom_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `lesson_course_edition`
    FOREIGN KEY (`course_edition_id`)
    REFERENCES `academia`.`course_edition` (`course_edition_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
    );



CREATE TABLE `academia`.`skill` (
  `skill_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(18) NOT NULL,
  `description` VARCHAR(45) DEFAULT NULL,
  `area_id` INT NOT NULL,
  PRIMARY KEY (`skill_id`),
  KEY `skill_area_idx` (`area_id`),
  CONSTRAINT `skill_area` FOREIGN KEY (`area_id`) REFERENCES `area` (`area_id`)
) ;



CREATE TABLE `academia`.`competence` (
  `competence_id` INT NOT NULL AUTO_INCREMENT,
  `agent_id` INT NOT NULL,
  `skill_id` INT NOT NULL,
  `level` TINYINT NOT NULL,
  PRIMARY KEY (`competence_id`),
  INDEX `competence_agent_idx` (`agent_id` ASC) VISIBLE,
  INDEX `competence_skill_idx` (`skill_id` ASC) VISIBLE,
  CONSTRAINT `competence_agent`
    FOREIGN KEY (`agent_id`)
    REFERENCES `academia`.`agent` (`agent_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `competence_skill`
    FOREIGN KEY (`skill_id`)
    REFERENCES `academia`.`skill` (`skill_id`)
    ON DELETE  RESTRICT
    ON UPDATE  CASCADE);



CREATE TABLE `academia`.`teaching_assignment` (
  `teaching_assignment_id` INT NOT NULL AUTO_INCREMENT,
  `agent_id` INT NOT NULL,
  `course_edition_id` INT NOT NULL,
  `hourly_rate` DECIMAL(13,2) NULL,
  `hour_number` DECIMAL(13,2) NOT NULL,
  `comments` VARCHAR(45) NULL,
  PRIMARY KEY (`teaching_assignment_id`),
  INDEX `teaching_assignment_agent_idx` (`agent_id` ASC) VISIBLE,
  INDEX `teaching_assignment_course_edition_idx` (`course_edition_id` ASC) VISIBLE,
  CONSTRAINT `teaching_assignment_agent`
    FOREIGN KEY (`agent_id`)
    REFERENCES `academia`.`agent` (`agent_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `teaching_assignment_course_edition`
    FOREIGN KEY (`course_edition_id`)
    REFERENCES `academia`.`course_edition` (`course_edition_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE);




CREATE TABLE `student_feedback` (
  `student_feedback_id` INT NOT NULL AUTO_INCREMENT,
  `teaching_assignment_id` INT DEFAULT NULL,
  `vote` TINYINT NOT NULL DEFAULT '10',
  `feedback` VARCHAR(45) DEFAULT NULL,
  `student_id` INT NOT NULL,
  PRIMARY KEY (`student_feedback_id`),
  KEY `student_feedback_teaching_assignment_idx` (`teaching_assignment_id`),
  KEY `studente_feedback_student_idx` (`student_id`),
  CONSTRAINT `student_feedback_teaching_assignment` FOREIGN KEY (`teaching_assignment_id`) REFERENCES `teaching_assignment` (`teaching_assignment_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `studente_feedback_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE RESTRICT ON UPDATE CASCADE
);



CREATE TABLE `academia`.`activity` (
  `activity_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(13) NOT NULL,
  `description` VARCHAR(45) NULL,
  `document_url` VARCHAR(33) NULL,
  `deadline` DATETIME NOT NULL,
  `is_completed` TINYINT NOT NULL DEFAULT 0,
  `completed_by_id` INT NULL,
  `completed_on` DATETIME NULL,
  `percentage_done` INT NULL DEFAULT 0,
  `course_edition_id` INT NULL,
  `project_id` INT NULL,
  PRIMARY KEY (`activity_id`),
  INDEX `activity_idx` (`completed_by_id` ASC) VISIBLE,
  INDEX `acitviy_course_edition_idx` (`course_edition_id` ASC) VISIBLE,
  INDEX `activity_project_idx` (`project_id` ASC) VISIBLE,
  CONSTRAINT `activity_agent`
    FOREIGN KEY (`completed_by_id`)
    REFERENCES `academia`.`agent` (`agent_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `acitviy_course_edition`
    FOREIGN KEY (`course_edition_id`)
    REFERENCES `academia`.`course_edition` (`course_edition_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `activity_project`
    FOREIGN KEY (`project_id`)
    REFERENCES `academia`.`project` (`project_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE);
