<?php
spl_autoload_register(function ($class_name) {
	include 'class/' . $class_name . '.php';
});

$db = new DB('localhost', 'root', '', 'book');
$customer = new customer($db);
$action = (isset($_GET['action']) ? $_GET['action'] : '');

switch ($action) {
	case 'deleteCustomer':
		echo $customer->deleteCustomer($_GET['customer_id']);
		header('Location: index.php');
		break;
	case 'editForm':
		echo $customer->editForm($_GET['customer_id']);
		break;
	case 'editCustomer':
		echo $customer->editCustomer($_GET['customer_id'], $_POST);
		header('Location: index.php');
		break;
	case 'addForm':
		echo $customer->addForm();
		break;
	case 'addCustomer':
		echo $customer->addCustomer($_POST);
		header('Location: index.php');
		break;
	case 'search':
		echo $customer->getList($_POST);
		break;
	default:
		echo $customer->getList();
}
 