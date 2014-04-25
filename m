From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 24/32] mmc: sdhci: clean up sdhci_execute_tuning() decision
Date: Fri, 25 Apr 2014 14:26:43 +0100
Message-ID: <E1Wdg9L-00080P-6P@rmk-PC.arm.linux.org.uk>
References: <20140425132245.GO26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:50667 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753495AbaDYN0s (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Apr 2014 09:26:48 -0400
In-Reply-To: <20140425132245.GO26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Clean up the code in sdhci_execute_tuning() so the decision whether
to execute tuning is clearer - and despite this reflecting what the
original code was doing, it shows that it may not be what the author
actually intended.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 514a0b827620..e5e9f2139f77 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1817,21 +1817,16 @@ static int sdhci_card_busy(struct mmc_host *mmc)
 
 static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
-	struct sdhci_host *host;
+	struct sdhci_host *host = mmc_priv(mmc);
 	u16 ctrl;
 	int tuning_loop_counter = MAX_TUNING_LOOP;
 	unsigned long timeout;
 	int err = 0;
-	bool requires_tuning_nonuhs = false;
 	unsigned long flags;
 
-	host = mmc_priv(mmc);
-
 	sdhci_runtime_pm_get(host);
 	spin_lock_irqsave(&host->lock, flags);
 
-	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-
 	/*
 	 * The Host Controller needs tuning only in case of SDR104 mode
 	 * and for SDR50 mode when Use Tuning for SDR50 is set in the
@@ -1839,16 +1834,18 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 * If the Host Controller supports the HS200 mode then the
 	 * tuning function has to be executed.
 	 */
-	if (host->timing == MMC_TIMING_UHS_SDR50 &&
-	    (host->flags & SDHCI_SDR50_NEEDS_TUNING ||
-	     host->flags & SDHCI_SDR104_NEEDS_TUNING))
-		requires_tuning_nonuhs = true;
-
-	if (host->timing == MMC_TIMING_MMC_HS200 ||
-	    host->timing == MMC_TIMING_UHS_SDR104 ||
-	    requires_tuning_nonuhs)
-		ctrl |= SDHCI_CTRL_EXEC_TUNING;
-	else {
+	switch (host->timing) {
+	case MMC_TIMING_MMC_HS200:
+	case MMC_TIMING_UHS_SDR104:
+		break;
+
+	case MMC_TIMING_UHS_SDR50:
+		if (host->flags & SDHCI_SDR50_NEEDS_TUNING ||
+		    host->flags & SDHCI_SDR104_NEEDS_TUNING)
+			break;
+		/* FALLTHROUGH */
+
+	default:
 		spin_unlock_irqrestore(&host->lock, flags);
 		sdhci_runtime_pm_put(host);
 		return 0;
@@ -1861,6 +1858,8 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		return err;
 	}
 
+	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	ctrl |= SDHCI_CTRL_EXEC_TUNING;
 	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
 	/*
-- 
1.8.3.1

