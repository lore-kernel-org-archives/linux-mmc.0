From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH V3 5/6] mmc: sdhci: calculate timeout_clk conditionally in sdhci_add_host
Date: Wed, 27 Aug 2014 15:26:31 +0800
Message-ID: <1409124392-28899-6-git-send-email-b29396@freescale.com>
References: <1409124392-28899-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2lp0243.outbound.protection.outlook.com ([207.46.163.243]:57248
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754008AbaH0HqF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Aug 2014 03:46:05 -0400
In-Reply-To: <1409124392-28899-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, b29396@freescale.com, linux-arm-kernel@lists.infradead.org

The timeout_clk calculation code in sdhci_add_host is meaningless for
SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK.
So only execute them with no SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK set.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 881a7a0..0253eb1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2931,27 +2931,27 @@ int sdhci_add_host(struct sdhci_host *host)
 	} else
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
 
-	host->timeout_clk =
-		(caps[0] & SDHCI_TIMEOUT_CLK_MASK) >> SDHCI_TIMEOUT_CLK_SHIFT;
-	if (host->timeout_clk == 0) {
-		if (host->ops->get_timeout_clock) {
-			host->timeout_clk = host->ops->get_timeout_clock(host);
-		} else if (!(host->quirks &
-				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
-			pr_err("%s: Hardware doesn't specify timeout clock "
-			       "frequency.\n", mmc_hostname(mmc));
-			return -ENODEV;
+	if (!(host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
+		host->timeout_clk = (caps[0] & SDHCI_TIMEOUT_CLK_MASK) >>
+					SDHCI_TIMEOUT_CLK_SHIFT;
+		if (host->timeout_clk == 0) {
+			if (host->ops->get_timeout_clock) {
+				host->timeout_clk =
+					host->ops->get_timeout_clock(host);
+			} else {
+				pr_err("%s: Hardware doesn't specify timeout clock frequency.\n",
+					mmc_hostname(mmc));
+				return -ENODEV;
+			}
 		}
-	}
-	if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT)
-		host->timeout_clk *= 1000;
 
-	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
-		host->timeout_clk = mmc->f_max / 1000;
+		if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT)
+			host->timeout_clk *= 1000;
 
-	mmc->max_busy_timeout = host->ops->get_max_timeout_count ?
+		mmc->max_busy_timeout = host->ops->get_max_timeout_count ?
 			host->ops->get_max_timeout_count(host) : 1 << 27;
-	mmc->max_busy_timeout /= host->timeout_clk;
+		mmc->max_busy_timeout /= host->timeout_clk;
+	}
 
 	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
 	mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
-- 
1.7.8

