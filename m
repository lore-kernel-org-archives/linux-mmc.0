From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V9 05/11] mmc: mmc: Add functions to enable / disable the Command Queue
Date: Thu,  8 Dec 2016 10:44:32 +0200
Message-ID: <1481186678-6307-6-git-send-email-adrian.hunter@intel.com>
References: <1481186678-6307-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:38669 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751667AbcLHIuE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Dec 2016 03:50:04 -0500
In-Reply-To: <1481186678-6307-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Add helper functions to enable or disable the Command Queue.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 Documentation/mmc/mmc-dev-attrs.txt |  1 +
 drivers/mmc/core/mmc.c              |  2 ++
 drivers/mmc/core/mmc_ops.c          | 28 ++++++++++++++++++++++++++++
 include/linux/mmc/card.h            |  1 +
 include/linux/mmc/core.h            |  2 ++
 5 files changed, 34 insertions(+)

diff --git a/Documentation/mmc/mmc-dev-attrs.txt b/Documentation/mmc/mmc-dev-attrs.txt
index 404a0e9e92b0..dcd1252877fb 100644
--- a/Documentation/mmc/mmc-dev-attrs.txt
+++ b/Documentation/mmc/mmc-dev-attrs.txt
@@ -30,6 +30,7 @@ All attributes are read-only.
 	rel_sectors		Reliable write sector count
 	ocr 			Operation Conditions Register
 	dsr			Driver Stage Register
+	cmdq_en			Command Queue enabled: 1 => enabled, 0 => not enabled
 
 Note on Erase Size and Preferred Erase Size:
 
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index b61b52f9da3d..5d9bb28ec550 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -771,6 +771,7 @@ static int mmc_compare_ext_csds(struct mmc_card *card, unsigned bus_width)
 MMC_DEV_ATTR(raw_rpmb_size_mult, "%#x\n", card->ext_csd.raw_rpmb_size_mult);
 MMC_DEV_ATTR(rel_sectors, "%#x\n", card->ext_csd.rel_sectors);
 MMC_DEV_ATTR(ocr, "%08x\n", card->ocr);
+MMC_DEV_ATTR(cmdq_en, "%d\n", card->ext_csd.cmdq_en);
 
 static ssize_t mmc_fwrev_show(struct device *dev,
 			      struct device_attribute *attr,
@@ -824,6 +825,7 @@ static ssize_t mmc_dsr_show(struct device *dev,
 	&dev_attr_rel_sectors.attr,
 	&dev_attr_ocr.attr,
 	&dev_attr_dsr.attr,
+	&dev_attr_cmdq_en.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(mmc_std);
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index b11c3455b040..210a12c2626f 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -839,3 +839,31 @@ int mmc_can_ext_csd(struct mmc_card *card)
 {
 	return (card && card->csd.mmca_vsn > CSD_SPEC_VER_3);
 }
+
+static int mmc_cmdq_switch(struct mmc_card *card, bool enable)
+{
+	u8 val = enable ? EXT_CSD_CMDQ_MODE_ENABLED : 0;
+	int err;
+
+	if (!card->ext_csd.cmdq_support)
+		return -EOPNOTSUPP;
+
+	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_CMDQ_MODE_EN,
+			 val, card->ext_csd.generic_cmd6_time);
+	if (!err)
+		card->ext_csd.cmdq_en = enable;
+
+	return err;
+}
+
+int mmc_cmdq_enable(struct mmc_card *card)
+{
+	return mmc_cmdq_switch(card, true);
+}
+EXPORT_SYMBOL_GPL(mmc_cmdq_enable);
+
+int mmc_cmdq_disable(struct mmc_card *card)
+{
+	return mmc_cmdq_switch(card, false);
+}
+EXPORT_SYMBOL_GPL(mmc_cmdq_disable);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 514ed4e57c5f..a98cc67dc7c6 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -89,6 +89,7 @@ struct mmc_ext_csd {
 	unsigned int		boot_ro_lock;		/* ro lock support */
 	bool			boot_ro_lockable;
 	bool			ffu_capable;	/* Firmware upgrade support */
+	bool			cmdq_en;	/* Command Queue enabled */
 	bool			cmdq_support;	/* Command Queue supported */
 	unsigned int		cmdq_depth;	/* Command Queue depth */
 #define MMC_FIRMWARE_LEN 8
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index e33cc748dcfe..5d2819b2f543 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -178,6 +178,8 @@ extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
 extern int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
 extern int mmc_abort_tuning(struct mmc_host *host, u32 opcode);
 extern int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
+extern int mmc_cmdq_enable(struct mmc_card *card);
+extern int mmc_cmdq_disable(struct mmc_card *card);
 
 #define MMC_ERASE_ARG		0x00000000
 #define MMC_SECURE_ERASE_ARG	0x80000000
-- 
1.9.1

