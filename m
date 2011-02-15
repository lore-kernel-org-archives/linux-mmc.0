From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 11/12] mmc: sdhci: add support for programmable clock mode
Date: Tue, 15 Feb 2011 15:05:09 +0530
Message-ID: <1297762510-2696-12-git-send-email-arindam.nath@amd.com>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40842 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297Ab1BOJiZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Feb 2011 04:38:25 -0500
Received: by mail-iw0-f174.google.com with SMTP id 9so5732646iwn.19
        for <linux-mmc@vger.kernel.org>; Tue, 15 Feb 2011 01:38:25 -0800 (PST)
In-Reply-To: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com, Arindam Nath <arindam.nath@amd.com>

Host Controller v3.00 supports programmable clock mode as an optional
feature. The support for this mode is indicated by non-zero value in
bits 48-55 of the Capabilities register. If supported, the actual
value of Clock Multiplier is one more than the value provided in the
bit fields. We only set Clock Generator Select (bit 5) and SDCLK Frequency
Select (bits 8-15) of the Clock Control register in case Preset Value
Enable is not set, otherwise these fields are automatically set by the
Host Controller based on the UHS mode selected. Also, since the maximum
and minimum clock frequency in this mode can be (Base Clock * Clock Mul)
and (Base Clock * Clock Mul)/1024 respectively, f_max and f_min have been
recalculated to reflect this change.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/mmc/host/sdhci.c  |   77 +++++++++++++++++++++++++++++++++++++-------
 drivers/mmc/host/sdhci.h  |    3 ++
 include/linux/mmc/sdhci.h |    1 +
 3 files changed, 68 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 722f668..9f8fb84 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1036,7 +1036,7 @@ static void sdhci_finish_command(struct sdhci_host *host)
 
 static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
-	int div;
+	int div = 0; /* Initialized for compiler warning */
 	u16 clk;
 	unsigned long timeout;
 
@@ -1055,14 +1055,45 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 		goto out;
 
 	if (host->version >= SDHCI_SPEC_300) {
-		/* Version 3.00 divisors must be a multiple of 2. */
-		if (host->max_clk <= clock)
-			div = 1;
-		else {
-			for (div = 2; div < SDHCI_MAX_DIV_SPEC_300; div += 2) {
-				if ((host->max_clk / div) <= clock)
-					break;
+		/*
+		 * Check if the Host Controller supports Programmable Clock
+		 * Mode.
+		 */
+		if (host->clk_mul) {
+			u16 ctrl;
+
+			/*
+			 * We need to figure out whether the Host Driver needs
+			 * to select Programmable Clock Mode, or the value can
+			 * be set automatically by the Host Controller based on
+			 * the Preset Value registers.
+			 */
+			ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+			if (!(ctrl & SDHCI_CTRL_PRESET_VAL_ENABLE)) {
+				for (div = 1; div <= 1024; div++) {
+					if (((host->max_clk * host->clk_mul) /
+					      div) <= clock)
+						break;
+				}
+				/*
+				 * Set Programmable Clock Mode in the Clock
+				 * Control register.
+				 */
+				clk |= SDHCI_PROG_CLOCK_MODE;
+				div--;
 			}
+		} else {
+			/* Version 3.00 divisors must be a multiple of 2. */
+			if (host->max_clk <= clock)
+				div = 1;
+			else {
+				for (div = 2; div < SDHCI_MAX_DIV_SPEC_300;
+				     div += 2) {
+					if ((host->max_clk / div) <= clock)
+						break;
+				}
+			}
+			div >>= 1;
 		}
 	} else {
 		/* Version 2.00 divisors must be a power of 2. */
@@ -1070,8 +1101,8 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 			if ((host->max_clk / div) <= clock)
 				break;
 		}
+		div >>= 1;
 	}
-	div >>= 1;
 
 	clk = (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
 	clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
@@ -2255,17 +2286,37 @@ int sdhci_add_host(struct sdhci_host *host)
 		host->timeout_clk *= 1000;
 
 	/*
+	 * In case of Host Controller v3.00, find out whether clock
+	 * multiplier is supported.
+	 */
+	host->clk_mul = (caps[1] & SDHCI_CLOCK_MUL_MASK) >>
+			SDHCI_CLOCK_MUL_SHIFT;
+
+	/*
+	 * In case the value in Clock Multiplier is 0, then programmable
+	 * clock mode is not supported, otherwise the actual clock
+	 * multiplier is one more than the value of Clock Multiplier
+	 * in the Capabilities Register.
+	 */
+	if (host->clk_mul)
+		host->clk_mul += 1;
+
+	/*
 	 * Set host parameters.
 	 */
 	mmc->ops = &sdhci_ops;
+	mmc->f_max = host->max_clk;
 	if (host->ops->get_min_clock)
 		mmc->f_min = host->ops->get_min_clock(host);
-	else if (host->version >= SDHCI_SPEC_300)
-		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
-	else
+	else if (host->version >= SDHCI_SPEC_300) {
+		if (host->clk_mul) {
+			mmc->f_min = (host->max_clk * host->clk_mul) / 1024;
+			mmc->f_max = host->max_clk * host->clk_mul;
+		} else
+			mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
+	} else
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
 
-	mmc->f_max = host->max_clk;
 	mmc->caps |= MMC_CAP_SDIO_IRQ;
 
 	/*
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 4746879..37a8c32 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -102,6 +102,7 @@
 #define  SDHCI_DIV_MASK	0xFF
 #define  SDHCI_DIV_MASK_LEN	8
 #define  SDHCI_DIV_HI_MASK	0x300
+#define  SDHCI_PROG_CLOCK_MODE	0x0020
 #define  SDHCI_CLOCK_CARD_EN	0x0004
 #define  SDHCI_CLOCK_INT_STABLE	0x0002
 #define  SDHCI_CLOCK_INT_EN	0x0001
@@ -190,6 +191,8 @@
 #define  SDHCI_DRIVER_TYPE_C	0x00000020
 #define  SDHCI_DRIVER_TYPE_D	0x00000040
 #define  SDHCI_USE_SDR50_TUNING	0x00002000
+#define  SDHCI_CLOCK_MUL_MASK	0x00FF0000
+#define  SDHCI_CLOCK_MUL_SHIFT	16
 
 #define SDHCI_CAPABILITIES_1	0x44
 
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 26b6278..1e7a654 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -115,6 +115,7 @@ struct sdhci_host {
 
 	unsigned int max_clk;	/* Max possible freq (MHz) */
 	unsigned int timeout_clk;	/* Timeout freq (KHz) */
+	unsigned int clk_mul;	/* Clock Muliplier value */
 
 	unsigned int clock;	/* Current clock (MHz) */
 	u8 pwr;			/* Current voltage */
-- 
1.7.1

