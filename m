From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH Resend 7/7] mmc: dw_mmc: Add missing description
Date: Wed, 30 Oct 2013 17:13:50 +0530
Message-ID: <1383133430-22079-7-git-send-email-sachin.kamat@linaro.org>
References: <1383133430-22079-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:40916 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302Ab3J3LpY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2013 07:45:24 -0400
Received: by mail-pb0-f42.google.com with SMTP id jt11so1274827pbb.1
        for <linux-mmc@vger.kernel.org>; Wed, 30 Oct 2013 04:45:24 -0700 (PDT)
In-Reply-To: <1383133430-22079-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, sachin.kamat@linaro.org

Commit 0976f16d ("mmc: dw_mmc: add support tuning scheme") introduced
the execute_tuning hook but did not add its description for kernel docs.
Update the same.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 6bf24ab..306451f 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -244,6 +244,7 @@ struct dw_mci_tuning_data {
  * @prepare_command: handle CMD register extensions.
  * @set_ios: handle bus specific extensions.
  * @parse_dt: parse implementation specific device tree properties.
+ * @execute_tuning: implementation specific tuning procedure.
  *
  * Provide controller implementation specific extensions. The usage of this
  * data structure is fully optional and usage of each member in this structure
-- 
1.7.9.5

