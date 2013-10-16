From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] mmc: dw_mmc: Add missing description
Date: Wed, 16 Oct 2013 11:35:54 +0530
Message-ID: <1381903554-3456-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34151 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844Ab3JPGGm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Oct 2013 02:06:42 -0400
Received: by mail-pa0-f42.google.com with SMTP id kx10so566814pab.15
        for <linux-mmc@vger.kernel.org>; Tue, 15 Oct 2013 23:06:42 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: jh80.chung@samsung.com, cjb@laptop.org, sachin.kamat@linaro.org, Seungwon Jeon <tgih.jun@samsung.com>

Commit 0976f16d ("mmc: dw_mmc: add support tuning scheme") introduced
the execute_tuning hook but did not add its description for kernel docs.
Update the same.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>
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

