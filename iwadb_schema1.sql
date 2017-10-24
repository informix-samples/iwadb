CREATE TABLE "dwa".geo (
  g_geoid          INTEGER,
  g_name           VARCHAR(25),
  g_descr          LVARCHAR(152)
);
GRANT ALL ON "dwa".geo TO PUBLIC;

CREATE TABLE "dwa".state (
  s_stateid        INTEGER,
  s_name           VARCHAR(25),
  s_geoid          INTEGER,
  s_descr          LVARCHAR(200)
);
GRANT ALL ON "dwa".state TO PUBLIC;

CREATE TABLE "dwa".label (
  l_labelid        INTEGER,
  l_name           VARCHAR(55)
);
GRANT ALL ON "dwa".label TO PUBLIC;

CREATE TABLE "dwa".color (
  co_colorid       INTEGER,
  co_name          VARCHAR(25)
);
GRANT ALL ON "dwa".color TO PUBLIC;

CREATE TABLE "dwa".fashionitem (
  f_fitemid        INTEGER,
  f_name           VARCHAR(30),
  f_advice         VARCHAR(70)
);
GRANT ALL ON "dwa".fashionitem TO PUBLIC;

CREATE TABLE "dwa".designer (
  d_designerid     INTEGER,
  d_name           VARCHAR(40),
  d_stateid        INTEGER
);
GRANT ALL ON "dwa".designer TO PUBLIC;

CREATE TABLE "dwa".article (
  a_artid          INTEGER,
  a_colorid        INTEGER,
  a_fitemid        INTEGER,
  a_designerid     INTEGER,
  a_labelid        INTEGER,
  a_package        VARCHAR(25),
  a_size           INTEGER,
  a_stickerprice   DECIMAL(15,2),
  a_descr          CHAR(125)
);
GRANT ALL ON "dwa".article TO PUBLIC;

CREATE TABLE "dwa".supplier (
  su_suppid        INTEGER,
  su_stateid       INTEGER,
  su_name          VARCHAR(60),
  su_street        VARCHAR(40),
  su_streetindex   CHAR(10),
  su_rebate        DECIMAL(15,2),
  su_acctbal       DECIMAL(15,2),
  su_indexhits     VARCHAR(140)
);
GRANT ALL ON "dwa".supplier TO PUBLIC;

CREATE TABLE "dwa".inventory (
  i_artid          INTEGER,
  i_suppid         INTEGER,
  i_quantity       INTEGER,
  i_descr          LVARCHAR(199)
);
GRANT ALL ON "dwa".inventory TO PUBLIC;

CREATE TABLE "dwa".customer (
  c_custid         INTEGER,
  c_name           VARCHAR(20),
  c_gender         CHAR(1),
  c_city           VARCHAR(25),
  c_stateid        INTEGER,
  c_dob            DATE,
  c_avgspending    DECIMAL(15,2),
  c_occupation     VARCHAR(38)
);
GRANT ALL ON "dwa".customer TO PUBLIC;

CREATE TABLE "dwa".order (
  o_orderid        INTEGER,
  o_custid         INTEGER,
  o_status         CHAR(10),
  o_date           DATE,
  o_discount       DECIMAL(15,2),
  o_priority       CHAR(15),
  o_shipping       VARCHAR(45)
);
GRANT ALL ON "dwa".order TO PUBLIC;

CREATE TABLE "dwa".partlist (
  p_orderid        INTEGER,
  p_artid          INTEGER,
  p_suppid         INTEGER,
  p_quantity       INTEGER,
  p_salediscount   DECIMAL(15,2),
  p_partstatus     CHAR(9),
  p_shipdate       DATE,
  p_shipmode       CHAR(7)
);

GRANT ALL ON "dwa".partlist TO PUBLIC;
