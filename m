From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] mmc: sdhci-esdhc-imx: Allow the usage of mmc aliases
Date: Sun, 22 Sep 2013 23:38:17 -0300
Message-ID: <1379903897-16019-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f47.google.com ([209.85.213.47]:47800 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252Ab3IWCib (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Sep 2013 22:38:31 -0400
Received: by mail-yh0-f47.google.com with SMTP id l109so1113957yhq.6
        for <linux-mmc@vger.kernel.org>; Sun, 22 Sep 2013 19:38:30 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: dirk.behme@gmail.com, kernel@pengutronix.de, shawn.guo@linaro.org, linux-mmc@vger.kernel.org, swarren@wwwdotorg.org, arnd@arndb.de, devicetree-discuss@lists.ozlabs.org, Fabio Estevam <fabio.estevam@freescale.com>, Dirk Behme <dirk.behme@de.bosch.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

On embedded devices, there is often a combination of removable mmc
devices (e.g. MMC/SD cards) and hard wired ones (e.g. eMMC).
Depending on the hardware configuration, the 'mmcblkN' node might
change if the removable device is available or not at boot time.

E.g. if the removable device is attached at boot time, it might
become mmxblk0. And the hard wired one mmcblk1. But if the removable
device isn't there at boot time, the hard wired one will become
mmcblk0. This makes it somehow difficult to hard code the root device
to the non-removable device and boot fast.

Allow the sdhci-esdhc-imx driver to retrieve the mmc aliases, so that we can 
map via the device tree which mmcblk corresponds to the rootfs.

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/card/block.c           |  5 +++--
 drivers/mmc/host/sdhci-esdhc-imx.c | 10 +++++++++-
 include/linux/mmc/host.h           |  2 ++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 1a3163f..94f842b 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2026,7 +2026,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	struct mmc_blk_data *md;
 	int devidx, ret;
 
-	devidx = find_first_zero_bit(dev_use, max_devices);
+	devidx = find_next_zero_bit(dev_use, max_devices, card->host->devidx);
 	if (devidx >= max_devices)
 		return ERR_PTR(-ENOSPC);
 	__set_bit(devidx, dev_use);
@@ -2044,7 +2044,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	 * index anymore so we keep track of a name index.
 	 */
 	if (!subname) {
-		md->name_idx = find_first_zero_bit(name_use, max_devices);
+		md->name_idx = find_next_zero_bit(name_use, max_devices,
+						  card->host->devidx);
 		__set_bit(md->name_idx, name_use);
 	} else
 		md->name_idx = ((struct mmc_blk_data *)
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index abc8cf0..e11a6af 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -524,8 +524,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_host *host;
 	struct esdhc_platform_data *boarddata;
-	int err;
+	int err, ret;
 	struct pltfm_imx_data *imx_data;
+	struct device_node *np = pdev->dev.of_node;
 
 	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_imx_pdata, 0);
 	if (IS_ERR(host))
@@ -602,6 +603,13 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 					host->mmc->parent->platform_data);
 	}
 
+
+	if (np) {
+		ret = of_alias_get_id(np, "mmcblk");
+		if (ret >= 0)
+			host->mmc->devidx = ret;
+	}
+
 	/* write_protect */
 	if (boarddata->wp_type == ESDHC_WP_GPIO) {
 		err = mmc_gpio_request_ro(host->mmc, boarddata->wp_gpio);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 3b0c33a..8209f72 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -362,6 +362,8 @@ struct mmc_host {
 
 	unsigned int		slotno;	/* used for sdio acpi binding */
 
+	/* preferred mmc block device index (mmcblkX) */
+	unsigned int		devidx;
 	unsigned long		private[0] ____cacheline_aligned;
 };
 
-- 
1.8.1.2

