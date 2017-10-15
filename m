From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v3 2/3] mmc: parse new binding for eMMC fixed driver type
Date: Sun, 15 Oct 2017 14:46:14 +0200
Message-ID: <20171015124615.31391-3-wsa+renesas@sang-engineering.com>
References: <20171015124615.31391-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46255 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750924AbdJOMq1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 15 Oct 2017 08:46:27 -0400
In-Reply-To: <20171015124615.31391-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Parse the new binding and store it in the host struct after doing some
sanity checks. The code is designed to support fixed SD driver type if
we ever need that.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes since V2:
 * moved from core.c to mmc.c and adapted the code to the new place
 * fixed setting now always has highest priority

 drivers/mmc/core/host.c  | 13 ++++++++++++-
 drivers/mmc/core/mmc.c   | 11 ++++++++---
 include/linux/mmc/host.h |  2 ++
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index e58be39b15685e..35a9e4fd1a9f51 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -179,7 +179,7 @@ static void mmc_retune_timer(unsigned long data)
 int mmc_of_parse(struct mmc_host *host)
 {
 	struct device *dev = host->parent;
-	u32 bus_width;
+	u32 bus_width, drv_type;
 	int ret;
 	bool cd_cap_invert, cd_gpio_invert = false;
 	bool ro_cap_invert, ro_gpio_invert = false;
@@ -321,6 +321,15 @@ int mmc_of_parse(struct mmc_host *host)
 	if (device_property_read_bool(dev, "no-mmc"))
 		host->caps2 |= MMC_CAP2_NO_MMC;
 
+	/* Must be after "non-removable" check */
+	if (device_property_read_u32(dev, "fixed-emmc-driver-type", &drv_type) == 0) {
+		if (host->caps & MMC_CAP_NONREMOVABLE)
+			host->fixed_drv_type = drv_type;
+		else
+			dev_err(host->parent,
+				"can't use fixed driver type, media is removable\n");
+	}
+
 	host->dsr_req = !device_property_read_u32(dev, "dsr", &host->dsr);
 	if (host->dsr_req && (host->dsr & ~0xffff)) {
 		dev_err(host->parent,
@@ -393,6 +402,8 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	host->max_blk_size = 512;
 	host->max_blk_count = PAGE_SIZE / 512;
 
+	host->fixed_drv_type = -EINVAL;
+
 	return host;
 }
 
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 44d67ee8bf7bf2..5e58c5a1508db4 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1289,13 +1289,18 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 static void mmc_select_driver_type(struct mmc_card *card)
 {
 	int card_drv_type, drive_strength, drv_type;
+	int fixed_drv_type = card->host->fixed_drv_type;
 
 	card_drv_type = card->ext_csd.raw_driver_strength |
 			mmc_driver_type_mask(0);
 
-	drive_strength = mmc_select_drive_strength(card,
-						   card->ext_csd.hs200_max_dtr,
-						   card_drv_type, &drv_type);
+	if (fixed_drv_type >= 0)
+		drive_strength = card_drv_type & mmc_driver_type_mask(fixed_drv_type)
+				 ? fixed_drv_type : 0;
+	else
+		drive_strength = mmc_select_drive_strength(card,
+							   card->ext_csd.hs200_max_dtr,
+							   card_drv_type, &drv_type);
 
 	card->drive_strength = drive_strength;
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index c296f4351c1da4..e7743eca102196 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -354,6 +354,8 @@ struct mmc_host {
 #define MMC_CAP2_CQE		(1 << 23)	/* Has eMMC command queue engine */
 #define MMC_CAP2_CQE_DCMD	(1 << 24)	/* CQE can issue a direct command */
 
+	int			fixed_drv_type;	/* fixed driver type for non-removable media */
+
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
 	/* host specific block data */
-- 
2.11.0

