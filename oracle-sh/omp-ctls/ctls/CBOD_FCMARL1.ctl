OPTIONS(DIRECT=TRUE,ROWS=5000) load data truncate into table CBOD_FCMARL1 fields terminated by X'1D' optionally enclosed by X'1E' TRAILING NULLCOLS(CM_ARL_LOG_NO,CM_YEAR_N,CM_MONTH_N,CM_DAY,CM_TX_ID,CM_TELLER_ID,CM_TELR_1,CM_AUTH_FLAG,CM_SPV_A,CM_SPV_B,CM_TX_FRONT_ID,CRT_NO,SRC_DT,ETL_DT,CMARL1_DB_TIMESTAMP,CM_TERMINAL_ID)
