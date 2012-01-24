From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 04/11] mmc: sh_mobile_sdhi: pass card hotplug GPIO number to TMIO MMC
Date: Tue, 24 Jan 2012 13:01:33 +0100
Message-ID: <1327406500-7233-5-git-send-email-g.liakhovetski@gmx.de>
References: <1327406500-7233-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1327406500-7233-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

To use TMIO MMC driver ability to interface to the generic MMC GPIO card
hotplug detection helper, the SDHI driver has to pass the GPIO number
from its own platform data.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c  |    3 ++-
 include/linux/mmc/sh_mobile_sdhi.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 58da3c4..cb279b4 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -129,6 +129,7 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 			mmc_data->write16_hook = sh_mobile_sdhi_write16_hook;
 		mmc_data->ocr_mask = p->tmio_ocr_mask;
 		mmc_data->capabilities |= p->tmio_caps;
+		mmc_data->cd_gpio = p->cd_gpio;
 
 		if (p->dma_slave_tx > 0 && p->dma_slave_rx > 0) {
 			priv->param_tx.slave_id = p->dma_slave_tx;
@@ -211,7 +212,7 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "%s base at 0x%08lx clock rate %u MHz\n",
 		 mmc_hostname(host->mmc), (unsigned long)
-		 (platform_get_resource(pdev,IORESOURCE_MEM, 0)->start),
+		 (platform_get_resource(pdev, IORESOURCE_MEM, 0)->start),
 		 mmc_data->hclk / 1000000);
 
 	return ret;
diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
index 71b8054..082a736 100644
--- a/include/linux/mmc/sh_mobile_sdhi.h
+++ b/include/linux/mmc/sh_mobile_sdhi.h
@@ -16,6 +16,7 @@ struct sh_mobile_sdhi_info {
 	unsigned long tmio_flags;
 	unsigned long tmio_caps;
 	u32 tmio_ocr_mask;	/* available MMC voltages */
+	unsigned int cd_gpio;
 	struct tmio_mmc_data *pdata;
 	void (*set_pwr)(struct platform_device *pdev, int state);
 	int (*get_cd)(struct platform_device *pdev);
-- 
1.7.2.5

