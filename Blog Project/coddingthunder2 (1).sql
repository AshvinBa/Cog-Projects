-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 11, 2025 at 06:47 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `coddingthunder2`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(50) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(20) NOT NULL,
  `phone_num` varchar(15) NOT NULL,
  `msg` text NOT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `phone_num`, `msg`, `date`) VALUES
(1, 'Ashvin Sudhir Bari', 'ashvinbari689@gmail.', '7896541236', 'Hi I am Ashvin and I am from Jalgaon and now I am living in Bambhori because of some college work.', '2024-11-29 12:58:45'),
(6, 'safddsfdfsvcx', 'xvb b f', '4545545445', 'duyfiiiiibgfcvbjeod8rgsp;', '2024-11-30 23:24:13'),
(10, 'Mehul Parmar', 'mehul@gmail.com', '9387541236', 'Hi I am Mehul Very Hopeless man.', '2024-12-02 20:51:18'),
(11, 'Soham Harshal Lavne', 'soham@123.com', '8669097781', 'Nano gold can look red, orange, or even blue', '2024-12-06 20:32:31'),
(12, 'Virendra', 'sgtds', '98907236598', 'Nano gold can look red, orange, or even blue', '2024-12-06 20:34:43');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` text NOT NULL,
  `slug` varchar(30) NOT NULL,
  `content` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tagline` text NOT NULL,
  `users` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `slug`, `content`, `date`, `tagline`, `users`) VALUES
(16, 'Blog With Ashvin', 'Natural beauty with Human Natu', 'One of nature’s most striking features is its vibrant palette of colors. Consider a sunrise, where the golden hues of dawn slowly banish the darkness, igniting the sky in shades of orange, pink, and red. Or think about the dense foliage of a rainforest, where a hundred shades of green merge into an intricate mosaic of life. The azure expanse of the ocean, the stark white of snow-capped mountains, and the fiery reds and yellows of autumn leaves are all testimonies to nature’s boundless creativity.', '2025-01-03 06:07:49', 'Nature is beautiful but need is to understand feelings of Nature.', 'Ashvin Bari'),
(18, 'Posting is my hobby', 'Importans of Thinking.', 'The error indicates that the connection to the MySQL server was lost during a query execution. This often happens due to network issues, server settings, or other resource-related problems. Here\'s how you can address this issue.', '2025-01-03 06:20:01', 'I want to told you that dont fear to bloag writting.', 'Ajit Dada'),
(19, 'How to cook', 'New - Blog', 'The error indicates that the connection to the MySQL server was lost during a query execution. This often happens due to network issues, server settings, or other resource-related problems. Here\'s how you can address this issue', '2025-01-03 06:20:28', 'Cooking is not easy so we try to write blog on cooking.', 'Ashvin'),
(20, 'Blog Writting is peace of cake. ', 'Importans of Thinking.', 'In today’s fast-paced world, overthinking has become a common struggle for many. It’s the art of dissecting every little detail, revisiting past decisions, and obsessing over future possibilities. While reflection and analysis are crucial for personal and professional growth, overthinking often spirals into a cycle of doubt, anxiety, and paralysis. This blog delves into the nature of overthinking, its causes, consequences, and practical ways to overcome it.', '2025-01-03 07:32:13', 'I want to told you that dont fear to bloag writting.', 'Rajeshwar Sangamnere'),
(21, 'The Role of Self-Compassion', 'The Bright Side of Reflection', 'A critical aspect of overcoming overthinking is learning to be kind to yourself. Understand that making mistakes is part of being human, and no one has everything figured out. Self-compassion fosters resilience and reduces the need for overanalyzing every move.', '2025-01-03 09:36:07', 'Seek Professional Help', 'Gayatri Bari'),
(22, 'English Speaking.', 'The Line in English is Looks l', 'Throughout history, individuals have demonstrated the power of self-discovery and growth. Consider the journey of famous innovators, leaders, and artists who overcame obstacles to achieve greatness. Their stories remind us that growth often emerges from moments of struggle.', '2025-01-04 11:57:41', 'English is a Global  Language. ', 'Shital Patil'),
(23, 'Easy Way To Learn Things.', 'Learn with Fun Activities', 'Watch English movies and shows: Start with subtitles in your language and gradually switch to English subtitles. Listen to English songs and podcasts: Sing along or note down new words. Change your device language to English: This forces you to learn everyday terms. Start with simple books: Children\'s books or beginner-level novels are great for new learners. Read news articles: Websites like BBC Learning English provide simple news stories. Use flashcards: Write new words and their meanings to expand your vocabulary.', '2025-01-04 12:27:32', 'Read Every Day', 'Vaishali Patil');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
