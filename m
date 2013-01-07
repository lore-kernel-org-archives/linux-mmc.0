From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] mmc: sdhci: introduce sdhci_update_clock helper to re-enable clock
Date: Mon,  7 Jan 2013 16:31:08 +0200
Message-ID: <1357569068-9563-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:62960 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753699Ab3AGObW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 7 Jan 2013 09:31:22 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There are three places where same piece of code is used. Let's split it to a
separate function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci.c |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6f0bfc0..7c4a694 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1189,6 +1189,15 @@ out:
 	host->clock = clock;
 }
 
+static inline void sdhci_update_clock(struct sdhci_host *host)
+{
+	unsigned int clock;
+
+	clock = host->clock;
+	host->clock = 0;
+	sdhci_set_clock(host, clock);
+}
+
 static int sdhci_set_power(struct sdhci_host *host, unsigned short power)
 {
 	u8 pwr = 0;
@@ -1415,7 +1424,6 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 
 	if (host->version >= SDHCI_SPEC_300) {
 		u16 clk, ctrl_2;
-		unsigned int clock;
 
 		/* In case of UHS-I modes, set High Speed Enable */
 		if ((ios->timing == MMC_TIMING_MMC_HS200) ||
@@ -1455,9 +1463,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 
 			/* Re-enable SD Clock */
-			clock = host->clock;
-			host->clock = 0;
-			sdhci_set_clock(host, clock);
+			sdhci_update_clock(host);
 		}
 
 
@@ -1488,9 +1494,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		}
 
 		/* Re-enable SD Clock */
-		clock = host->clock;
-		host->clock = 0;
-		sdhci_set_clock(host, clock);
+		sdhci_update_clock(host);
 	} else
 		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 
@@ -2080,14 +2084,9 @@ static void sdhci_tasklet_finish(unsigned long param)
 		   (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST))) {
 
 		/* Some controllers need this kick or reset won't work here */
-		if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET) {
-			unsigned int clock;
-
+		if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
 			/* This is to force an update */
-			clock = host->clock;
-			host->clock = 0;
-			sdhci_set_clock(host, clock);
-		}
+			sdhci_update_clock(host);
 
 		/* Spec says we should do both at the same time, but Ricoh
 		   controllers do not like that. */
-- 
1.7.10.4

