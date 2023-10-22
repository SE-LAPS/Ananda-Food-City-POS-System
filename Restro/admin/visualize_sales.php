<?php
// Database connection code
$dbuser = "root";
$dbpass = "";
$host = "localhost";
$db = "rposystem";
$mysqli = new mysqli($host, $dbuser, $dbpass, $db);

if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}

// Perform a SQL query to get sales data
$sql = "SELECT prod_name, SUM(prod_price * prod_qty) AS total_sales FROM rpos_orders GROUP BY prod_name";
$result = mysqli_query($mysqli, $sql);

// Prepare the data for the chart
$data = array();
while ($row = mysqli_fetch_assoc($result)) {
    $data[$row['prod_name']] = $row['total_sales'];
}

// Generate a JSON representation of the data for the chart
$json_data = json_encode($data);
?>

<!DOCTYPE html>
<html>
<head>
    <!-- Include Chart.js library from CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <link rel="icon" type="image/png" href="assets/img/icons/favicon.png">
</head>
<body>
    <canvas id="salesChart"></canvas>
    <script>
    var ctx = document.getElementById('salesChart').getContext('2d');
    var chartData = <?php echo $json_data; ?>;
    var chartLabels = Object.keys(chartData);
    var chartValues = Object.values(chartData);

    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: chartLabels,
            datasets: [{
                label: 'Total Sales',
                data: chartValues,
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
    </script>
</body>
</html>
