SELECT 
    SUM(p_quantity) AS Quantity,
    g_name AS Customer_geography,
    l_name AS Label,
    d_name AS Designer,
    f_name AS Fashion_item,
    co_name AS Color
  FROM
    partlist,
    order,
    customer,
    state,
    geo,
    article,
    designer,
    color,
    label,
    fashionitem
  WHERE
        p_orderid = o_orderid
    AND o_custid = c_custid
    AND c_stateid = s_stateid
    AND s_geoid = g_geoid
    AND p_artid = a_artid
    AND a_designerid = d_designerid
    AND a_colorid = co_colorid
    AND a_labelid = l_labelid
    AND a_fitemid = f_fitemid
    AND ( g_name = "America" OR g_name = "Asia" )
    AND ( co_name LIKE "%blue%" OR co_name LIKE "%pink%" )
    AND c_dob > "01/01/1990"
    AND o_date < "12/31/2015"
  GROUP BY
    g_name,
    l_name,
    d_name,
    f_name,
    co_name
  ORDER BY
    g_name,
    l_name,
    d_name,
    f_name,
    co_name,
    Quantity
;
