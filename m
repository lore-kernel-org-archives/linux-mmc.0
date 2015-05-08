From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] mmc: sdhci-esdhc-imx: Do not break platform data boards
Date: Fri,  8 May 2015 02:56:09 -0300
Message-ID: <1431064569-5947-2-git-send-email-festevam@gmail.com>
References: <1431064569-5947-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f42.google.com ([209.85.213.42]:34979 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbbEHF7Z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2015 01:59:25 -0400
Received: by yhda23 with SMTP id a23so17003233yhd.2
        for <linux-mmc@vger.kernel.org>; Thu, 07 May 2015 22:59:25 -0700 (PDT)
In-Reply-To: <1431064569-5947-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: shawn.guo@linaro.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

The only user of this driver that has not been converted to fully
device tree is the i.MX35 SoC.

There is a i.MX35-based board (mach-pcm043.c) that uses platform data
to pass wp_gpio and cd_gpio information.

Commit 8d86e4fcccf61ba ("mmc: sdhci-esdhc-imx: Call mmc_of_parse()")
broke the platform data case by removing mmc_gpio_request_ro() and
mmc_gpio_request_cd(), so restore the functionality for the non-dt
case.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a9980d7..812c670 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -918,6 +918,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	struct esdhc_platform_data *boarddata;
 	int err;
 	struct pltfm_imx_data *imx_data;
+	bool dt = true;
 
 	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_imx_pdata, 0);
 	if (IS_ERR(host))
@@ -1005,11 +1006,44 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		}
 		imx_data->boarddata = *((struct esdhc_platform_data *)
 					host->mmc->parent->platform_data);
+		dt = false;
+	}
+	/* write_protect */
+	if (boarddata->wp_type == ESDHC_WP_GPIO && !dt) {
+		err = mmc_gpio_request_ro(host->mmc, boarddata->wp_gpio);
+		if (err) {
+			dev_err(mmc_dev(host->mmc),
+				"failed to request write-protect gpio!\n");
+			goto disable_clk;
+		}
+		host->mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
 	}
 
 	/* card_detect */
-	if (boarddata->cd_type == ESDHC_CD_CONTROLLER)
+	switch (boarddata->cd_type) {
+	case ESDHC_CD_GPIO:
+		if (dt)
+			break;
+		err = mmc_gpio_request_cd(host->mmc, boarddata->cd_gpio, 0);
+		if (err) {
+			dev_err(mmc_dev(host->mmc),
+				"failed to request card-detect gpio!\n");
+			goto disable_clk;
+		}
+		/* fall through */
+
+	case ESDHC_CD_CONTROLLER:
+		/* we have a working card_detect back */
 		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+		break;
+
+	case ESDHC_CD_PERMANENT:
+		host->mmc->caps |= MMC_CAP_NONREMOVABLE;
+		break;
+
+	case ESDHC_CD_NONE:
+		break;
+	}
 
 	switch (boarddata->max_bus_width) {
 	case 8:
-- 
1.9.1

