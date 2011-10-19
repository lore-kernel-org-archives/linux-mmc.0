From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: [PATCH] sdhci: expose the SDCLK frq in sys ios
Date: Wed, 19 Oct 2011 15:45:45 +0200
Message-ID: <1319031945-2630-1-git-send-email-peppe.cavallaro@st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:54231 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751999Ab1JSNqC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Oct 2011 09:46:02 -0400
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EACA8292
	for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2011 13:45:59 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7486A2246
	for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2011 13:45:59 +0000 (GMT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>

This patch is to expose the SDCLK frequency in the ios /sys entry.

For example, if the max clk for a normal speed card is 20MHz
this will be reported in /sys/kernel/debug/mmc0/ios instead of
the real SDCLK frequency (calculated as Baseclock / divisor;
divisor used for programming the Clock Control Register).

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 drivers/mmc/host/sdhci.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0e02cc1..6bdf64f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1045,6 +1045,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	int div = 0; /* Initialized for compiler warning */
 	u16 clk = 0;
 	unsigned long timeout;
+	unsigned int new_hc_clock = host->max_clk;
 
 	if (clock == host->clock)
 		return;
@@ -1134,7 +1135,10 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
 out:
-	host->clock = clock;
+	if (div)
+		new_hc_clock = host->max_clk / div;
+
+	host->clock = new_hc_clock;
 }
 
 static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
@@ -1293,6 +1297,9 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	sdhci_set_clock(host, ios->clock);
 
+	/* Clock provided to the HC */
+	ios->clock = host->clock;
+
 	if (ios->power_mode == MMC_POWER_OFF)
 		sdhci_set_power(host, -1);
 	else
-- 
1.7.4.4

