From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 1/7] mmc: sdhci-pxav3: Fix SDR50 and DDR50 capabilities for the Armada 38x flavor
Date: Fri, 23 Jan 2015 11:56:28 +0100
Message-ID: <1422010594-1735-2-git-send-email-gregory.clement@free-electrons.com>
References: <1422010594-1735-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422010594-1735-1-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

According to erratum 'FE-2946959' both SDR50 and DDR50 modes require
specific clock adjustments in SDIO3 Configuration register. However,
this register was not part of the device tree binding. Even if the
binding can (and will) be extended we still need handling the case
where this register was not available. In this case we use the
SDHCI_QUIRK_MISSING_CAPS quirk remove them from the capabilities.

This commit is based on the work done by Marcin Wojtas<mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>

Fixes: 5491ce3f79ee ("mmc: sdhci-pxav3: add support for the Armada 38x SDHCI controller")
Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v3.15+
Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Signed-off-by: Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
---
 drivers/mmc/host/sdhci-pxav3.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index ca3424e7ef71..7b07325b4fba 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -118,6 +118,20 @@ static int mv_conf_mbus_windows(struct platform_device *pdev,
 	return 0;
 }
 
+static int armada_38x_quirks(struct sdhci_host *host)
+{
+	host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
+	/*
+	 * According to erratum 'FE-2946959' both SDR50 and DDR50
+	 * modes require specific clock adjustments in SDIO3
+	 * Configuration register, if the adjustment is not done,
+	 * remove them from the capabilities.
+	 */
+	host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
+	host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50);
+	return 0;
+}
+
 static void pxav3_reset(struct sdhci_host *host, u8 mask)
 {
 	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
@@ -319,6 +333,9 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 		clk_prepare_enable(pxa->clk_core);
 
 	if (of_device_is_compatible(np, "marvell,armada-380-sdhci")) {
+		ret = armada_38x_quirks(host);
+		if (ret < 0)
+			goto err_quirks;
 		ret = mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
 		if (ret < 0)
 			goto err_mbus_win;
@@ -400,6 +417,7 @@ err_mbus_win:
 	if (!IS_ERR(pxa->clk_core))
 		clk_disable_unprepare(pxa->clk_core);
 err_clk_get:
+err_quirks:
 	sdhci_pltfm_free(pdev);
 	return ret;
 }
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
