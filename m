From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/2] mmc: block: support no access to boot partitions
Date: Fri, 23 Sep 2011 12:48:21 +0300
Message-ID: <1316771301-12323-3-git-send-email-adrian.hunter@intel.com>
References: <1316771301-12323-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:42644 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752800Ab1IWJse (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 23 Sep 2011 05:48:34 -0400
In-Reply-To: <1316771301-12323-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

Intel Medfield platform blocks access to eMMC boot partitions
which results in switch errors.  Since there is no access,
mmcboot0/1 devices should not be created.  Add a host
capability to reflect that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/block.c     |    2 +-
 drivers/mmc/host/sdhci-pci.c |    2 ++
 include/linux/mmc/host.h     |   10 ++++++++++
 3 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 2350ac9..ad005e5 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1478,7 +1478,7 @@ static int mmc_blk_alloc_parts(struct mmc_card *card, struct mmc_blk_data *md)
 	if (!mmc_card_mmc(card))
 		return 0;
 
-	if (card->ext_csd.boot_size) {
+	if (card->ext_csd.boot_size && mmc_boot_partition_access(card->host)) {
 		ret = mmc_blk_alloc_part(card, md, EXT_CSD_PART_CONFIG_ACC_BOOT0,
 					 card->ext_csd.boot_size >> 9,
 					 true,
diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 3b30c51..f8a17f9 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -215,6 +215,8 @@ static int mfd_emmc_probe_slot(struct sdhci_pci_slot *slot)
 
 	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA;
 
+	slot->host->mmc->caps2 = MMC_CAP2_BOOTPART_NOACC;
+
 	return 0;
 }
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index b2aefea..aed5bc7 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -236,6 +236,10 @@ struct mmc_host {
 #define MMC_CAP_CMD23		(1 << 30)	/* CMD23 supported. */
 #define MMC_CAP_HW_RESET	(1 << 31)	/* Hardware reset */
 
+	unsigned int		caps2;		/* More host capabilities */
+
+#define MMC_CAP2_BOOTPART_NOACC	(1 << 0)	/* Boot partition no access */
+
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
 #ifdef CONFIG_MMC_CLKGATE
@@ -404,4 +408,10 @@ static inline int mmc_host_cmd23(struct mmc_host *host)
 {
 	return host->caps & MMC_CAP_CMD23;
 }
+
+static inline int mmc_boot_partition_access(struct mmc_host *host)
+{
+	return !(host->caps2 & MMC_CAP2_BOOTPART_NOACC);
+}
+
 #endif /* LINUX_MMC_HOST_H */
-- 
1.7.6

