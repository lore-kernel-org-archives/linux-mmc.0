From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v2 3/4] mmc: sdhci-of-arasan: fix incorrect timeout clock
Date: Mon, 27 Feb 2017 16:29:03 +0800
Message-ID: <1488184144-122285-4-git-send-email-shawn.lin@rock-chips.com>
References: <1488184144-122285-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:35258 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbdB0Id0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Feb 2017 03:33:26 -0500
In-Reply-To: <1488184144-122285-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>, Masahiro Yamada <yamada.masahiro@socionext.com>, Shawn Lin <shawn.lin@rock-chips.com>

From: Anssi Hannula <anssi.hannula@bitwise.fi>

sdhci-of-arasan actually could resue the callback of
sdhci_pltfm_clk_get_timeout_clock to return the timeout
clock rate properly. Otherwise it's the timeout clock
rate is incorrect according to what the sdhci core needs.

Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- fix the comment and make it return in Hz

 drivers/mmc/host/sdhci-of-arasan.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 410a55b..663467d 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -28,14 +28,8 @@
 #include "sdhci-pltfm.h"
 #include <linux/of.h>
 
-#define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
 #define SDHCI_ARASAN_VENDOR_REGISTER	0x78
-
 #define VENDOR_ENHANCED_STROBE		BIT(0)
-#define CLK_CTRL_TIMEOUT_SHIFT		16
-#define CLK_CTRL_TIMEOUT_MASK		(0xf << CLK_CTRL_TIMEOUT_SHIFT)
-#define CLK_CTRL_TIMEOUT_MIN_EXP	13
-
 #define PHY_CLK_TOO_SLOW_HZ		400000
 
 /*
@@ -161,21 +155,6 @@ static int sdhci_arasan_syscon_write(struct sdhci_host *host,
 	return ret;
 }
 
-static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
-{
-	u32 div;
-	unsigned long freq;
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-
-	div = readl(host->ioaddr + SDHCI_ARASAN_CLK_CTRL_OFFSET);
-	div = (div & CLK_CTRL_TIMEOUT_MASK) >> CLK_CTRL_TIMEOUT_SHIFT;
-
-	freq = clk_get_rate(pltfm_host->clk);
-	freq /= 1 << (CLK_CTRL_TIMEOUT_MIN_EXP + div);
-
-	return freq;
-}
-
 static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -290,7 +269,7 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
 static struct sdhci_ops sdhci_arasan_ops = {
 	.set_clock = sdhci_arasan_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
-	.get_timeout_clock = sdhci_arasan_get_timeout_clock,
+	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_arasan_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
-- 
1.9.1


