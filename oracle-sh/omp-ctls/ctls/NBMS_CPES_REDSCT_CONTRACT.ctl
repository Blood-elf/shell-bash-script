OPTIONS(DIRECT=TRUE,ROWS=5000) load data truncate into table NBMS_CPES_REDSCT_CONTRACT fields terminated by X'1D' optionally enclosed by X'1E' TRAILING NULLCOLS(ID,CONTRACT_NO,PRODUCT_NO,DEAL_NO,QUOTE_NO,REF_APPLY_NO,TOP_BRANCH_NO,BRANCH_NO,RECEPT_BRH_ID,APPLY_DATE,BUSI_TYPE,TRADER_ID,CFM_TRADER_ID,PBC_BRH_NO,ACPT_USER_ID,ACPT_USER_NAME,ACPT_USER_NOTE,COMPLETE_USER_ID,COMPLETE_USER_NAME,COMPLETE_USER_NOTE,APPROVAL_USER_ID,APPROVAL_USER_NAME,APPROVAL_USER_NOTE,DRAFT_TYPE,DRAFT_ATTR,SUM_COUNT,SUM_AMOUNT,BUY_BACK_AMT,TENOR_DAYS,CLEAR_SPEED,CLEAR_TYPE,SETTLE_MODE,SETTLE_AMT,DUE_SETTLE_AMT,SETTLE_DATE,DUE_SETTLE_DATE,RATE,PAY_INTEREST,DEPARTMENT_NO,MANAGER_NO,APPROVE_RESULT,CONTRACT_STATUS,MESSAGE_STATUS,SETTLE_STATUS,ACCOUNT_STATUS,CREATED_BY,LAST_UPD_OPR,LAST_UPD_TIME,MISC,CRT_NO,SRC_DT,ETL_DT)