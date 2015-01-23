From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v3 1/7] mmc: sdhci-pxav3: Fix SDR50 and DDR50 capabilities for the Armada 38x flavor
Date: Fri, 23 Jan 2015 17:46:21 +0100
Message-ID: <1422031587-18212-2-git-send-email-gregory.clement@free-electrons.com>
References: <1422031587-18212-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1422031587-18212-1-git-send-email-gregory.clement@free-electrons.com>
Sender: stable-owner@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, stable@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>
List-Id: linux-mmc@vger.kernel.org

According to erratum 'FE-2946959' both SDR50 and DDR50 modes require
specific clock adjustments in SDIO3 Configuration register. However,
this register was not part of the device tree binding. Even if the
binding can (and will) be extended we still need handling the case
where this register was not available. In this case we use the
SDHCI_QUIRK_MISSING_CAPS quirk remove them from the capabilities.

This commit is based on the work done by Marcin Wojtas<mw@semihalf.com>

Fixes: 5491ce3f79ee ("mmc: sdhci-pxav3: add support for the Armada 38x SDHCI controller")
Cc: <stable@vger.kernel.org> # v3.15+
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Marcin Wojtas <mw@semihalf.com>
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
