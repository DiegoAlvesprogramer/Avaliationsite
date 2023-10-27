<?php
require_once("globals.php");
require_once("db.php");
require_once("models/Movie.php");
require_once("models/Message.php");
require_once("dao/UserDAO.php");
require_once("dao/MovieDAO.php");

$message = new Message($BASE_URL);
$userDao = new UserDAO($conn, $BASE_URL);
$movieDao = new MovieDAO($conn, $BASE_URL);

// Resgata o tipo do formulário com uma verificação de segurança adicional.
$type = filter_input(INPUT_POST, "type", FILTER_SANITIZE_STRING);

// Resgata dados do usuário com verificação de segurança.
$userData = $userDao->verifyToken();

if ($type === "create") {
    // Receber os dados dos inputs com verificação de segurança.
    $title = filter_input(INPUT_POST, "title", FILTER_SANITIZE_STRING);
    $description = filter_input(INPUT_POST, "description", FILTER_SANITIZE_STRING);
    $trailer = filter_input(INPUT_POST, "trailer", FILTER_SANITIZE_STRING);
    $category = filter_input(INPUT_POST, "category", FILTER_SANITIZE_STRING);
    $length = filter_input(INPUT_POST, "length", FILTER_VALIDATE_INT);

    $movie = new Movie();

    // Validação mínima de dados com comprimento máximo.
    if (!empty($title) && !empty($description) && !empty($category) && strlen($title) <= 255 && strlen($description) <= 1000) {
        $movie->title = $title;
        $movie->description = $description;
        $movie->trailer = $trailer;
        $movie->category = $category;
        $movie->length = $length;
        $movie->users_id = $userData->id;

        // Upload de imagem do filme
        if (isset($_FILES["image"]) && !empty($_FILES["image"]["tmp_name"])) {
            $image = $_FILES["image"];
            $imageTypes = ["image/jpeg", "image/jpg", "image/png"];
            $jpgArray = ["image/jpeg", "image/jpg"];

            // Verifica se o tipo da imagem é válido.
            if (in_array($image["type"], $imageTypes)) {
                // Verifica se a extensão do arquivo é jpg.
                if (in_array($image["type"], $jpgArray)) {
                    $imageFile = imagecreatefromjpeg($image["tmp_name"]);
                } else {
                    $imageFile = imagecreatefrompng($image["tmp_name"]);
                }

                // Gere um nome de imagem único.
                $imageName = uniqid() . ".jpg";

                // Verifica se a pasta de destino existe e a cria se necessário.
                $uploadPath = "./img/movies/";
                if (!is_dir($uploadPath)) {
                    mkdir($uploadPath, 0755, true);
                }

                // Salve a imagem com o nome gerado.
                imagejpeg($imageFile, $uploadPath . $imageName, 100);

                $movie->image = $imageName;
            } else {
                $message->setMessage("Tipo inválido de imagem, insira png ou jpg!", "error", "back");
            }
        }

        $movieDao->create($movie);
    } else {
        $message->setMessage("Dados inválidos. Certifique-se de que o título, descrição e categoria sejam preenchidos corretamente.", "error", "back");
    }
} elseif ($type === "delete") {
    // Recebe os dados do formulário com verificação de segurança.
    $id = filter_input(INPUT_POST, "id", FILTER_VALIDATE_INT);

    $movie = $movieDao->findById($id);

    if ($movie) {
        // Verificar se o filme pertence ao usuário.
        if ($movie->users_id === $userData->id) {
            $movieDao->destroy($movie->id);
        } else {
            $message->setMessage("Informações inválidas!", "error", "index.php");
        }
    } else {
        $message->setMessage("Informações inválidas!", "error", "index.php");
    }
} elseif ($type === "update") {
    // Receber os dados dos inputs com verificação de segurança.
    $title = filter_input(INPUT_POST, "title", FILTER_SANITIZE_STRING);
    $description = filter_input(INPUT_POST, "description", FILTER_SANITIZE_STRING);
    $trailer = filter_input(INPUT_POST, "trailer", FILTER_SANITIZE_STRING);
    $category = filter_input(INPUT_POST, "category", FILTER_SANITIZE_STRING);
    $length = filter_input(INPUT_POST, "length", FILTER_VALIDATE_INT);
    $id = filter_input(INPUT_POST, "id", FILTER_VALIDATE_INT);

    $movieData = $movieDao->findById($id);

    if ($movieData) {
        // Verificar se o filme pertence ao usuário.
        if ($movieData->users_id === $userData->id) {
            // Validação mínima de dados com comprimento máximo.
            if (!empty($title) && !empty($description) && !empty($category) && strlen($title) <= 255 && strlen($description) <= 1000) {
                // Edição do filme.
                $movieData->title = $title;
                $movieData->description = $description;
                $movieData->trailer = $trailer;
                $movieData->category = $category;
                $movieData->length = $length;

                // Upload de imagem do filme
                if (isset($_FILES["image"]) && !empty($_FILES["image"]["tmp_name"])) {
                    $image = $_FILES["image"];
                    $imageTypes = ["image/jpeg", "image/jpg", "image/png"];
                    $jpgArray = ["image/jpeg", "image/jpg"];

                    // Verifica se o tipo da imagem é válido.
                    if (in_array($image["type"], $imageTypes)) {
                        // Verifica se a extensão do arquivo é jpg.
                        if (in_array($image["type"], $jpgArray)) {
                            $imageFile = imagecreatefromjpeg($image["tmp_name"]);
                        } else {
                            $imageFile = imagecreatefrompng($image["tmp_name"]);
                        }

                        // Gere um nome de imagem único.
                        $imageName = uniqid() . ".jpg";

                        // Verifica se a pasta de destino existe e a cria se necessário.
                        $uploadPath = "./img/movies/";
                        if (!is_dir($uploadPath)) {
                            mkdir($uploadPath, 0755, true);
                        }

                        // Salve a imagem com o nome gerado.
                        imagejpeg($imageFile, $uploadPath . $imageName, 100);

                        $movieData->image = $imageName;
                    } else {
                        $message->setMessage("Tipo inválido de imagem, insira png ou jpg!", "error", "back");
                    }
                }

                $movieDao->update($movieData);
            } else {
                $message->setMessage("Dados inválidos. Certifique-se de que o título, descrição e categoria sejam preenchidos corretamente.", "error", "back");
            }
        } else {
            $message->setMessage("Informações inválidas!", "error", "index.php");
        }
    } else {
        $message->setMessage("Informações inválidas!", "error", "index.php");
    }
} else {
    $message->setMessage("Informações inválidas!", "error", "index.php");
}
