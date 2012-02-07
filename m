From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/4] mmc: core: add high-capacity erase size capability flag
Date: Tue,  7 Feb 2012 14:48:52 +0200
Message-ID: <1328618935-25175-2-git-send-email-adrian.hunter@intel.com>
References: <1328618935-25175-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53459 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755910Ab2BGMsz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Feb 2012 07:48:55 -0500
In-Reply-To: <1328618935-25175-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Let drivers specify the use of high-capacity erase size.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c   |    3 ++-
 include/linux/mmc/host.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 6b13776..bd2f71f 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -949,7 +949,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 * If enhanced_area_en is TRUE, host needs to enable ERASE_GRP_DEF
 	 * bit.  This bit will be lost every time after a reset or power off.
 	 */
-	if (card->ext_csd.enhanced_area_en) {
+	if (card->ext_csd.enhanced_area_en ||
+	    (card->ext_csd.rev >= 3 && (host->caps2 & MMC_CAP2_HC_ERASE_SZ))) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_ERASE_GROUP_DEF, 1,
 				 card->ext_csd.generic_cmd6_time);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 20d7c82..c7ce9d2 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -258,6 +258,7 @@ struct mmc_host {
 #define MMC_CAP2_HS200		(MMC_CAP2_HS200_1_8V_SDR | \
 				 MMC_CAP2_HS200_1_2V_SDR)
 #define MMC_CAP2_BROKEN_VOLTAGE	(1 << 7)	/* Use the broken voltage */
+#define MMC_CAP2_HC_ERASE_SZ	(1 << 8)	/* High-capacity erase size */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 	unsigned int        power_notify_type;
-- 
1.7.6.4

