CREATE TABLE `academia`.`agent` (
  `id` INT NOT NULL AUTO_INCREMENT,
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
  PRIMARY KEY (`id`));

  CREATE TABLE `academia`.`classroom` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(18) NOT NULL,
  `capacity` INT NOT NULL DEFAULT 20,
  `computerized` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`));

  CREATE TABLE `academia`.`project` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `start` DATE NOT NULL,
  `end` DATE NULL,
  `budget` DECIMAL(13,2) NOT NULL,
  `isFinanced` TINYINT NOT NULL DEFAULT 0,
  `managerId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `project_agent_idx` (`managerId` ASC) VISIBLE,
  CONSTRAINT `project_agent`
    FOREIGN KEY (`managerId`)
    REFERENCES `academia`.`agent` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE);


CREATE TABLE `academia`.`area` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(18) NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));


 CREATE TABLE `course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(25) NOT NULL,
  `decription` varchar(100) NOT NULL,
  `syllabus` varchar(120) DEFAULT NULL,
  `area_id` int(11) NOT NULL,
  `numHours` int(11) NOT NULL,
  `level` tinyint(4) DEFAULT NULL,
  `cost` decimal(13,2) NOT NULL,
  `project_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_area_idx` (`area_id`),
  KEY `course_project_idx` (`project_id`),
  CONSTRAINT `course_area` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `course_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`)
 );


CREATE TABLE `course_edition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start` date NOT NULL,
  `end` date NOT NULL,
  `cost` decimal(13,2) NOT NULL,
  `isExternal` tinyint(4) NOT NULL,
  `address` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `zip` varchar(45) DEFAULT NULL,
  `lead_teacher_id` int(11) DEFAULT NULL,
  `manager_id` int(11) NOT NULL,
  `main_classroom_id` int(11) DEFAULT NULL,
  `course_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_edition_agent_idx` (`lead_teacher_id`),
  KEY `course_edition_agent_ manager_idx` (`manager_id`),
  KEY `course_edition_classroom_idx` (`main_classroom_id`),
  KEY `course_edition_course_idx` (`course_id`),
  CONSTRAINT `course_edition_agent_ manager` FOREIGN KEY (`manager_id`) REFERENCES `agent` (`id`),
  CONSTRAINT `course_edition_agent_teacher` FOREIGN KEY (`lead_teacher_id`) REFERENCES `agent` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `course_edition_classroom` FOREIGN KEY (`main_classroom_id`) REFERENCES `classroom` (`id`),
  CONSTRAINT `course_edition_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`)
);


 CREATE TABLE `academia`.`client` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `p_iva` VARCHAR(45) NOT NULL,
  `fiscal_code` VARCHAR(45) NOT NULL,
  `addess` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(18) NOT NULL,
  `phone` VARCHAR(18) NOT NULL,
  `email` VARCHAR(32) NOT NULL,
  `manager_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `client_agent_idx` (`manager_id` ASC) VISIBLE,
  CONSTRAINT `client_agent`
    FOREIGN KEY (`manager_id`)
    REFERENCES `academia`.`agent` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE);


CREATE TABLE `academia`.`student` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `date_of_birth` VARCHAR(45) NOT NULL,
  `sex` CHAR(1) NOT NULL,
  `degree_type` TINYINT NOT NULL,
  `degree_title` VARCHAR(45) NOT NULL,
  `is_private` TINYINT NOT NULL DEFAULT 1,
  `client_id` INT NULL,
  `email` VARCHAR(24) NULL,
  `phone` VARCHAR(24) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `student_client_idx` (`client_id` ASC) VISIBLE,
  CONSTRAINT `student_client`
    FOREIGN KEY (`client_id`)
    REFERENCES `academia`.`client` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE);


CREATE TABLE `academia`.`enrollment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NOT NULL,
  `course_editon_id` INT NOT NULL,
  `enrollment_date` DATE NOT NULL,
  `withdrawed` TINYINT NOT NULL DEFAULT 0,
  `withdrawal_date` DATE NULL,
  `passed` TINYINT NULL,
  `final_score` INT NULL,
  `assessment` VARCHAR(45) NULL,
  `course_fee_paid` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `enrollment_student_idx` (`student_id` ASC) VISIBLE,
  INDEX `enrollment_course_edition_idx` (`course_editon_id` ASC) VISIBLE,
  CONSTRAINT `enrollment_student`
    FOREIGN KEY (`student_id`)
    REFERENCES `academia`.`student` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `enrollment_course_edition`
    FOREIGN KEY (`course_editon_id`)
    REFERENCES `academia`.`course_edition` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE);
       
CREATE TABLE `academia`.`lesson` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `start` DATETIME NOT NULL,
  `end` DATETIME NOT NULL,
  `subject` VARCHAR(45) NULL,
  `instructor_id` INT NULL,
  `course_edition_id` INT NOT NULL,
  `classroom_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `lesson_teacher_idx` (`instructor_id` ASC) VISIBLE,
  INDEX `lesson_classroom_idx` (`classroom_id` ASC) VISIBLE,
  INDEX `lesson_course_edition_idx` (`course_edition_id` ASC) VISIBLE,
  CONSTRAINT `lesson_instructor`
    FOREIGN KEY (`instructor_id`)
    REFERENCES `academia`.`agent` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `lesson_classroom`
    FOREIGN KEY (`classroom_id`)
    REFERENCES `academia`.`classroom` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `lesson_course_edition`
    FOREIGN KEY (`course_edition_id`)
    REFERENCES `academia`.`course_edition` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
    );

CREATE TABLE `academia`.`skill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(18) NOT NULL,
  `description` varchar(45) DEFAULT NULL,
  `area_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `skill_area_idx` (`area_id`),
  CONSTRAINT `skill_area` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`)
) ;


CREATE TABLE `academia`.`competence` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `agent_id` INT NOT NULL,
  `skill_id` INT NOT NULL,
  `level` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `competence_agent_idx` (`agent_id` ASC) VISIBLE,
  INDEX `competence_skill_idx` (`skill_id` ASC) VISIBLE,
  CONSTRAINT `competence_agent`
    FOREIGN KEY (`agent_id`)
    REFERENCES `academia`.`agent` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `competence_skill`
    FOREIGN KEY (`skill_id`)
    REFERENCES `academia`.`skill` (`id`)
    ON DELETE  RESTRICT
    ON UPDATE  CASCADE);

    CREATE TABLE `academia`.`teaching_assignment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `agent_id` INT NOT NULL,
  `course_edition_id` INT NOT NULL,
  `hourly_rate` DECIMAL(13,2) NULL,
  `hour_number` DECIMAL(13,2) NOT NULL,
  `comments` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `teaching_assignment_agent_idx` (`agent_id` ASC) VISIBLE,
  INDEX `teaching_assignment_course_edition_idx` (`course_edition_id` ASC) VISIBLE,
  CONSTRAINT `teaching_assignment_agent`
    FOREIGN KEY (`agent_id`)
    REFERENCES `academia`.`agent` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `teaching_assignment_course_edition`
    FOREIGN KEY (`course_edition_id`)
    REFERENCES `academia`.`course_edition` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE);

CREATE TABLE `student_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `teaching_assignment_id` int(11) DEFAULT NULL,
  `vote` tinyint(4) NOT NULL DEFAULT '10',
  `feedback` varchar(45) DEFAULT NULL,
  `student_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `student_feedback_teaching_assignment_idx` (`teaching_assignment_id`),
  KEY `studente_feedback_student_idx` (`student_id`),
  CONSTRAINT `student_feedback_teaching_assignment` FOREIGN KEY (`teaching_assignment_id`) REFERENCES `teaching_assignment` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `studente_feedback_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`)
);

