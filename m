From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 14/38] mmc: sdhci: clean up
 sdhci_update_clock()/sdhci_set_clock()
Date: Wed, 23 Apr 2014 20:07:21 +0100
Message-ID: <E1Wd2Vt-0003vE-Oo@rmk-PC.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46419 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751343AbaDWTH2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Apr 2014 15:07:28 -0400
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

Only one caller to sdhci_set_clock() needs to check whether the
requested clock frequency was the same as the currently set frequency,
yet we work around this in several other sites via sdhci_update_clock().
Rather than doing this, move those checks out into sdhci_do_set_ios(),
which then allows sdhci_update_clock() to be eliminated.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-cns3xxx.c |  3 ---
 drivers/mmc/host/sdhci.c         | 21 +++++----------------
 2 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-cns3xxx.c
index 87af66bb1ea8..fa11f63b78a0 100644
--- a/drivers/mmc/host/sdhci-cns3xxx.c
+++ b/drivers/mmc/host/sdhci-cns3xxx.c
@@ -30,9 +30,6 @@ static void sdhci_cns3xxx_set_clock(struct sdhci_host *host, unsigned int clock)
 	u16 clk;
 	unsigned long timeout;
 
-	if (clock == host->clock)
-		return;
-
 	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 
 	if (clock == 0)
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9efa7d878731..518ab1a5e608 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1119,9 +1119,6 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	u16 clk = 0;
 	unsigned long timeout;
 
-	if (clock && clock == host->clock)
-		return;
-
 	host->mmc->actual_clock = 0;
 
 	if (host->ops->set_clock) {
@@ -1228,15 +1225,6 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	host->clock = clock;
 }
 
-static inline void sdhci_update_clock(struct sdhci_host *host)
-{
-	unsigned int clock;
-
-	clock = host->clock;
-	host->clock = 0;
-	sdhci_set_clock(host, clock);
-}
-
 static int sdhci_set_power(struct sdhci_host *host, unsigned short power)
 {
 	u8 pwr = 0;
@@ -1453,7 +1441,8 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
 		sdhci_enable_preset_value(host, false);
 
-	sdhci_set_clock(host, ios->clock);
+	if (!ios->clock || ios->clock != host->clock)
+		sdhci_set_clock(host, ios->clock);
 
 	if (ios->power_mode == MMC_POWER_OFF)
 		vdd_bit = sdhci_set_power(host, -1);
@@ -1521,7 +1510,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 
 			/* Re-enable SD Clock */
-			sdhci_update_clock(host);
+			sdhci_set_clock(host, host->clock);
 		}
 
 
@@ -1565,7 +1554,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		}
 
 		/* Re-enable SD Clock */
-		sdhci_update_clock(host);
+		sdhci_set_clock(host, host->clock);
 	} else
 		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 
@@ -2136,7 +2125,7 @@ static void sdhci_tasklet_finish(unsigned long param)
 		/* Some controllers need this kick or reset won't work here */
 		if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
 			/* This is to force an update */
-			sdhci_update_clock(host);
+			sdhci_set_clock(host, host->clock);
 
 		/* Spec says we should do both at the same time, but Ricoh
 		   controllers do not like that. */
-- 
1.8.3.1

