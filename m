From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 2/2] sdhci: sdhci-pxa.c: Add post reset processing for chip
 specific registers
Date: Sun, 13 Feb 2011 23:09:22 -0800
Message-ID: <B0A1EFE1-AD9A-4418-ADE9-D0F3723D058B@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:47446 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751861Ab1BNHL3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:11:29 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


RESET_ALL resets chips private registers.
Reset to values specified in board file.

depends on board specific mach-mmp/plat-pxa sdhci.h definitions

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci-pxa.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 215517f..0e64d66 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -29,6 +29,13 @@
 
 #define DRIVER_NAME	"sdhci-pxa"
 
+#define SD_CLOCK_AND_BURST_SIZE_SETUP   0x10A
+#define SDCLK_DELAY_MASK     0x1F
+#define SDCLK_SEL_MASK       0x1
+#define SDCLK_DELAY_SHIFT    9
+#define SDCLK_SEL_SHIFT      8
+
+
 struct sdhci_pxa {
 	struct sdhci_host		*host;
 	struct sdhci_pxa_platdata	*pdata;
@@ -53,7 +60,42 @@ static void enable_clock(struct sdhci_host *host)
 	}
 }
 
+static void set_clock_and_burst_size(struct sdhci_host *host)
+{
+	u16 tmp;
+	struct sdhci_pxa *pxa = sdhci_priv(host);
+
+	pr_debug("%s:%s: adjust = %d\n",
+		__func__, mmc_hostname(host->mmc), pxa->pdata->adjust_clocks);
+
+	if (pxa->pdata->adjust_clocks) {
+		tmp = readw(host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
+		pr_debug("%s:%s: (B) SD_CLOCK_AND_BURST = %04X, "
+			"delay = %d, sel = %d\n",
+			__func__, mmc_hostname(host->mmc), tmp,
+			pxa->pdata->clk_delay, pxa->pdata->clk_select);
+		tmp &= ~(SDCLK_DELAY_MASK << SDCLK_DELAY_SHIFT);
+		tmp &= ~(SDCLK_SEL_MASK << SDCLK_SEL_SHIFT);
+		tmp |= (pxa->pdata->clk_delay & SDCLK_DELAY_MASK) <<
+			SDCLK_DELAY_SHIFT;
+		tmp |= (pxa->pdata->clk_select & SDCLK_SEL_MASK) <<
+			SDCLK_SEL_SHIFT;
+		writew(tmp, host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
+		pr_debug("%s:%s: (A) SD_CLOCK_AND_BURST_SIZE_SETUP = %04X\n",
+			__func__, mmc_hostname(host->mmc), tmp);
+	}
+}
+
+static void platform_reset_exit(struct sdhci_host *host, u8 mask)
+{
+	if (mask == SDHCI_RESET_ALL) {
+		/* reset private registers */
+		set_clock_and_burst_size(host);
+	}
+}
+
 static struct sdhci_ops sdhci_pxa_ops = {
+	.platform_reset_exit = platform_reset_exit,
 };
 
 /*****************************************************************************\
-- 
1.7.0.4


