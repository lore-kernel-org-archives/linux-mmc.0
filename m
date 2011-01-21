From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci-pxa: add support for reset_exit callback
Date: Fri, 21 Jan 2011 11:34:09 -0800
Message-ID: <BB630095-F20E-4F3D-92B4-09488A831562@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:49233 "HELO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754900Ab1AUTgD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Jan 2011 14:36:03 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


Controller resets private registers to default values when
RESET_ALL occurs.  The callback allows us to restore the values.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci-pxa.c |   66 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 52ed5a9..2a6b156 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -29,6 +29,21 @@
 
 #define DRIVER_NAME	"sdhci-pxa"
 
+#define SD_CFG_FIFO_PARAM       0x100
+#define SDCFG_GEN_PAD_CLK_ON	(1<<6)
+
+#define SD_CLOCK_AND_BURST_SIZE_SETUP   0x10A
+#define SDCLK_DELAY_MASK     0x1F
+#define SDCLK_SEL_MASK       0x1
+#define SDCLK_DELAY_SHIFT    9
+#define SDCLK_SEL_SHIFT      8
+
+#define SD_CE_ATA_2          0x10E
+#define SDCE_MISC_INT		(1<<2)
+#define SDCE_MISC_INT_EN	(1<<1)
+
+#define DISABLE_CLOCK_GATING 0
+
 struct sdhci_pxa {
 	struct sdhci_host		*host;
 	struct sdhci_pxa_platdata	*pdata;
@@ -74,9 +89,59 @@ static unsigned int set_signaling_voltage(struct sdhci_host *host,
 	return 0;
 }
 
+
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
+static void programFIFO(struct sdhci_host *host, int enable)
+{
+	unsigned short tmp;
+
+	tmp = readw(host->ioaddr + SDHCI_HOST_CONTROL_2);
+
+	if (enable)
+		tmp |= SDCTRL_2_ASYNC_INT_EN;
+	else
+		tmp &= ~SDCTRL_2_ASYNC_INT_EN;
+
+	writew(tmp, host->ioaddr + SDHCI_HOST_CONTROL_2);
+}
+
+static void platform_reset_exit(struct sdhci_host *host, u8 mask)
+{
+	if (mask == SDHCI_RESET_ALL) {
+		programFIFO(host, DISABLE_CLOCK_GATING);
+		set_clock_and_burst_size(host);
+	}
+}
+
 static struct sdhci_ops sdhci_pxa_ops = {
 	.get_f_max_clock = NULL,
 	.set_signaling_voltage = set_signaling_voltage,
+	.platform_reset_exit = platform_reset_exit,
 };
 
 /*****************************************************************************\
@@ -215,6 +280,7 @@ static int __devexit sdhci_pxa_remove(struct platform_device *pdev)
 	return 0;
 }
 
+
 #ifdef CONFIG_PM
 static int sdhci_pxa_suspend(struct platform_device *dev, pm_message_t state)
 {
-- 
1.7.0.4


