;;; ../SAPDevelop/doom.d/elisp/engines.el -*- lexical-binding: t; -*-
(defengine kibana-sea
   "https://lp-search-sea.concur.com/app/kibana#/discover/awfrfahtiay8u32xtslz?_g=(refreshinterval:(display:off,pause:!f,value:0),time:(from:now-12h,mode:quick,to:now))&_a=(columns:!(level,correlation_id,description,company_uuid,user_uuid,application),filters:!(),index:'data-*',interval:auto,query:(query_string:(analyze_wildcard:!t,query:'correlation_id:%s')),sort:!('@timestamp',desc))"
   :keybinding "ks"
   :docstring "search by correlationid in sea kibana")

(defengine kibana-int
   "https://lp-search.service.cnqr.tech/app/kibana#/discover/awfrfahtiay8u32xtslz?_g=(refreshinterval:(display:off,pause:!f,value:0),time:(from:now-12h,mode:quick,to:now))&_a=(columns:!(level,correlation_id,description,company_uuid,user_uuid,application),filters:!(),index:'data-*',interval:auto,query:(query_string:(analyze_wildcard:!t,query:'correlation_id:%s')),sort:!('@timestamp',desc))"
   :keybinding "ki"
   :docstring "search by correlationid in int kibana")
