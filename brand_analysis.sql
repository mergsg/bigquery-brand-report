SELECT
  oi.order_id,
  o.user_id,
  u.country,
  oi.product_id,
  p.category,
  p.brand,
  p.cost,
  oi.sale_price,
  oi.created_at
FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
JOIN `bigquery-public-data.thelook_ecommerce.products` AS p
  ON oi.product_id = p.id
JOIN `bigquery-public-data.thelook_ecommerce.orders` AS o
  ON oi.order_id = o.order_id
JOIN `bigquery-public-data.thelook_ecommerce.users` AS u
  ON o.user_id = u.id
WHERE p.brand = {brand}
  AND oi.created_at BETWEEN {start_date} AND {end_date}