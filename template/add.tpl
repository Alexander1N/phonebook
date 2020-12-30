<!DOCTYPE HTML>
<html lang="ru">
<head>
<meta charset="UTF-8">
<title>Телефонная книга</title>
<meta name="description" content="Телефонная книга" />
<link rel="icon" href="favicon.png">
<link href="https://getbootstrap.com/docs/4.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<div class="container-fluid">
		<a href="index.php"><h1><i class="fa fa-phone"></i> Телефонная книга</h1></a>
		<h2>Добавление записи</h2>

		<form action="<?php echo $action; ?>" method="POST">
			<div class="form-row">
				<div class="form-group col-md-6">
					<label for="firstname">Имя</label>
					<input type="text" class="form-control" id="firstname" name="firstname" value="<?php echo $firstname; ?>" placeholder="Имя" required>
				</div>
				<div class="form-group col-md-6">
					<label for="lastname">Фамилия</label>
					<input type="text" class="form-control" id="lastname" name="lastname" value="<?php echo $lastname; ?>" placeholder="Фамилия">
				</div>
			</div>

			<div class="form-row">
				<div class="form-group col-md-6">
					<label for="email">Email</label>
					<input type="email" class="form-control" id="email" name="email" placeholder="name@example.com">
				</div>
				<div class="form-group col-md-6">
					<label for="dob">Дата рождения</label>
					<input type="text" class="form-control" id="dob" name="dob" value="<?php echo $dob; ?>" placeholder="Дата рождения" readonly required>
				</div>
			</div>

			<div class="form-row">
				<div class="form-group col-md-12">
					<div>Телефоны</div>
					<div class="telephone-row">
						<?php foreach ($customer_info as $info) { ?>
							<div class="row telephone">
								<div class="col-md-6"><input type="tel" class="form-control" name="customer_info[telephone][]" value="<?php echo $info['telephone']; ?>" placeholder="Телефон" pattern="(\+38)?\d{10}" required></div>
								<div class="col-md-1"><button type="button" class="btn btn-danger btn-sm delTel"><i class="fa fa-minus-circle"></i></button>&nbsp;<button type="button" class="btn btn-primary btn-sm addTel"><i class="fa fa-plus-circle"></i></button></div>
							</div>
						<?php } ?>
					</div>
				</div>
			</div>

		<button type="submit" class="btn btn-primary">Сохранить</button>
		</form>
	</div>
</body>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css">
<style>
#dob {
	background-color: transparent;
}
</style>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
$(function() {
	$("#dob").datepicker({
		dateFormat: "yy-mm-dd",
		maxDate: '-18y'
	});
});

$(function() {
	$(".telephone-row").on("click", ".addTel", function(){
		var html = '<div class="row telephone">';
		html += '<div class="col-md-6"><input type="tel" class="form-control" name="customer_info[telephone][]" value="" placeholder="Телефон" pattern="(\+38)?\d{10}" required></div>';
		html += '<div class="col-md-1"><button type="button" class="btn btn-danger btn-sm delTel"><i class="fa fa-minus-circle"></i></button>&nbsp;<button type="button" class="btn btn-primary btn-sm addTel"><i class="fa fa-plus-circle"></i></button></div>';
		html += '</div>';
		$(this).closest(".telephone").after(html);
	});
	$(".telephone-row").on("click", ".delTel", function(){
		if ($(".telephone").length == 1) {
			alert('Один телефон нужно оставить');
		} else {
			$(this).closest(".telephone").remove();
		}
	});
});
</script>
</html>