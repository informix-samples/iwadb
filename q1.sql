SELECT 
    SUM(p_quantity) AS Quantity,
    geo_d.g_name AS Designer_Geography,
    d_name AS Designer,
    l_name AS Label,
    f_name AS Fashion_item,
    co_name AS Color,
    geo_c.g_name AS Customer_Geography
  FROM
    partlist,
    order,
    customer,
    state state_c,
    geo geo_c,
    article,
    designer,
    state state_d,
    geo geo_d,
    color,
    label,
    fashionitem
  WHERE
        p_orderid = o_orderid
    AND o_custid = c_custid
    AND c_stateid = state_c.s_stateid
    AND state_c.s_geoid = geo_c.g_geoid
    AND p_artid = a_artid
    AND a_designerid = d_designerid
    AND d_stateid = state_d.s_stateid
    AND state_d.s_geoid = geo_d.g_geoid
    AND a_colorid = co_colorid
    AND a_labelid = l_labelid
    AND a_fitemid = f_fitemid
    AND ( geo_d.g_name = "America" OR geo_d.g_name = "Europe" )
    AND ( geo_c.g_name = "Asia" OR geo_c.g_name = "Africa" )
    AND ( co_name = "blue" OR co_name = "pink" )
  GROUP BY
    geo_d.g_name,
    d_name,
    l_name,
    f_name,
    co_name,
    geo_c.g_name
;
