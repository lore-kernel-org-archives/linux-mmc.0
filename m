From: Heiko Schocher <hs@denx.de>
Subject: [PATCH] mmc: omap_hsmmc: fix initialization order of mmc block devices
Date: Tue, 13 Oct 2015 07:29:53 +0200
Message-ID: <1444714193-24816-1-git-send-email-hs@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Heiko Schocher <hs@denx.de>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, Dirk Behme <dirk.behme@bosch.com>, Georg.Soffel@bosch-si.com, linux-omap@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On embedded devices, often there is a combination of
removable mmc devices (e.g. MMC/SD cards) and hard
wired ones (e.g. eMMC). Depending on the hardware
configuration, the 'mmcblkN' node might change if
the removable device is available or not at boot time.

E.g. if the removable device is attached at boot time,
it might become mmxblk0. And the hard wired one mmcblk1.
But if the removable device isn't there at boot time,
the hard wired one will become mmcblk0. This makes it
somehow difficult to hard code the root device to the
non-removable device and boot fast.

Signed-off-by: Heiko Schocher <hs@denx.de>
---
Dirk Behme tried to bring this in, last mail I found:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-July/111022.html
where Dirk worked in Arnds suggestion to use the
"/aliases" device node"

I adapt this to the omap_hsmmc driver.

Is there another solution for this problem?
Or why was this patch not accepted to mainline?

 drivers/mmc/card/block.c      | 6 ++++--
 drivers/mmc/host/omap_hsmmc.c | 6 ++++++
 include/linux/mmc/host.h      | 3 +++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c742cfd..62250d8 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2106,7 +2106,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	struct mmc_blk_data *md;
 	int devidx, ret;
 
-	devidx = find_first_zero_bit(dev_use, max_devices);
+	devidx = find_next_zero_bit(dev_use, max_devices,
+				    card->host->devidx);
 	if (devidx >= max_devices)
 		return ERR_PTR(-ENOSPC);
 	__set_bit(devidx, dev_use);
@@ -2124,7 +2125,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	 * index anymore so we keep track of a name index.
 	 */
 	if (!subname) {
-		md->name_idx = find_first_zero_bit(name_use, max_devices);
+		md->name_idx = find_next_zero_bit(name_use, max_devices,
+						  card->host->devidx);
 		__set_bit(md->name_idx, name_use);
 	} else
 		md->name_idx = ((struct mmc_blk_data *)
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 7fb0753..0b45b48 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2059,6 +2059,12 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->pbias_enabled = 0;
 	host->vqmmc_enabled = 0;
 
+	if (pdev->dev.of_node) {
+		ret = of_alias_get_id(pdev->dev.of_node, "mmcblk");
+		if (ret >= 0)
+			host->mmc->devidx = ret;
+	}
+
 	ret = omap_hsmmc_gpio_init(mmc, host, pdata);
 	if (ret)
 		goto err_gpio;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 83b81fd..4f071681 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -382,6 +382,9 @@ struct mmc_host {
 	int			dsr_req;	/* DSR value is valid */
 	u32			dsr;	/* optional driver stage (DSR) value */
 
+	/* preferred mmc block device index (mmcblkX) */
+	unsigned int		devidx;
+
 	unsigned long		private[0] ____cacheline_aligned;
 };
 
-- 
2.1.0
