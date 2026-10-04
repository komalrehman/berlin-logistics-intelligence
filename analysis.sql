-- Berlin Logistics Intelligence: SQL Analysis

-- 1. Shipment volume by order type
SELECT
    "Auftragsart" AS order_type,
    COUNT(*) AS shipments
FROM shipments
GROUP BY "Auftragsart"
ORDER BY shipments DESC;

-- 2. Shipment weight by order type
SELECT
    "Auftragsart" AS order_type,
    COUNT(*) AS shipments,
    ROUND(SUM("Gesamtgewicht pro Sendung"), 2) AS total_weight,
    ROUND(AVG("Gesamtgewicht pro Sendung"), 2) AS avg_weight,
    ROUND(AVG("Distanz (in m)"), 2) AS avg_distance
FROM shipments
GROUP BY "Auftragsart"
ORDER BY avg_weight DESC;

-- 3. Weight vs. distance correlation (Pearson r)
WITH stats AS (
    SELECT
        AVG("Gesamtgewicht pro Sendung") AS avg_weight,
        AVG("Distanz (in m)") AS avg_distance
    FROM shipments
),
corr AS (
    SELECT
        SUM(("Gesamtgewicht pro Sendung" - stats.avg_weight) * ("Distanz (in m)" - stats.avg_distance)) AS numerator,
        SQRT(
            SUM(("Gesamtgewicht pro Sendung" - stats.avg_weight) * ("Gesamtgewicht pro Sendung" - stats.avg_weight)) *
            SUM(("Distanz (in m)" - stats.avg_distance) * ("Distanz (in m)" - stats.avg_distance))
        ) AS denominator
    FROM shipments, stats
)
SELECT ROUND(numerator / denominator, 4) AS weight_distance_correlation
FROM corr;

-- 4. Heavy shipments (>= 300)
SELECT
    "Auftragsart" AS order_type,
    COUNT(*) AS heavy_shipments,
    ROUND(AVG("Gesamtgewicht pro Sendung"), 2) AS avg_weight,
    ROUND(AVG("Distanz (in m)"), 2) AS avg_distance
FROM shipments
WHERE "Gesamtgewicht pro Sendung" >= 300
GROUP BY "Auftragsart"
ORDER BY heavy_shipments DESC;

-- 5. Top PLZ areas by shipment volume (minimum 5 shipments)
SELECT
    PLZ,
    COUNT(*) AS shipments
FROM shipments
GROUP BY PLZ
HAVING COUNT(*) >= 5
ORDER BY shipments DESC, PLZ;

-- 6. Packaging units vs. shipment weight
SELECT
    "Anzahl Verpackungseinheit" AS packaging_units,
    COUNT(*) AS shipments,
    ROUND(AVG("Gesamtgewicht pro Sendung"), 2) AS avg_weight
FROM shipments
GROUP BY "Anzahl Verpackungseinheit"
ORDER BY packaging_units;

-- 7. Overall operational KPIs
SELECT
    COUNT(*) AS total_shipments,
    COUNT(DISTINCT PLZ) AS unique_plz,
    ROUND(SUM("Gesamtgewicht pro Sendung"), 2) AS total_weight,
    ROUND(AVG("Gesamtgewicht pro Sendung"), 2) AS avg_weight,
    ROUND(AVG("Distanz (in m)"), 2) AS avg_distance,
    ROUND(AVG("Anzahl Verpackungseinheit"), 2) AS avg_packaging_units
FROM shipments;
