OPTIONS(DIRECT=TRUE,ROWS=5000) load data truncate into table ATMV_DEV_CATALOG fields terminated by X'1D' optionally enclosed by X'1E' TRAILING NULLCOLS(ID,NAME,CATALOG_NO,NOTE,SIMPLE_NAME,CRT_NO,SRC_DT,ETL_DT,REMARK,CASH_TYPE)