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
		<div class="row">
			<div class="col-sm-3">
				<a href="index.php"><h1><i class="fa fa-phone"></i> Телефонная книга</h1></a>
			</div>
			<div class="col-sm">
				<a href="index.php?action=addForm" title="Добавить телефон"><button type="button" class="btn btn-secondary" data-toggle="tooltip" data-placement="bottom" title="Добавить телефон"><i class="fa fa-plus"></i></button></a>
			</div>
		</div>

		<?php echo $searchForm; ?>

		<div class="table-responsive">
			<table class="table table-hover">
				<thead>
					<tr>
						<th>Имя</th>
						<th>Фамилия</th>
						<th>Телефон</th>
						<th>email</th>
						<th>Дата рождения</th>
						<th>&nbsp;</th>
					</tr>
				</thead>
				<tbody>
					<?php foreach ($customers as $customer) { ?>
						<tr>
							<td><?php echo $customer['firstname']; ?></td>
							<td><?php echo $customer['lastname']; ?></td>
							<td><?php 
								foreach ($customer['customer_info'] as $customer_info) {
									echo '<div>' . $customer_info['telephone'] . '</div>';
								} ?>
							</td>
							<td><?php echo $customer['email']; ?></td>
							<td><?php echo $customer['dob']; ?></td>
							<td>
								<a href="index.php?action=editForm&customer_id=<?php echo $customer['customer_id']; ?>"><button type="button" class="btn btn-secondary" data-toggle="tooltip" title="Редактировать"><i class="fa fa-edit"></i></button></a>
								<a href="index.php?action=deleteCustomer&customer_id=<?php echo $customer['customer_id']; ?>"><button type="button" class="btn btn-secondary" data-toggle="tooltip" data-placement="top" title="Удалить"><i class="fa fa-trash"></i></button></a>
							</td>
						</tr>
					<?php } ?>
				</tbody>
			</table>
		</div>
	</div>
</body>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
$(function () {
	$('[data-toggle="tooltip"]').tooltip();
});
</script>
</html>