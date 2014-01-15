From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 7/9] mmc: dw_mmc: Add missing description
Date: Wed, 15 Jan 2014 11:25:11 +0530
Message-ID: <1389765313-16744-7-git-send-email-sachin.kamat@linaro.org>
References: <1389765313-16744-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:63874 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbaAOF7l (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 00:59:41 -0500
Received: by mail-pa0-f54.google.com with SMTP id fa1so690251pad.27
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jan 2014 21:59:41 -0800 (PST)
In-Reply-To: <1389765313-16744-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, sachin.kamat@linaro.org, patches@linaro.org

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
index 6bf24ab917e6..306451fbbfe1 100644
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

