From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 09/17] spi: pl022: Simplify clock handling
Date: Tue,  4 Feb 2014 16:58:50 +0100
Message-ID: <1391529538-21685-10-git-send-email-ulf.hansson@linaro.org>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391529538-21685-1-git-send-email-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Make use of clk_prepare_enable and clk_disable_unprepare to simplify
code. No functional change.

Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pl022.c |   15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 2bb238f..2f44c81 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2183,13 +2183,7 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
 		goto err_no_clk;
 	}
 
-	status = clk_prepare(pl022->clk);
-	if (status) {
-		dev_err(&adev->dev, "could not prepare SSP/SPI bus clock\n");
-		goto  err_clk_prep;
-	}
-
-	status = clk_enable(pl022->clk);
+	status = clk_prepare_enable(pl022->clk);
 	if (status) {
 		dev_err(&adev->dev, "could not enable SSP/SPI bus clock\n");
 		goto err_no_clk_en;
@@ -2250,10 +2244,8 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	if (platform_info->enable_dma)
 		pl022_dma_remove(pl022);
  err_no_irq:
-	clk_disable(pl022->clk);
+	clk_disable_unprepare(pl022->clk);
  err_no_clk_en:
-	clk_unprepare(pl022->clk);
- err_clk_prep:
  err_no_clk:
  err_no_ioremap:
 	amba_release_regions(adev);
@@ -2281,8 +2273,7 @@ pl022_remove(struct amba_device *adev)
 	if (pl022->master_info->enable_dma)
 		pl022_dma_remove(pl022);
 
-	clk_disable(pl022->clk);
-	clk_unprepare(pl022->clk);
+	clk_disable_unprepare(pl022->clk);
 	amba_release_regions(adev);
 	tasklet_disable(&pl022->pump_transfers);
 	return 0;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
