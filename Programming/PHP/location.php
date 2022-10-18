<?php

// $location = [Latitude, Longitude]
$Location_1 = [52.0, 5,0];
$Location_2 = [52.5, 5.5];

// Calculate the distance between A and B in Kilometers.
function distance($Location_A, $Location_B) 
{
  if (  ($Location_A[0] == $Location_B[0]) && 
        ($Location_A[1] == $Location_B[1]) ) {
    return 0;
  } else {
    $theta      = $Location_A[1] - $Location_B[1];
    $distance   = sin(deg2rad($Location_A[0])) * sin(deg2rad($Location_B[0])) + 
                  cos(deg2rad($Location_A[0])) * cos(deg2rad($Location_B[0])) * cos(deg2rad($theta));
    $distance   = acos($distance);
    $distance   = rad2deg($distance);
    $Kilometers = $distance * 60 * 1.853159616;
    return $Kilometers;

  }
}

echo "Distance: " . distance($Location_1,$Location_2) . " Kilometers";

?>
