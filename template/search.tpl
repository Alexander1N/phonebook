		<form action="index.php?action=search" method="POST">
			<div class="form-row">
				<div class="form-group col-md-3">
					<input type="text" class="form-control" id="firstname" name="firstname" value="<?php echo $firstname; ?>" placeholder="Имя">
				</div>
				<div class="form-group col-md-3">
					<input type="text" class="form-control" id="lastname" name="lastname" value="<?php echo $lastname; ?>" placeholder="Фамилия">
				</div>
				<div class="form-group col-md-3">
					<input type="text" class="form-control" id="telephone" name="telephone" value="<?php echo $telephone; ?>" placeholder="Телефон">
				</div>
				<div class="form-group col-md-3">
					<button type="submit" class="btn btn-primary">Найти</button>
					<a href="index.php"><button type="button" class="btn btn-primary">Сбросить</button></a>
				</div>
			</div>
		</form>