From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 2/4] mmc: core: implement enhanced strobe support
Date: Thu,  3 Mar 2016 10:36:36 +0800
Message-ID: <1456972596-8077-1-git-send-email-shawn.lin@rock-chips.com>
References: <1456972557-7994-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456972557-7994-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

Controllers use data strobe line to latch data from devices
under hs400 mode, but not for cmd line. So from emmc 5.1, JEDEC
introduces enhanced strobe mode for latching cmd response from
emmc devices to host controllers. This new feature is optional.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/mmc.c   | 54 +++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mmc/card.h |  1 +
 include/linux/mmc/host.h |  2 ++
 include/linux/mmc/mmc.h  |  2 ++
 4 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4dbe3df..701ab27 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -585,6 +585,12 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		card->ext_csd.ffu_capable =
 			(ext_csd[EXT_CSD_SUPPORTED_MODE] & 0x1) &&
 			!(ext_csd[EXT_CSD_FW_CONFIG] & 0x1);
+		/*
+		* Enhance Strobe is supported since v5.1 which rev should be
+		* 8 but some eMMC devices can support it with rev 7. So handle
+		* Enhance Strobe here.
+		*/
+		card->ext_csd.strobe_support = ext_csd[EXT_CSD_STROBE_SUPPORT];
 	}
 out:
 	return err;
@@ -1097,9 +1103,26 @@ static int mmc_select_hs400(struct mmc_card *card)
 	}
 
 	/* Switch card to DDR */
+	val = EXT_CSD_DDR_BUS_WIDTH_8;
+	if (card->ext_csd.strobe_support && mmc_host_enhanced_strobe(host)) {
+		val |= EXT_CSD_BUS_WIDTH_STROBE;
+		/*
+		* Make sure we are in non-enhanced strobe mode before we
+		* actually enable it in ext_csd.
+		*/
+		if (host->ops->prepare_enhanced_strobe)
+			err = host->ops->prepare_enhanced_strobe(host, false);
+
+		if (err) {
+			pr_err("%s: unprepare_enhanced strobe failed, err:%d\n",
+				mmc_hostname(host), err);
+			return err;
+		}
+	}
+
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			 EXT_CSD_BUS_WIDTH,
-			 EXT_CSD_DDR_BUS_WIDTH_8,
+			 val,
 			 card->ext_csd.generic_cmd6_time);
 	if (err) {
 		pr_err("%s: switch to bus width for hs400 failed, err:%d\n",
@@ -1107,6 +1130,35 @@ static int mmc_select_hs400(struct mmc_card *card)
 		return err;
 	}
 
+	if (card->ext_csd.strobe_support && mmc_host_enhanced_strobe(host)) {
+		/* Controller enable enhanced strobe function */
+		if (host->ops->prepare_enhanced_strobe)
+			err = host->ops->prepare_enhanced_strobe(host, true);
+
+		if (err) {
+			pr_err("%s: prepare enhanced strobe failed, err:%d\n",
+				mmc_hostname(host), err);
+			return err;
+		}
+
+		mmc_set_bus_width(host, MMC_BUS_WIDTH_8);
+		/*
+		 * If controller can't handle bus width test,
+		 * compare ext_csd previously read in 1 bit mode
+		 * against ext_csd at new bus width
+		 */
+		if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST))
+			err = mmc_compare_ext_csds(card, MMC_BUS_WIDTH_8);
+		else
+			err = mmc_bus_test(card, MMC_BUS_WIDTH_8);
+
+		if (err) {
+			pr_warn("%s: switch to enhanced strobe failed\n",
+				mmc_hostname(host));
+			return err;
+		}
+	}
+
 	/* Switch card to HS400 */
 	val = EXT_CSD_TIMING_HS400 |
 	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index eb0151b..22defc2 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -95,6 +95,7 @@ struct mmc_ext_csd {
 	u8			raw_partition_support;	/* 160 */
 	u8			raw_rpmb_size_mult;	/* 168 */
 	u8			raw_erased_mem_count;	/* 181 */
+	u8			strobe_support;		/* 184 */
 	u8			raw_ext_csd_structure;	/* 194 */
 	u8			raw_card_type;		/* 196 */
 	u8			raw_driver_strength;	/* 197 */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 2a292b3..8ef3bde 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -132,6 +132,8 @@ struct mmc_host_ops {
 
 	/* Prepare HS400 target operating frequency depending host driver */
 	int	(*prepare_hs400_tuning)(struct mmc_host *host, struct mmc_ios *ios);
+	/* Prepare enhanced strobe depending host driver */
+	int	(*prepare_enhanced_strobe)(struct mmc_host *host, bool enable);
 	int	(*select_drive_strength)(struct mmc_card *card,
 					 unsigned int max_dtr, int host_drv,
 					 int card_drv, int *drv_type);
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 15f2c4a..593c605 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -297,6 +297,7 @@ struct _mmc_csd {
 #define EXT_CSD_PART_CONFIG		179	/* R/W */
 #define EXT_CSD_ERASED_MEM_CONT		181	/* RO */
 #define EXT_CSD_BUS_WIDTH		183	/* R/W */
+#define EXT_CSD_STROBE_SUPPORT		184	/* RO */
 #define EXT_CSD_HS_TIMING		185	/* R/W */
 #define EXT_CSD_POWER_CLASS		187	/* R/W */
 #define EXT_CSD_REV			192	/* RO */
@@ -386,6 +387,7 @@ struct _mmc_csd {
 #define EXT_CSD_BUS_WIDTH_8	2	/* Card is in 8 bit mode */
 #define EXT_CSD_DDR_BUS_WIDTH_4	5	/* Card is in 4 bit DDR mode */
 #define EXT_CSD_DDR_BUS_WIDTH_8	6	/* Card is in 8 bit DDR mode */
+#define EXT_CSD_BUS_WIDTH_STROBE BIT(7)	/* Enhanced strobe mode */
 
 #define EXT_CSD_TIMING_BC	0	/* Backwards compatility */
 #define EXT_CSD_TIMING_HS	1	/* High speed */
-- 
2.3.7
