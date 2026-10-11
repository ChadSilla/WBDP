<?php
require_once __DIR__ . '/PHP/classes/Database.php';
use App\Classes\Database;

$db = Database::getInstance();
$pdo = $db->getConnection();

$firstNames = ['John', 'Jane', 'Michael', 'Emily', 'Chris', 'Sarah', 'David', 'Laura', 'Robert', 'Emma', 'William', 'Olivia', 'James', 'Ava', 'Charles', 'Sophia', 'Joseph', 'Isabella', 'Thomas', 'Mia'];
$lastNames = ['Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Garcia', 'Miller', 'Davis', 'Rodriguez', 'Martinez', 'Hernandez', 'Lopez', 'Gonzalez', 'Wilson', 'Anderson', 'Thomas', 'Taylor', 'Moore', 'Jackson', 'Martin'];
$barangays = [
    'Burol Main', 'Burol I', 'Burol II', 'Burol III', 
    'Salitran I', 'Salitran II', 'Salitran III', 'Salitran IV', 
    'San Jose', 'Paliparan I', 'Paliparan II', 'Paliparan III', 
    'Area A', 'Area B', 'Area C', 'Area D', 
    'Sampaloc I', 'Sampaloc II', 'Sampaloc III', 'Sampaloc IV', 
    'Sabang', 'Langkaan I', 'Langkaan II', 'Salawag', 
    'Datu Esmael', 'Victoria Reyes', 'San Nicolas I', 'San Nicolas II'
];
$civilStatuses = ['Single', 'Married', 'Widowed', 'Legally Separated', 'Annulled'];
$userTypes = ['PWD', 'Senior Citizen', 'Solo Parent', 'Student', 'Regular'];

$sqlStatements = [];
$sqlStatements[] = "INSERT INTO users (member_id, first_name, last_name, middle_name, date_of_birth, sex, civil_status, contact_number, email, password, role, house_street, barangay, user_type) VALUES";

$values = [];
$params = [];
$hashedPassword = password_hash('password123', PASSWORD_DEFAULT);

$insertData = [];

for ($i = 1; $i <= 100; $i++) {
    $fn = $firstNames[array_rand($firstNames)];
    $ln = $lastNames[array_rand($lastNames)];
    $mn = $lastNames[array_rand($lastNames)];
    $sex = (rand(0, 1) == 0) ? 'Male' : 'Female';
    $dob = date('Y-m-d', strtotime('-' . rand(18, 65) . ' years -' . rand(1, 365) . ' days'));
    $civilStatus = $civilStatuses[array_rand($civilStatuses)];
    $contactNumber = '09' . str_pad(rand(100000000, 999999999), 9, '0', STR_PAD_LEFT) . $i; // Ensure unique by appending $i, though we'll truncate to 15
    $contactNumber = substr($contactNumber, 0, 11);
    // ensure absolute uniqueness of contact
    $contactNumber = '09' . str_pad($i, 9, '0', STR_PAD_LEFT); 
    
    $email = strtolower($fn . '.' . $ln . $i . '@example.com');
    $barangay = $barangays[array_rand($barangays)];
    $street = rand(1, 999) . ' ' . $lastNames[array_rand($lastNames)] . ' St.';
    $userType = $userTypes[array_rand($userTypes)];
    $memberId = 'BIDA-' . date('Y') . '-' . str_pad($i + 1000, 4, '0', STR_PAD_LEFT);

    $insertData[] = [
        'member_id' => $memberId,
        'first_name' => $fn,
        'last_name' => $ln,
        'middle_name' => $mn,
        'date_of_birth' => $dob,
        'sex' => $sex,
        'civil_status' => $civilStatus,
        'contact_number' => $contactNumber,
        'email' => $email,
        'password' => $hashedPassword,
        'role' => 'user',
        'house_street' => $street,
        'barangay' => $barangay,
        'user_type' => $userType
    ];

    $sqlLine = "('" . $memberId . "', '" . addslashes($fn) . "', '" . addslashes($ln) . "', '" . addslashes($mn) . "', '" . $dob . "', '" . $sex . "', '" . $civilStatus . "', '" . $contactNumber . "', '" . addslashes($email) . "', '" . $hashedPassword . "', 'user', '" . addslashes($street) . "', '" . addslashes($barangay) . "', '" . addslashes($userType) . "')";
    
    $sqlStatements[] = $sqlLine . ($i == 100 ? ";" : ",");
}

$sqlContent = implode("\n", $sqlStatements) . "\n";
file_put_contents(__DIR__ . '/dummy_users.sql', $sqlContent);

// Insert into database
$pdo->beginTransaction();
try {
    $stmt = $pdo->prepare("INSERT INTO users (member_id, first_name, last_name, middle_name, date_of_birth, sex, civil_status, contact_number, email, password, role, house_street, barangay, user_type) VALUES (:member_id, :first_name, :last_name, :middle_name, :date_of_birth, :sex, :civil_status, :contact_number, :email, :password, :role, :house_street, :barangay, :user_type)");
    foreach ($insertData as $data) {
        $stmt->execute($data);
    }
    $pdo->commit();
    echo "Successfully generated dummy_users.sql and inserted 100 records into the database.\n";
} catch (Exception $e) {
    $pdo->rollBack();
    echo "Error inserting into database: " . $e->getMessage() . "\n";
}
?>
