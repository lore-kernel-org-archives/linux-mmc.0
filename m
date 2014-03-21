From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [PATCH] mmc: dw_mmc: Support setting the ciu-div on exynos
Date: Fri, 21 Mar 2014 17:32:07 +0530
Message-ID: <1395403327-19713-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:62797 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758075AbaCUMCj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Mar 2014 08:02:39 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: grundler@chromium.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jh80.chung@samsung.com, cjb@laptop.org, tgih.jun@samsung.com, linux-mmc@vger.kernel.org, sonnyrao@chromium.org, kgene.kim@samsung.com, joshi@samsung.com
Cc: t.figa@samsung.com, Doug Anderson <dianders@chromium.org>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

From: Doug Anderson <dianders@chromium.org>

The existing dw_mmc code for exynos5250/exynos5420 read the ciu-div
property from the device tree and used it in calculations, but didn't
actually ever set it in hardware.  That means that if the hardware
value set by the firmware didn't match what was in the device tree
that we'd be clocking things incorrectly.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 3423c5e..07392ac 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -28,6 +28,7 @@
 #define SDMMC_CLKSEL_CCLK_SAMPLE(x)	(((x) & 7) << 0)
 #define SDMMC_CLKSEL_CCLK_DRIVE(x)	(((x) & 7) << 16)
 #define SDMMC_CLKSEL_CCLK_DIVIDER(x)	(((x) & 7) << 24)
+#define SDMMC_CLKSEL_GET_SAMPLE(x)      (((x) >> 0) & 0x7)
 #define SDMMC_CLKSEL_GET_DRV_WD3(x)	(((x) >> 16) & 0x7)
 #define SDMMC_CLKSEL_TIMING(x, y, z)	(SDMMC_CLKSEL_CCLK_SAMPLE(x) |	\
 					SDMMC_CLKSEL_CCLK_DRIVE(y) |	\
@@ -118,6 +119,12 @@ static int dw_mci_exynos_setup_clock(struct dw_mci *host)
 {
 	struct dw_mci_exynos_priv_data *priv = host->priv;
 	unsigned long rate = clk_get_rate(host->ciu_clk);
+	u32 clksel = mci_readl(host, CLKSEL);
+
+	clksel = SDMMC_CLKSEL_TIMING(SDMMC_CLKSEL_GET_SAMPLE(clksel),
+				     SDMMC_CLKSEL_GET_DRV_WD3(clksel),
+				     priv->ciu_div);
+	mci_writel(host, CLKSEL, clksel);
 
 	host->bus_hz = rate / (priv->ciu_div + 1);
 	return 0;
-- 
1.7.10.4

