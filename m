From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 2/7] mmc: sdhci-pxav3: Fix Armada 38x controller's caps according to erratum ERR-7878951
Date: Fri, 23 Jan 2015 11:56:29 +0100
Message-ID: <1422010594-1735-3-git-send-email-gregory.clement@free-electrons.com>
References: <1422010594-1735-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422010594-1735-1-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

From: Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>

According to erratum 'ERR-7878951' Armada 38x SDHCI controller has
different capabilities than the ones shown in its registers:

- it doesn't support the voltage switching: it can work either with
  3.3V or 1.8V supply
- it doesn't support the SDR104 mode
- SDR50 mode doesn't need tuning

The SDHCI_QUIRK_MISSING_CAPS quirk is used for updating the
capabilities accordingly.

[gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org: port from 3.10]

Fixes: 5491ce3f79ee ("mmc: sdhci-pxav3: add support for the Armada 38x SDHCI controller")
Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v3.15+

Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/mmc/host/sdhci-pxav3.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 7b07325b4fba..a53968010991 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -118,8 +118,11 @@ static int mv_conf_mbus_windows(struct platform_device *pdev,
 	return 0;
 }
 
-static int armada_38x_quirks(struct sdhci_host *host)
+static int armada_38x_quirks(struct platform_device *pdev,
+			     struct sdhci_host *host)
 {
+	struct device_node *np = pdev->dev.of_node;
+
 	host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
 	/*
 	 * According to erratum 'FE-2946959' both SDR50 and DDR50
@@ -129,6 +132,20 @@ static int armada_38x_quirks(struct sdhci_host *host)
 	 */
 	host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
 	host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50);
+
+	/*
+	 * According to erratum 'ERR-7878951' Armada 38x SDHCI
+	 * controller has different capabilities than the ones shown
+	 * in its registers
+	 */
+	host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+	if (of_get_property(np, "no-1-8-v", NULL)) {
+		host->caps &= ~SDHCI_CAN_VDD_180;
+		host->mmc->caps &= ~MMC_CAP_1_8V_DDR;
+	} else
+		host->caps &= ~SDHCI_CAN_VDD_330;
+	host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_USE_SDR50_TUNING);
+
 	return 0;
 }
 
@@ -333,7 +350,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 		clk_prepare_enable(pxa->clk_core);
 
 	if (of_device_is_compatible(np, "marvell,armada-380-sdhci")) {
-		ret = armada_38x_quirks(host);
+		ret = armada_38x_quirks(pdev, host);
 		if (ret < 0)
 			goto err_quirks;
 		ret = mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
@@ -341,9 +358,6 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 			goto err_mbus_win;
 	}
 
-	/* enable 1/8V DDR capable */
-	host->mmc->caps |= MMC_CAP_1_8V_DDR;
-
 	match = of_match_device(of_match_ptr(sdhci_pxav3_of_match), &pdev->dev);
 	if (match) {
 		ret = mmc_of_parse(host->mmc);
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
