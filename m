From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH v3 2/3] mmc: sdhci-of-at91: implement specific set_clock function
Date: Thu, 7 Apr 2016 11:13:09 +0200
Message-ID: <1460020390-503-3-git-send-email-ludovic.desroches@atmel.com>
References: <1460020390-503-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460020390-503-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-mmc@vger.kernel.org

Disabling the internal clock while configuring the SD card clock can
lead to internal clock stabilization issue and/or unexpected switch to
the base clock when using presets.
A quirk SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST was introduced to fix
these bugs. The cause was assumed to be a too long internal
re-synchronisation but it seems in some cases the delay (even if longer)
doesn't fix this bug. The safest workaround is to not disable/enable the
internal clock during the SD card clock configuration.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/sdhci-of-at91.c | 48 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 2703aa9..c1923c0 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/mmc/host.h>
@@ -37,8 +38,52 @@ struct sdhci_at91_priv {
 	struct clk *mainck;
 };
 
+static void sdhci_at91_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	u16 clk;
+	unsigned long timeout;
+
+	host->mmc->actual_clock = 0;
+
+	/*
+	 * There is no requirement to disable the internal clock before
+	 * changing the SD clock configuration. Moreover, disabling the
+	 * internal clock, changing the configuration and re-enabling the
+	 * internal clock causes some bugs. It can prevent to get the internal
+	 * clock stable flag ready and an unexpected switch to the base clock
+	 * when using presets.
+	 */
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk &= SDHCI_CLOCK_INT_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	if (clock == 0)
+		return;
+
+	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
+
+	clk |= SDHCI_CLOCK_INT_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	/* Wait max 20 ms */
+	timeout = 20;
+	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
+		& SDHCI_CLOCK_INT_STABLE)) {
+		if (timeout == 0) {
+			pr_err("%s: Internal clock never stabilised.\n",
+			       mmc_hostname(host->mmc));
+			return;
+		}
+		timeout--;
+		mdelay(1);
+	}
+
+	clk |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+}
+
 static const struct sdhci_ops sdhci_at91_sama5d2_ops = {
-	.set_clock		= sdhci_set_clock,
+	.set_clock		= sdhci_at91_set_clock,
 	.set_bus_width		= sdhci_set_bus_width,
 	.reset			= sdhci_reset,
 	.set_uhs_signaling	= sdhci_set_uhs_signaling,
@@ -46,7 +91,6 @@ static const struct sdhci_ops sdhci_at91_sama5d2_ops = {
 
 static const struct sdhci_pltfm_data soc_data_sama5d2 = {
 	.ops = &sdhci_at91_sama5d2_ops,
-	.quirks2 = SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST,
 };
 
 static const struct of_device_id sdhci_at91_dt_match[] = {
-- 
2.5.0
