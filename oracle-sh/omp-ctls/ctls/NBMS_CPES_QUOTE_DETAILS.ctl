OPTIONS(DIRECT=TRUE,ROWS=5000) load data truncate into table NBMS_CPES_QUOTE_DETAILS fields terminated by X'1D' optionally enclosed by X'1E' TRAILING NULLCOLS(ID,CONTRACT_ID,DRAFT_ID,DRAFT_AMOUNT,MATURITY_DATE,REAL_DUE_DATE,TENOR_DAYS,DUE_TENOR_DAYS,PAY_INTEREST,DUE_PAY_INTEREST,SETTLE_AMT,DUE_SETTLE_AMT,CREDIT_STATUS,DETAILS_STATUS,ACCOUNT_STATUS,VALID_FLAG,LAST_UPD_OPR,LAST_UPD_TIME,MISC,RESERVER1,RESERVER2,CPES_LOCK_FLAG,CRT_NO,SRC_DT,ETL_DT,THREE_CLASS,RECLASSIFY,RECLASSIFY_DATE,RECLASSIFY_OPERATOR)