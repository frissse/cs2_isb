Param(
    [int] $fahrenh
)

function FahrenhToCelsius {
    $celsius = ($fahrenh– 32) / 1.8
    return $celsius
}


FahrenhToCelsius $fahrenh