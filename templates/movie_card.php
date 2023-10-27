<?php
  // Verifica se a propriedade $movie->image está vazia (não definida ou nula).
  if (empty($movie->image)) {
    // Caso esteja vazia, define uma imagem padrão para $movie->image.
    $movie->image = "movie_cover.jpg";
  }
?>

<div class="card movie-card">
  <!-- Define o estilo de fundo da div com a imagem do filme, usando $BASE_URL para construir o caminho. -->
  <div class="card-img-top" style="background-image: url('<?= $BASE_URL ?>img/movies/<?= $movie->image ?>')"></div>
  <div class="card-body">
    <p class="card-rating">
      <i class="fas fa-star"></i>
      <!-- Exibe a classificação do filme a partir da propriedade $movie->rating. -->
      <span class="rating"><?= $movie->rating ?></span>
    </p>
    <h5 class="card-title">
      <a href="<?= $BASE_URL ?>movie.php?id=<?= $movie->id ?>">
        <!-- Exibe o título do filme como um link para a página do filme. -->
        <?= $movie->title ?>
      </a>
    </h5>
    <a href="<?= $BASE_URL ?>movie.php?id=<?= $movie->id ?>" class="btn btn-primary rate-btn">Avaliar</a>
    <a href="<?= $BASE_URL ?>movie.php?id=<?= $movie->id ?>" class="btn btn-primary card-btn">Conhecer</a>
  </div>
</div>
