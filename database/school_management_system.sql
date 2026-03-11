-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 11, 2026 at 06:55 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `school_management_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `student_name` varchar(100) NOT NULL,
  `age` int(11) NOT NULL CHECK (`age` between 13 and 18),
  `class` int(11) NOT NULL CHECK (`class` in (9,10)),
  `section` char(1) NOT NULL CHECK (`section` in ('A','B','C','D'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `student_name`, `age`, `class`, `section`) VALUES
(1, 'Arjun', 14, 9, 'A'),
(2, 'Sneha', 15, 9, 'A'),
(3, 'Rahul', 14, 9, 'B'),
(4, 'Divya', 15, 9, 'B'),
(5, 'Kiran', 14, 9, 'C'),
(6, 'Pooja', 15, 9, 'C'),
(7, 'Manoj', 14, 9, 'D'),
(8, 'Ananya', 15, 9, 'D'),
(9, 'Vikram', 14, 9, 'A'),
(10, 'Keerthi', 15, 9, 'B'),
(11, 'Rohit', 16, 10, 'A'),
(12, 'Priya', 16, 10, 'A'),
(13, 'Varun', 17, 10, 'B'),
(14, 'Neha', 16, 10, 'B'),
(15, 'Aditya', 17, 10, 'C'),
(16, 'Swathi', 16, 10, 'C'),
(17, 'Sandeep', 17, 10, 'D'),
(18, 'Megha', 16, 10, 'D'),
(19, 'Harsha', 17, 10, 'A'),
(20, 'Nisha', 16, 10, 'B');

-- --------------------------------------------------------

--
-- Table structure for table `student_marks`
--

CREATE TABLE `student_marks` (
  `student_id` int(11) NOT NULL,
  `telugu` int(11) DEFAULT NULL CHECK (`telugu` between 0 and 100),
  `hindi` int(11) DEFAULT NULL CHECK (`hindi` between 0 and 100),
  `english` int(11) DEFAULT NULL CHECK (`english` between 0 and 100),
  `math` int(11) DEFAULT NULL CHECK (`math` between 0 and 100),
  `science` int(11) DEFAULT NULL CHECK (`science` between 0 and 100),
  `total_marks` int(11) GENERATED ALWAYS AS (`telugu` + `hindi` + `english` + `math` + `science`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_marks`
--

INSERT INTO `student_marks` (`student_id`, `telugu`, `hindi`, `english`, `math`, `science`) VALUES
(1, 78, 70, 82, 90, 85),
(2, 85, 74, 88, 79, 81),
(3, 69, 72, 75, 80, 77),
(4, 90, 85, 84, 88, 92),
(5, 76, 68, 70, 72, 74),
(6, 82, 80, 86, 84, 88),
(7, 60, 65, 70, 68, 66),
(8, 88, 86, 90, 92, 91),
(9, 75, 73, 78, 80, 79),
(10, 81, 79, 85, 83, 80),
(11, 70, 72, 74, 76, 78),
(12, 92, 90, 94, 96, 95),
(13, 68, 66, 70, 72, 74),
(14, 85, 82, 80, 88, 87),
(15, 77, 75, 79, 81, 80),
(16, 83, 84, 82, 86, 85),
(17, 66, 69, 72, 70, 71),
(18, 90, 92, 91, 93, 94),
(19, 74, 76, 78, 80, 82),
(20, 88, 86, 87, 89, 90);

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `teacher_id` int(11) NOT NULL,
  `teacher_name` varchar(100) NOT NULL,
  `subject` varchar(50) NOT NULL,
  `class` int(11) NOT NULL CHECK (`class` in (9,10)),
  `section` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`teacher_id`, `teacher_name`, `subject`, `class`, `section`) VALUES
(1, 'Ravi Kumar', 'Math', 9, 'A'),
(2, 'Sita Devi', 'Science', 9, 'B'),
(3, 'Anil Sharma', 'English', 9, 'C'),
(4, 'Lakshmi Rao', 'Telugu', 9, 'D'),
(5, 'Prakash Reddy', 'Math', 10, 'A'),
(6, 'Meena Nair', 'Science', 10, 'B'),
(7, 'Joseph Mathew', 'English', 10, 'C'),
(8, 'Kavitha Iyer', 'Hindi', 10, 'D'),
(9, 'Sunil Gupta', 'Hindi', 9, ''),
(10, 'Asha Menon', 'Science', 10, '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `student_marks`
--
ALTER TABLE `student_marks`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`teacher_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `teachers`
--
ALTER TABLE `teachers`
  MODIFY `teacher_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `student_marks`
--
ALTER TABLE `student_marks`
  ADD CONSTRAINT `student_marks_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
