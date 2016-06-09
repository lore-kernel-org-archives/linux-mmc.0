From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 31/46] mmc: mmc: Add Command Queue definitions
Date: Thu,  9 Jun 2016 14:52:31 +0300
Message-ID: <1465473166-22532-32-git-send-email-adrian.hunter@intel.com>
References: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48207 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750947AbcFIL6v (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jun 2016 07:58:51 -0400
In-Reply-To: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>

Add definitions relating to Command Queuing.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c   | 19 +++++++++++++++++++
 include/linux/mmc/card.h |  3 +++
 include/linux/mmc/mmc.h  | 17 +++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 97a664f758b0..eb1781b066f3 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -599,6 +599,23 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 			(ext_csd[EXT_CSD_SUPPORTED_MODE] & 0x1) &&
 			!(ext_csd[EXT_CSD_FW_CONFIG] & 0x1);
 	}
+
+	/* eMMC v5.1 or later */
+	if (card->ext_csd.rev >= 8) {
+		card->ext_csd.cmdq_support = ext_csd[EXT_CSD_CMDQ_SUPPORT] &
+					     EXT_CSD_CMDQ_SUPPORTED;
+		card->ext_csd.cmdq_depth = (ext_csd[EXT_CSD_CMDQ_DEPTH] &
+					    EXT_CSD_CMDQ_DEPTH_MASK) + 1;
+		if (card->ext_csd.cmdq_depth <= 2) {
+			card->ext_csd.cmdq_support = false;
+			card->ext_csd.cmdq_depth = 0;
+		}
+		if (card->ext_csd.cmdq_support) {
+			pr_debug("%s: Command Queue supported depth %u\n",
+				 mmc_hostname(card->host),
+				 card->ext_csd.cmdq_depth);
+		}
+	}
 out:
 	return err;
 }
@@ -733,6 +750,7 @@ MMC_DEV_ATTR(enhanced_area_offset, "%llu\n",
 MMC_DEV_ATTR(enhanced_area_size, "%u\n", card->ext_csd.enhanced_area_size);
 MMC_DEV_ATTR(raw_rpmb_size_mult, "%#x\n", card->ext_csd.raw_rpmb_size_mult);
 MMC_DEV_ATTR(rel_sectors, "%#x\n", card->ext_csd.rel_sectors);
+MMC_DEV_ATTR(cmdq_en, "%d\n", card->ext_csd.cmdq_en);
 
 static ssize_t mmc_fwrev_show(struct device *dev,
 			      struct device_attribute *attr,
@@ -768,6 +786,7 @@ static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_enhanced_area_size.attr,
 	&dev_attr_raw_rpmb_size_mult.attr,
 	&dev_attr_rel_sectors.attr,
+	&dev_attr_cmdq_en.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(mmc_std);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 22defc2a83b7..1c380271038f 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -89,6 +89,9 @@ struct mmc_ext_csd {
 	unsigned int		boot_ro_lock;		/* ro lock support */
 	bool			boot_ro_lockable;
 	bool			ffu_capable;	/* Firmware upgrade support */
+	bool			cmdq_en;	/* Command Queue enabled */
+	bool			cmdq_support;	/* Command Queue supported */
+	unsigned int		cmdq_depth;	/* Command Queue depth */
 #define MMC_FIRMWARE_LEN 8
 	u8			fwrev[MMC_FIRMWARE_LEN];  /* FW version */
 	u8			raw_exception_status;	/* 54 */
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index c376209c70ef..672730acc705 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -84,6 +84,13 @@
 #define MMC_APP_CMD              55   /* ac   [31:16] RCA        R1  */
 #define MMC_GEN_CMD              56   /* adtc [0] RD/WR          R1  */
 
+  /* class 11 */
+#define MMC_QUE_TASK_PARAMS      44   /* ac   [20:16] task id    R1  */
+#define MMC_QUE_TASK_ADDR        45   /* ac   [31:0] data addr   R1  */
+#define MMC_EXECUTE_READ_TASK    46   /* adtc [20:16] task id    R1  */
+#define MMC_EXECUTE_WRITE_TASK   47   /* adtc [20:16] task id    R1  */
+#define MMC_CMDQ_TASK_MGMT       48   /* ac   [20:16] task id    R1b */
+
 static inline bool mmc_op_multi(u32 opcode)
 {
 	return opcode == MMC_WRITE_MULTIPLE_BLOCK ||
@@ -272,6 +279,7 @@ struct _mmc_csd {
  * EXT_CSD fields
  */
 
+#define EXT_CSD_CMDQ_MODE_EN		15	/* R/W */
 #define EXT_CSD_FLUSH_CACHE		32      /* W */
 #define EXT_CSD_CACHE_CTRL		33      /* R/W */
 #define EXT_CSD_POWER_OFF_NOTIFICATION	34	/* R/W */
@@ -331,6 +339,8 @@ struct _mmc_csd {
 #define EXT_CSD_CACHE_SIZE		249	/* RO, 4 bytes */
 #define EXT_CSD_PWR_CL_DDR_200_360	253	/* RO */
 #define EXT_CSD_FIRMWARE_VERSION	254	/* RO, 8 bytes */
+#define EXT_CSD_CMDQ_DEPTH		307	/* RO */
+#define EXT_CSD_CMDQ_SUPPORT		308	/* RO */
 #define EXT_CSD_SUPPORTED_MODE		493	/* RO */
 #define EXT_CSD_TAG_UNIT_SIZE		498	/* RO */
 #define EXT_CSD_DATA_TAG_SUPPORT	499	/* RO */
@@ -438,6 +448,13 @@ struct _mmc_csd {
 #define EXT_CSD_MANUAL_BKOPS_MASK	0x01
 
 /*
+ * Command Queue
+ */
+#define EXT_CSD_CMDQ_MODE_ENABLED	BIT(0)
+#define EXT_CSD_CMDQ_DEPTH_MASK		GENMASK(4, 0)
+#define EXT_CSD_CMDQ_SUPPORTED		BIT(0)
+
+/*
  * MMC_SWITCH access modes
  */
 
-- 
1.9.1

