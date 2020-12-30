<?php

class customer {

	public function __construct($db) {
		$this->db = $db;
	}

	public function getCustomers($data = []) {
		$customers_output = [];
		$sql = "SELECT DISTINCT c.`customer_id`, c.* FROM customer c LEFT JOIN customer_info ci ON (c.customer_id = ci.customer_id)";

		$implode = [];

		if (! empty($data['firstname'])) {
			$implode[] = "c.firstname LIKE '%" . $this->db->escape($data['firstname']) . "%'";
		}

		if (! empty($data['lastname'])) {
			$implode[] = "c.lastname LIKE '%" . $this->db->escape($data['lastname']) . "%'";
		}

		
		 if (! empty($data['telephone'])) {
		 	$implode[] = "ci.telephone LIKE '%" . $this->db->escape($data['telephone']) . "%'";
		 }
		

		if ($implode) {
			$sql .= " WHERE " . implode(" AND ", $implode);
		}

		$sql .= " ORDER BY lastname, firstname";

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int) $data['start'] . "," . (int) $data['limit'];
		}

		$query = $this->db->query($sql);

		foreach ($query->rows as $customer) {
			$customer_info = $this->getCustomerInfo($customer['customer_id']);
			$customers_output[] = $customer + [
				'customer_info' => $this->getCustomerInfo($customer['customer_id'])
			];
		}

		return $customers_output;
	}

	function getCustomerInfo($customer_id = 0) {
		$query = $this->db->query("SELECT ci.telephone FROM customer_info ci WHERE ci.customer_id = " . (int) $customer_id);

		return $query->rows;
	}

	function getCustomer($customer_id = 0) {
		$query = $this->db->query("SELECT * FROM customer c WHERE c.customer_id = " . (int) $customer_id);

		return $query->row;
	}

	public function addCustomer($data) {
		$this->db->query("INSERT INTO customer SET firstname = '" . $this->db->escape(trim($data['firstname'])) . "', lastname = '" . $this->db->escape(trim($data['lastname'])) . "', email = '" . $this->db->escape(trim($data['email'])) . "', dob = '" . $this->db->escape(trim($data['dob'])) . "', date_added = NOW()");

		$customer_id = $this->db->getLastId();

		foreach ($data['customer_info']['telephone'] as $telephone) {
			$this->db->query("INSERT INTO customer_info SET customer_id = '" . (int) $customer_id . "', telephone = '" . $this->db->escape(trim($telephone)) . "'");
		}

		return $customer_id;
	}

	public function editCustomer($customer_id, $data) {
		$this->db->query("UPDATE customer SET firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', email = '" . $this->db->escape($data['email']) . "', dob = '" . $this->db->escape($data['dob']) . "' WHERE customer_id = '" . (int) $customer_id . "'");
		$this->db->query("DELETE FROM customer_info WHERE customer_id = '" . (int) $customer_id . "'");

		foreach ($data['customer_info']['telephone'] as $telephone) {
			$this->db->query("INSERT INTO customer_info SET customer_id = '" . (int) $customer_id . "', telephone = '" . $this->db->escape($telephone) . "'");
		}
	}

	public function deleteCustomer($customer_id) {
		$this->db->query("DELETE FROM customer WHERE customer_id = '" . (int) $customer_id . "'");
		$this->db->query("DELETE FROM customer_info WHERE customer_id = '" . (int) $customer_id . "'");
	}

	public function getList($searchData = []) {
		$data['customers'] = $this->getCustomers($searchData);
		$data['searchForm'] = $this->searchForm($searchData);
		return $this->render('list.tpl', $data);
	}

	public function addForm() {
		$data = [
			'firstname' => '',
			'lastname' => '',
			'email' => '',
			'dob' => '',
			'customer_info' => [
				[
					'telephone' => ''
				]
			]
		];
		$data['action'] = 'index.php?action=addCustomer';
		return $this->render('add.tpl', $data);
	}

	public function editForm($customer_id = 0) {
		$data = $this->getCustomer($customer_id);
		$data['customer_info'] = $this->getCustomerInfo($customer_id);
		$data['action'] = 'index.php?action=editCustomer&customer_id=' . (int) $customer_id;

		return $this->render('add.tpl', $data);
	}

	public function searchForm($searchData = []) {
		if (! empty($searchData)) {
			$data = [
				'firstname' => $searchData['firstname'],
				'lastname' => $searchData['lastname'],
				'telephone' => $searchData['telephone']
			];
		} else {
			$data = [
				'firstname' => '',
				'lastname' => '',
				'telephone' => ''
			];
		}

		return $this->render('search.tpl', $data);
	}

	public function render($template, $data) {
		$file = 'template/' . $template;

		if (is_file($file)) {
			extract($data);
			ob_start();
			require ($file);
			return ob_get_clean();
		}

		trigger_error('Error: Could not load template ' . $file . '!');
		exit();
	}
}