From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH V3 6/6] mmc: sdhci: move timeout_clk dynamically calculation code into common code
Date: Wed, 27 Aug 2014 15:26:32 +0800
Message-ID: <1409124392-28899-7-git-send-email-b29396@freescale.com>
References: <1409124392-28899-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2lp0205.outbound.protection.outlook.com ([207.46.163.205]:42886
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754213AbaH0HqN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Aug 2014 03:46:13 -0400
In-Reply-To: <1409124392-28899-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, b29396@freescale.com, linux-arm-kernel@lists.infradead.org

The timeout_clk calculation code for SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK case
is common and could be moved into common sdhci_do_set_ios, then platform code
which is not using sdhci_set_clock does not need to write the same code again.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0253eb1..f6a683b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1201,18 +1201,8 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 
 clock_set:
-	if (real_div) {
+	if (real_div)
 		host->mmc->actual_clock = (host->max_clk * clk_mul) / real_div;
-		if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK) {
-			host->timeout_clk = host->mmc->actual_clock / 1000;
-			mmc->max_busy_timeout =
-					host->ops->get_max_timeout_count ?
-					host->ops->get_max_timeout_count(host) :
-					1 << 27;
-			mmc->max_busy_timeout /= host->timeout_clk;
-		}
-	}
-
 	clk |= (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
 	clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
 		<< SDHCI_DIVIDER_HI_SHIFT;
@@ -1489,6 +1479,18 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 	if (!ios->clock || ios->clock != host->clock) {
 		host->ops->set_clock(host, ios->clock);
 		host->clock = ios->clock;
+
+		if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK &&
+		    host->clock) {
+			host->timeout_clk = host->mmc->actual_clock ?
+						host->mmc->actual_clock / 1000 :
+						host->clock / 1000;
+			host->mmc->max_busy_timeout =
+				host->ops->get_max_timeout_count ?
+				host->ops->get_max_timeout_count(host) :
+				1 << 27;
+			host->mmc->max_busy_timeout /= host->timeout_clk;
+		}
 	}
 
 	sdhci_set_power(host, ios->power_mode, ios->vdd);
-- 
1.7.8

