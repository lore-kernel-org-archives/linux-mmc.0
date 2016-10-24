From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V5 10/25] mmc: mmc: Add functions to enable / disable the Command Queue
Date: Mon, 24 Oct 2016 11:37:25 +0300
Message-ID: <1477298260-5064-11-git-send-email-adrian.hunter@intel.com>
References: <1477298260-5064-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33721 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935974AbcJXInP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Oct 2016 04:43:15 -0400
In-Reply-To: <1477298260-5064-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

Add helper functions to enable or disable the Command Queue.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc_ops.c | 27 +++++++++++++++++++++++++++
 include/linux/mmc/core.h   |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 481bbdbae6e7..bd6d246284ef 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -815,3 +815,30 @@ int mmc_can_ext_csd(struct mmc_card *card)
 {
 	return (card && card->csd.mmca_vsn > CSD_SPEC_VER_3);
 }
+
+int mmc_cmdq_switch(struct mmc_card *card, int enable)
+{
+	int err;
+
+	if (!card->ext_csd.cmdq_support)
+		return -EOPNOTSUPP;
+
+	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_CMDQ_MODE_EN,
+			 enable, card->ext_csd.generic_cmd6_time);
+	if (!err)
+		card->ext_csd.cmdq_en = enable;
+
+	return err;
+}
+
+int mmc_cmdq_enable(struct mmc_card *card)
+{
+	return mmc_cmdq_switch(card, EXT_CSD_CMDQ_MODE_ENABLED);
+}
+EXPORT_SYMBOL_GPL(mmc_cmdq_enable);
+
+int mmc_cmdq_disable(struct mmc_card *card)
+{
+	return mmc_cmdq_switch(card, 0);
+}
+EXPORT_SYMBOL_GPL(mmc_cmdq_disable);
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 2b953eb8ceae..05b864ac1635 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -164,6 +164,8 @@ extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
 extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
 extern int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
 extern int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
+extern int mmc_cmdq_enable(struct mmc_card *card);
+extern int mmc_cmdq_disable(struct mmc_card *card);
 
 #define MMC_ERASE_ARG		0x00000000
 #define MMC_SECURE_ERASE_ARG	0x80000000
-- 
1.9.1

