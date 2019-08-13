#!/bin/bash

user_pwd=omp/omp@omp
root_path=/home/oracle/datas
date_menu=20190806

sqlldr $user_pwd control=$root_path/ctls/AFA_AFA_MAINMSGDTL.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_AFA_AFA_MAINMSGDTL_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/ATMV_DEV_CATALOG.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_ATMV_DEV_CATALOG_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/ATMV_DEV_INFO.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_ATMV_DEV_INFO_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/ATMV_DEV_TYPE.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_ATMV_DEV_TYPE_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/CBOD_CMTLRCUR.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_CBOD_T1_CMTLRCUR_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/CBOD_CMTLRTLR.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_CBOD_T1_CMTLRTLR_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/CBOD_CMTRRTRR.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_CBOD_T1_CMTRRTRR_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/CBOD_FCMARL1.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_CBOD_T2_FCMARL1_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/CBOD_FCMAUDI.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_CBOD_T2_FCMAUDI_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/CBOD_GLACATXN.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_CBOD_T2_GLACATXN_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/CBOD_SAACNACN.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_CBOD_T2_SAACNACN_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/CBOD_SAACNTXN.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_CBOD_T2_SAACNTXN_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/CMIS_USER_INFO.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_CMIS_USER_INFO_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/CBOMS_ACCOUNT_ORG_TABLE.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_GMCZ_ACCOUNT_ORG_TABLE_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/CBOMS_WF_FXYJ_ERROR_APPLY.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_GMCZ_WF_FXYJ_ERROR_APPLY_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/NBMS_BMS_ACCEPT_CONTRACT.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_NBMS_BMS_ACCEPT_CONTRACT_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/NBMS_BMS_ACCEPT_DETAILS.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_NBMS_BMS_ACCEPT_DETAILS_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/NBMS_BMS_ACCEPT_DUE_PAY.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_NBMS_BMS_ACCEPT_DUE_PAY_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/NBMS_BMS_ACCT_HISTORY.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_NBMS_BMS_ACCT_HISTORY_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/NBMS_BMS_BUY_CONTRACT.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_NBMS_BMS_BUY_CONTRACT_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/NBMS_BMS_BUY_DETAILS.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_NBMS_BMS_BUY_DETAILS_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/NBMS_CPES_QUOTE_CONTRACT.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_NBMS_CPES_QUOTE_CONTRACT_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/NBMS_CPES_QUOTE_DETAILS.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_NBMS_CPES_QUOTE_DETAILS_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/NBMS_CPES_QUOTE_DUE.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_NBMS_CPES_QUOTE_DUE_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/NBMS_CPES_REDSCT_CONTRACT.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_NBMS_CPES_REDSCT_CONTRACT_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/NBMS_CPES_REDSCT_DUE.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_NBMS_CPES_REDSCT_DUE_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/RPT_M_RPT_STM_YWFLLTJB.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_ODS_M_RPT_STM_YWFLLTJB_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/RPT_M_RPT_STM_YWZHLTJB.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_ODS_M_RPT_STM_YWZHLTJB_$date_menu.del
sqlldr $user_pwd control=$root_path/ctls/RPT_M_RPT_STM_ZYYWZHLTJB.ctl log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/P_OMP_ODS_M_RPT_STM_ZYYWZHLTJB_$date_menu.del
