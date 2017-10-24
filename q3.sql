SELECT FIRST 10
    sum(a_stickerprice) AS price,
    f_name AS fashion_item
  FROM article, color, fashionitem
  WHERE
        a_fitemid = f_fitemid
    AND a_colorid = co_colorid
    AND co_name = "blue"
  GROUP BY fashion_item
  ORDER BY price
;
