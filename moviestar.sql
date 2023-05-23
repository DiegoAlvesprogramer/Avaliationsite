-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 26-Out-2022 às 22:16
-- Versão do servidor: 10.4.24-MariaDB
-- versão do PHP: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `moviestar`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `movies`
--

CREATE TABLE `movies` (
  `id` int(11) UNSIGNED NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(200) DEFAULT NULL,
  `trailer` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `length` varchar(50) DEFAULT NULL,
  `users_id` int(11) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `movies`
--

INSERT INTO `movies` (`id`, `title`, `description`, `image`, `trailer`, `category`, `length`, `users_id`) VALUES
(1, 'HÉCULES', 'Depois de completar 12 árduos trabalhos e perder sua família, o semideus Hércules conhece seis assassinos impiedosos e une-se ao grupo em busca de trabalho, até que o rei da Trácia o convida para treinar o seu exército.', '032bc24f22d4710c50d9f02a14e005b39646c22a71bac855646edf09974773282e9e7c7d4d34becb54e77e3e8c6bb5a09ed0499a71f4bccea411eeef.jpg', 'https://www.youtube.com/watch?v=Py5_SVwSe8w', 'Ação', '1h e 38min', 1),
(2, 'Tropa de Elite', 'Nascimento, capitão da Tropa de Elite do Rio de Janeiro, é designado para chefiar uma das equipes que tem como missão apaziguar o Morro do Turano. Ele precisa cumprir as ordens enquanto procura por um substituto para ficar em seu lugar. Em meio a um tiroteio, Nascimento e sua equipe resgatam Neto e Matias, dois aspirantes a oficiais da PM. Ansiosos para entrar em ação e impressionados com a eficiência de seus salvadores, os dois se candidatam ao curso de formação da Tropa de Elite.', 'a17a8270c81d47ec3b230f8c22db3d38eccd67648ebfec8190375d82faed3891bd0d291ad08c5fb632f8e235e94cb94c2a78bbb734b978c0428006ae.jpg', 'https://www.youtube.com/watch?v=uZBiNJQxtGw', 'Ação', '1h 55m', 1),
(3, 'Gente Grande 2', 'Lenny Feder e sua família se mudam para sua cidade natal para ficar perto dos amigos, mas acabam tendo que enfrentar alguns fantasmas do passado, como a covardia diante de valentões e o famigerado bullying na escola.', '4c02c47632ff7e37947ff1383b4bda8ce89950ee71b5b878d54cd7182a9ece313132bd79d9c34a8a161f8b67d18a28dd0e5fc977828f8fb0d41ecb6b.jpg', 'https://www.youtube.com/watch?v=HKVve_VSz58', 'Comédia', '1h 41m', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) UNSIGNED NOT NULL,
  `rating` int(11) DEFAULT NULL,
  `review` text DEFAULT NULL,
  `users_id` int(11) UNSIGNED DEFAULT NULL,
  `movies_id` int(11) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `reviews`
--

INSERT INTO `reviews` (`id`, `rating`, `review`, `users_id`, `movies_id`) VALUES
(1, 10, 'Filme muito bom', 2, 2),
(2, 10, 'Muito bom', 3, 3);

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

CREATE TABLE `users` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `image` varchar(200) DEFAULT NULL,
  `token` varchar(200) DEFAULT NULL,
  `bio` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` (`id`, `name`, `lastname`, `email`, `password`, `image`, `token`, `bio`) VALUES
(1, 'LEORNARDO', 'NASCIMENTO', 'leonardo08alves@gmail.com', '$2y$10$pv6N08/uqWLW4d.MR1kO9./bZzDbAYVIdQ0gZcWP3ATBV1051Igf2', NULL, '7f7e3a81c66a45f4fffef0c01bfbcfa17f4bdd18658ed5788115f724a20e7e5f254ed9a6d0a27e516a44e5e1e9cd5871efd6', NULL),
(2, 'jorge', 'NASCIMENTO', 'leonardo8alves@gmail.com', '$2y$10$MieP3pPBpsAaEGNwCCWQgucAkhhyv33ESXWOtVee8KZhjJTo6sjZa', NULL, '8a5058b413a342c8af1e8848fb92c25ad19af7a055d59fa37f3b8cf01be10af351959b36507505b72e8a7e971ae6b60a81bb', NULL),
(3, 'leonardo', 'nascimento', 'leonardo010alves@gmail.com', '$2y$10$wkaIr/3h1zK2DSnwrd/i5.XYEpAdWEUEfYgmTQ0r8Axnd/9sE//Fi', NULL, 'fc5b4e287741f528590bdacc9886a2d1685080129533cae5590e7ebd9feaeb449e35466b298fab6802dc6a517ae87a20a6fe', NULL);

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `movies`
--
ALTER TABLE `movies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_id` (`users_id`);

--
-- Índices para tabela `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_id` (`users_id`),
  ADD KEY `movies_id` (`movies_id`);

--
-- Índices para tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `movies`
--
ALTER TABLE `movies`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `movies`
--
ALTER TABLE `movies`
  ADD CONSTRAINT `movies_ibfk_1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`);

--
-- Limitadores para a tabela `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`movies_id`) REFERENCES `movies` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
