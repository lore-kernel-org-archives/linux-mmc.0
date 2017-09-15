From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 2/3] mmc: parse new binding for eMMC fixed driver type
Date: Fri, 15 Sep 2017 20:03:00 +0200
Message-ID: <20170915180301.29175-3-wsa+renesas@sang-engineering.com>
References: <20170915180301.29175-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50135 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751499AbdIOSDF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 15 Sep 2017 14:03:05 -0400
In-Reply-To: <20170915180301.29175-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Parse the new binding and store it in the host struct after doing some
sanity checks. The code is designed to support fixed SD driver type if
we ever need that.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/core/core.c  | 28 +++++++++++++++++++++++-----
 drivers/mmc/core/host.c  | 11 ++++++++++-
 include/linux/mmc/host.h |  2 ++
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 66c9cf49ad2f11..db5e55b654c04d 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1580,6 +1580,18 @@ void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type)
 	mmc_set_ios(host);
 }
 
+static int mmc_select_fixed_drive_strength(struct mmc_card *card,
+				       unsigned int max_dtr, int host_drv,
+				       int card_drv, int *drv_type)
+{
+	int ret = 0, preset = card->host->fixed_drv_type;
+
+	if (card->type == MMC_TYPE_MMC)
+		ret = card_drv & mmc_driver_type_mask(preset) ? preset : 0;
+
+	return ret;
+}
+
 int mmc_select_drive_strength(struct mmc_card *card, unsigned int max_dtr,
 			      int card_drv_type, int *drv_type)
 {
@@ -1588,7 +1600,7 @@ int mmc_select_drive_strength(struct mmc_card *card, unsigned int max_dtr,
 
 	*drv_type = 0;
 
-	if (!host->ops->select_drive_strength)
+	if (!host->ops->select_drive_strength && !host->fixed_drv_type)
 		return 0;
 
 	/* Use SD definition of driver strength for hosts */
@@ -1607,10 +1619,16 @@ int mmc_select_drive_strength(struct mmc_card *card, unsigned int max_dtr,
 	 * information and let the hardware specific code
 	 * return what is possible given the options
 	 */
-	return host->ops->select_drive_strength(card, max_dtr,
-						host_drv_type,
-						card_drv_type,
-						drv_type);
+	if (host->ops->select_drive_strength)
+		return host->ops->select_drive_strength(card, max_dtr,
+							host_drv_type,
+							card_drv_type,
+							drv_type);
+	else
+		return mmc_select_fixed_drive_strength(card, max_dtr,
+							host_drv_type,
+							card_drv_type,
+							drv_type);
 }
 
 /*
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index ad88deb2e8f3b0..cac61c71334310 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -184,7 +184,7 @@ static void mmc_retune_timer(unsigned long data)
 int mmc_of_parse(struct mmc_host *host)
 {
 	struct device *dev = host->parent;
-	u32 bus_width;
+	u32 bus_width, drv_type = 0;
 	int ret;
 	bool cd_cap_invert, cd_gpio_invert = false;
 	bool ro_cap_invert, ro_gpio_invert = false;
@@ -326,6 +326,15 @@ int mmc_of_parse(struct mmc_host *host)
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
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index f3f2d07feb2a62..1fef9b55a65805 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -350,6 +350,8 @@ struct mmc_host {
 #define MMC_CAP2_CQE		(1 << 23)	/* Has eMMC command queue engine */
 #define MMC_CAP2_CQE_DCMD	(1 << 24)	/* CQE can issue a direct command */
 
+	int			fixed_drv_type;	/* fixed driver type for non-removable media */
+
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
 	/* host specific block data */
-- 
2.11.0

