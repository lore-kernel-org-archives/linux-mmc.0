From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] mmc: mxs-mmc: Check the return value from stmp_reset_block()
Date: Wed,  3 Jul 2013 17:02:38 -0300
Message-ID: <1372881758-23502-2-git-send-email-festevam@gmail.com>
References: <1372881758-23502-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gg0-f169.google.com ([209.85.161.169]:57812 "EHLO
	mail-gg0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932690Ab3GCUJb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Jul 2013 16:09:31 -0400
Received: by mail-gg0-f169.google.com with SMTP id b1so160244ggn.0
        for <linux-mmc@vger.kernel.org>; Wed, 03 Jul 2013 13:09:31 -0700 (PDT)
In-Reply-To: <1372881758-23502-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: shawn.guo@linaro.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

stmp_reset_block() may fail, so let's check its return value and propagate it in
the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/host/mxs-mmc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index b76778f..383830d 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -102,12 +102,15 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
 		  BM_SSP_STATUS_CARD_DETECT) ^ host->cd_inverted;
 }
 
-static void mxs_mmc_reset(struct mxs_mmc_host *host)
+static int mxs_mmc_reset(struct mxs_mmc_host *host)
 {
 	struct mxs_ssp *ssp = &host->ssp;
 	u32 ctrl0, ctrl1;
-
-	stmp_reset_block(ssp->base);
+	int ret;
+
+	ret = stmp_reset_block(ssp->base);
+	if (ret)
+		return ret;
 
 	ctrl0 = BM_SSP_CTRL0_IGNORE_CRC;
 	ctrl1 = BF_SSP(0x3, CTRL1_SSP_MODE) |
@@ -132,6 +135,7 @@ static void mxs_mmc_reset(struct mxs_mmc_host *host)
 
 	writel(ctrl0, ssp->base + HW_SSP_CTRL0);
 	writel(ctrl1, ssp->base + HW_SSP_CTRL1(ssp));
+	return 0;
 }
 
 static void mxs_mmc_start_cmd(struct mxs_mmc_host *host,
@@ -625,7 +629,11 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	}
 	clk_prepare_enable(ssp->clk);
 
-	mxs_mmc_reset(host);
+	ret = mxs_mmc_reset(host);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to reset mmc: %d\n", ret);
+		goto out_clk_disable;
+	}
 
 	ssp->dmach = dma_request_slave_channel(&pdev->dev, "rx-tx");
 	if (!ssp->dmach) {
-- 
1.8.1.2

