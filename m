From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 3/3] mmc: sunxi: Re-enable eMMC HS-DDR modes on Allwinner A80
Date: Sun, 29 May 2016 15:04:44 +0800
Message-ID: <1464505484-3661-4-git-send-email-wens@csie.org>
References: <1464505484-3661-1-git-send-email-wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464505484-3661-1-git-send-email-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Now the the HS-DDR mode clock timings have been corrected, we can
re-enable these modes on the A80.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mmc/host/sunxi-mmc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 5873dc344ab2..2ee4c21ec55e 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1129,11 +1129,6 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 				  MMC_CAP_1_8V_DDR |
 				  MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
 
-	/* TODO MMC DDR is not working on A80 */
-	if (of_device_is_compatible(pdev->dev.of_node,
-				    "allwinner,sun9i-a80-mmc"))
-		mmc->caps &= ~MMC_CAP_1_8V_DDR;
-
 	ret = mmc_of_parse(mmc);
 	if (ret)
 		goto error_free_dma;
-- 
2.8.1
