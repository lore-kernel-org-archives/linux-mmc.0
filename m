From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 4/9] sdhci: sdhci-esdhc-imx: support real clock on and off for imx6q
Date: Fri, 13 Sep 2013 19:11:33 +0800
Message-ID: <1379070698-7344-5-git-send-email-b29396@freescale.com>
References: <1379070698-7344-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [216.32.180.12] ([216.32.180.12]:39294 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751418Ab3IMLVP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Sep 2013 07:21:15 -0400
In-Reply-To: <1379070698-7344-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, anton@enomsg.org, s.hauer@pengutronix.de, w.sang@pengutronix.de, ulf.hansson@linaro.org, neko@bakuhatsu.net, b29396@freescale.com

The signal voltage switch flow requires to shutdown and output
clock in a specific sequence according to standard host controller
v3.0 spec. In that timing, the card must really receive clock or not.

However, for i.MX6Q, the uSDHC will not output clock even the clock
is enabled until there is command or data in transfer on the bus,
which will then cause singal voltage switch always to fail.

For i.MX6Q, we clear ESDHC_VENDOR_SPEC_FRC_SDCLK_ON bit to let
controller to gate off clock automatically and set that bit
to force clock output if clock is on.

This is required by SD3.0 support.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 67eaec9..37fafd7 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -34,6 +34,7 @@
 /* VENDOR SPEC register */
 #define ESDHC_VENDOR_SPEC		0xc0
 #define  ESDHC_VENDOR_SPEC_SDIO_QUIRK	(1 << 1)
+#define  ESDHC_VENDOR_SPEC_FRC_SDCLK_ON	(1 << 8)
 #define ESDHC_WTMK_LVL			0x44
 #define ESDHC_MIX_CTRL			0x48
 #define  ESDHC_MIX_CTRL_AC23EN		(1 << 7)
@@ -409,13 +410,20 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 					 unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = pltfm_host->priv;
 	unsigned int host_clock = clk_get_rate(pltfm_host->clk);
 	int pre_div = 2;
 	int div = 1;
-	u32 temp;
+	u32 temp, val;
 
-	if (clock == 0)
+	if (clock == 0) {
+		if (is_imx6q_usdhc(imx_data)) {
+			val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
+			writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
+					host->ioaddr + ESDHC_VENDOR_SPEC);
+		}
 		goto out;
+	}
 
 	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
 	temp &= ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
@@ -439,6 +447,13 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 		| (div << ESDHC_DIVIDER_SHIFT)
 		| (pre_div << ESDHC_PREDIV_SHIFT));
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
+
+	if (is_imx6q_usdhc(imx_data)) {
+		val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
+		writel(val | ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
+		host->ioaddr + ESDHC_VENDOR_SPEC);
+	}
+
 	mdelay(1);
 out:
 	host->clock = clock;
-- 
1.7.1


