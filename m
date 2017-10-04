From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 2/3] mmc: parse new binding for eMMC fixed driver type
Date: Wed,  4 Oct 2017 19:39:19 +0200
Message-ID: <20171004173920.15232-3-wsa+renesas@sang-engineering.com>
References: <20171004173920.15232-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171004173920.15232-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Adrian Hunter <adrian.hunter@intel.com>, Marek Vasut <marek.vasut@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

Parse the new binding and store it in the host struct after doing some
sanity checks. The code is designed to support fixed SD driver type if
we ever need that.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Changes since RFC v1:
* rebased to mmc/next based on 4.14-rc3

 drivers/mmc/core/core.c  | 28 +++++++++++++++++++++++-----
 drivers/mmc/core/host.c  | 11 ++++++++++-
 include/linux/mmc/host.h |  2 ++
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index c287d297710aa4..64b454efc924c5 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1785,6 +1785,18 @@ void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type)
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
@@ -1793,7 +1805,7 @@ int mmc_select_drive_strength(struct mmc_card *card, unsigned int max_dtr,
 
 	*drv_type = 0;
 
-	if (!host->ops->select_drive_strength)
+	if (!host->ops->select_drive_strength && !host->fixed_drv_type)
 		return 0;
 
 	/* Use SD definition of driver strength for hosts */
@@ -1812,10 +1824,16 @@ int mmc_select_drive_strength(struct mmc_card *card, unsigned int max_dtr,
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
index 1539ce0da19646..d69afb8762dd52 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -179,7 +179,7 @@ static void mmc_retune_timer(unsigned long data)
 int mmc_of_parse(struct mmc_host *host)
 {
 	struct device *dev = host->parent;
-	u32 bus_width;
+	u32 bus_width, drv_type = 0;
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
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 9109265fe52991..ce2075d6f429cf 100644
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
