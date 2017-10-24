ALTER TABLE "dwa".geo ADD CONSTRAINT
  PRIMARY KEY (g_geoid)
  CONSTRAINT p1;

ALTER TABLE "dwa".state ADD CONSTRAINT
  PRIMARY KEY (s_stateid)
  CONSTRAINT p2;

ALTER TABLE "dwa".label ADD CONSTRAINT
  PRIMARY KEY (l_labelid)
  CONSTRAINT p3;

ALTER TABLE "dwa".color ADD CONSTRAINT
  PRIMARY KEY (co_colorid)
  CONSTRAINT p4;

ALTER TABLE "dwa".fashionitem ADD CONSTRAINT
  PRIMARY KEY (f_fitemid)
  CONSTRAINT p5;

ALTER TABLE "dwa".designer ADD CONSTRAINT
  PRIMARY KEY (d_designerid)
  CONSTRAINT p6;

ALTER TABLE "dwa".article ADD CONSTRAINT
  PRIMARY KEY (a_artid)
  CONSTRAINT p7;

ALTER TABLE "dwa".supplier ADD CONSTRAINT
  PRIMARY KEY (su_suppid)
  CONSTRAINT p8;

ALTER TABLE "dwa".customer ADD CONSTRAINT
  PRIMARY KEY (c_custid)
  CONSTRAINT p9;

ALTER TABLE "dwa".order ADD CONSTRAINT
  PRIMARY KEY (o_orderid)
  CONSTRAINT p10;

ALTER TABLE "dwa".inventory ADD CONSTRAINT
  PRIMARY KEY (i_artid, i_suppid)
  CONSTRAINT p11;


ALTER TABLE "dwa".partlist ADD CONSTRAINT
  UNIQUE (p_orderid, p_artid)
  CONSTRAINT u2;


ALTER TABLE "dwa".state ADD CONSTRAINT
  FOREIGN KEY (s_geoid) REFERENCES "dwa".geo (g_geoid)
  CONSTRAINT f1;

ALTER TABLE "dwa".designer ADD CONSTRAINT
  FOREIGN KEY (d_stateid) REFERENCES "dwa".state (s_stateid)
  CONSTRAINT f2;

ALTER TABLE "dwa".supplier ADD CONSTRAINT
  FOREIGN KEY (su_stateid) REFERENCES "dwa".state (s_stateid)
  CONSTRAINT f3;

ALTER TABLE "dwa".customer ADD CONSTRAINT
  FOREIGN KEY (c_stateid) REFERENCES "dwa".state (s_stateid)
  CONSTRAINT f4;

ALTER TABLE "dwa".article ADD CONSTRAINT
  FOREIGN KEY (a_colorid) REFERENCES "dwa".color (co_colorid)
  CONSTRAINT f5;

ALTER TABLE "dwa".article ADD CONSTRAINT
  FOREIGN KEY (a_fitemid) REFERENCES "dwa".fashionitem (f_fitemid)
  CONSTRAINT f6;

ALTER TABLE "dwa".article ADD CONSTRAINT
  FOREIGN KEY (a_designerid) REFERENCES "dwa".designer (d_designerid)
  CONSTRAINT f7;

ALTER TABLE "dwa".article ADD CONSTRAINT
  FOREIGN KEY (a_labelid) REFERENCES "dwa".label (l_labelid)
  CONSTRAINT f8;

ALTER TABLE "dwa".inventory ADD CONSTRAINT
  FOREIGN KEY (i_artid) REFERENCES "dwa".article (a_artid)
  CONSTRAINT f9;

ALTER TABLE "dwa".inventory ADD CONSTRAINT
  FOREIGN KEY (i_suppid) REFERENCES "dwa".supplier (su_suppid)
  CONSTRAINT f10;

ALTER TABLE "dwa".order ADD CONSTRAINT
  FOREIGN KEY (o_custid) REFERENCES "dwa".customer (c_custid)
  CONSTRAINT f11;

ALTER TABLE "dwa".partlist ADD CONSTRAINT
  FOREIGN KEY (p_orderid) REFERENCES "dwa".order (o_orderid)
  CONSTRAINT f12;

ALTER TABLE "dwa".partlist ADD CONSTRAINT
  FOREIGN KEY (p_artid) REFERENCES "dwa".article (a_artid)
  CONSTRAINT f13;

ALTER TABLE "dwa".partlist ADD CONSTRAINT
  FOREIGN KEY (p_suppid) REFERENCES "dwa".supplier (su_suppid)
  CONSTRAINT f14;

ALTER TABLE "dwa".partlist ADD CONSTRAINT
  FOREIGN KEY (p_artid, p_suppid) REFERENCES "dwa".inventory (i_artid, i_suppid)
  CONSTRAINT f15;

