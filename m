From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 05/39] mmc: mmc: Add functions to enable / disable the Command Queue
Date: Fri, 10 Feb 2017 14:55:18 +0200
Message-ID: <1486731352-8018-6-git-send-email-adrian.hunter@intel.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26020 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751433AbdBJN25 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Feb 2017 08:28:57 -0500
In-Reply-To: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
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
 drivers/mmc/core/mmc_ops.h          |  2 ++
 include/linux/mmc/card.h            |  1 +
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
index e01e70c24ca2..df154b951a10 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -800,6 +800,7 @@ static int mmc_compare_ext_csds(struct mmc_card *card, unsigned bus_width)
 MMC_DEV_ATTR(raw_rpmb_size_mult, "%#x\n", card->ext_csd.raw_rpmb_size_mult);
 MMC_DEV_ATTR(rel_sectors, "%#x\n", card->ext_csd.rel_sectors);
 MMC_DEV_ATTR(ocr, "%08x\n", card->ocr);
+MMC_DEV_ATTR(cmdq_en, "%d\n", card->ext_csd.cmdq_en);
 
 static ssize_t mmc_fwrev_show(struct device *dev,
 			      struct device_attribute *attr,
@@ -855,6 +856,7 @@ static ssize_t mmc_dsr_show(struct device *dev,
 	&dev_attr_rel_sectors.attr,
 	&dev_attr_ocr.attr,
 	&dev_attr_dsr.attr,
+	&dev_attr_cmdq_en.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(mmc_std);
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index fe80f26d6971..24c58d24c19a 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -838,3 +838,31 @@ int mmc_can_ext_csd(struct mmc_card *card)
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
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 74beea8a9c7e..978bd2e60f8a 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -46,6 +46,8 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 void mmc_start_bkops(struct mmc_card *card, bool from_exception);
 int mmc_can_reset(struct mmc_card *card);
 int mmc_flush_cache(struct mmc_card *card);
+int mmc_cmdq_enable(struct mmc_card *card);
+int mmc_cmdq_disable(struct mmc_card *card);
 
 #endif
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 119ef8f0155c..94637796b99c 100644
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
-- 
1.9.1

