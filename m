From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 2/3] mmc: host: tmio: SDIO_STATUS_QUIRK is rather SDIO_STATUS_SETBITS
Date: Thu, 19 Jan 2017 21:07:17 +0100
Message-ID: <20170119200718.8115-3-wsa+renesas@sang-engineering.com>
References: <20170119200718.8115-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170119200718.8115-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

QUIRK sounds like there is something wrong, but actually there are just
some bits which need to be 1. Rename it to be more clear.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since RFC: make comments more precise

 drivers/mmc/host/sh_mobile_sdhi.c | 6 ++----
 drivers/mmc/host/tmio_mmc_pio.c   | 2 +-
 include/linux/mfd/tmio.h          | 6 ++----
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 0b86ccdf9866e7..f82a8a058c7b6d 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -682,10 +682,8 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	 */
 	mmc_data->flags |= TMIO_MMC_HAVE_CMD12_CTRL;
 
-	/*
-	 * All SDHI need SDIO_INFO1 reserved bit
-	 */
-	mmc_data->flags |= TMIO_MMC_SDIO_STATUS_QUIRK;
+	/* All SDHI have SDIO status bits which must be 1 */
+	mmc_data->flags |= TMIO_MMC_SDIO_STATUS_SETBITS;
 
 	ret = tmio_mmc_host_probe(host, mmc_data);
 	if (ret < 0)
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 6ab43892c132a9..f21e6a1b1a9206 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -770,7 +770,7 @@ static void __tmio_mmc_sdio_irq(struct tmio_mmc_host *host)
 	ireg = status & TMIO_SDIO_MASK_ALL & ~host->sdio_irq_mask;
 
 	sdio_status = status & ~TMIO_SDIO_MASK_ALL;
-	if (pdata->flags & TMIO_MMC_SDIO_STATUS_QUIRK)
+	if (pdata->flags & TMIO_MMC_SDIO_STATUS_SETBITS)
 		sdio_status |= 6;
 
 	sd_ctrl_write16(host, CTL_SDIO_STATUS, sdio_status);
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 0dbcb7e66a02ee..662fedc87a31cf 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -94,10 +94,8 @@
  */
 #define TMIO_MMC_HAVE_CMD12_CTRL	(1 << 7)
 
-/*
- * Some controllers needs to set 1 on SDIO status reserved bits
- */
-#define TMIO_MMC_SDIO_STATUS_QUIRK	(1 << 8)
+/* Controller has some SDIO status bits which must be 1 */
+#define TMIO_MMC_SDIO_STATUS_SETBITS	(1 << 8)
 
 /*
  * Some controllers have a 32-bit wide data port register
-- 
2.11.0
