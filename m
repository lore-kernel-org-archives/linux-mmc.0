From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 17/31] mmc: sdhci: move setting host->clock into
 sdhci_do_set_ios()
Date: Tue, 18 Feb 2014 15:10:30 +0000
Message-ID: <E1WFmJa-0006mu-7x@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40509 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755560AbaBRPKe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 10:10:34 -0500
In-Reply-To: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ben Dooks <ben-linux@fluff.org>

We don't need implementations to do this, since the only time it's
necessary is when we change the clock, and the only place that happens
is in sdhci_do_set_ios().  So, move it there, and remove it from the
iMX platform backend.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
=-DO NOT APPLY-=
 drivers/mmc/host/sdhci-cns3xxx.c   | 4 +---
 drivers/mmc/host/sdhci-esdhc-imx.c | 4 +---
 drivers/mmc/host/sdhci-of-esdhc.c  | 4 +---
 drivers/mmc/host/sdhci-s3c.c       | 3 ---
 drivers/mmc/host/sdhci.c           | 9 ++++-----
 5 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-cns3xxx.c
index fa11f63b78a0..f11fb908ad78 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-cns3xxx.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-cns3xxx.c
@@ -33,7 +33,7 @@ static void sdhci_cns3xxx_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 
 	if (clock == 0)
-		goto out;
=+DO NOT APPLY+=		return;
 
 	while (host->max_clk / div > clock) {
 		/*
@@ -72,8 +72,6 @@ static void sdhci_cns3xxx_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	clk |= SDHCI_CLOCK_CARD_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-out:
-	host->clock = clock;
 }
 
 static const struct sdhci_ops sdhci_cns3xxx_ops = {
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 812c5772d900..1e68a77c9987 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-esdhc-imx.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -605,7 +605,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 			writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
 					host->ioaddr + ESDHC_VENDOR_SPEC);
 		}
-		goto out;
=+DO NOT APPLY+=		return;
 	}
 
 	if (esdhc_is_usdhc(imx_data) && !imx_data->is_ddr)
@@ -645,8 +645,6 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 	}
 
 	mdelay(1);
-out:
-	host->clock = clock;
 }
 
 static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 4530f9957f20..d814b3ecb1f7 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-of-esdhc.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -205,7 +205,7 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 	u32 temp;
 
 	if (clock == 0)
-		goto out;
=+DO NOT APPLY+=		return;
 
 	/* Workaround to reduce the clock frequency for p1010 esdhc */
 	if (of_find_compatible_node(NULL, NULL, "fsl,p1010-esdhc")) {
@@ -238,8 +238,6 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 		| (pre_div << ESDHC_PREDIV_SHIFT));
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
 	mdelay(1);
-out:
-	host->clock = clock;
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 619047be00c9..e7865d1da1f2 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-s3c.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-s3c.c
@@ -299,7 +299,6 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
 	/* If the clock is going off, set to 0 at clock control register */
 	if (clock == 0) {
 		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
-		host->clock = clock;
 		return;
 	}
 
@@ -307,8 +306,6 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	clk_set_rate(ourhost->clk_bus[ourhost->cur_clk], clock);
 
-	host->clock = clock;
-
 	clk = SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6e0ffaa84ba0..5fdf9f927a99 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci.c
@@ -1130,7 +1130,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 
 	if (clock == 0)
-		goto out;
=+DO NOT APPLY+=		return;
 
 	if (host->version >= SDHCI_SPEC_300) {
 		if (sdhci_readw(host, SDHCI_HOST_CONTROL2) &
@@ -1220,9 +1220,6 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	clk |= SDHCI_CLOCK_CARD_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-
-out:
-	host->clock = clock;
 }
 
 static int sdhci_set_power(struct sdhci_host *host, unsigned short power)
@@ -1441,8 +1438,10 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
 		sdhci_enable_preset_value(host, false);
 
-	if (!ios->clock || ios->clock != host->clock)
=+DO NOT APPLY+=	if (!ios->clock || ios->clock != host->clock) {
 		sdhci_set_clock(host, ios->clock);
=+DO NOT APPLY+=		host->clock = ios->clock;
=+DO NOT APPLY+=	}
 
 	if (ios->power_mode == MMC_POWER_OFF)
 		vdd_bit = sdhci_set_power(host, -1);
-- 
1.8.3.1

