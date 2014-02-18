From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 18/31] mmc: sdhci: move setting mmc->actual_clock into
 set_clock handlers
Date: Tue, 18 Feb 2014 15:10:35 +0000
Message-ID: <E1WFmJf-0006mz-BV@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40516 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755560AbaBRPKk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 10:10:40 -0500
In-Reply-To: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ben Dooks <ben-linux@fluff.org>

Move the setting of mmc->actual_clock to zero into the set_clock
handlers themselves.  This will allow us to clean up the calling
logic for the set_clock() method, and turn sdhci_set_clock() into
a library function.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
=-DO NOT APPLY-=
 drivers/mmc/host/sdhci-cns3xxx.c   | 2 ++
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 ++
 drivers/mmc/host/sdhci-of-esdhc.c  | 3 ++-
 drivers/mmc/host/sdhci-s3c.c       | 4 ++++
 drivers/mmc/host/sdhci.c           | 4 ++--
 5 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-cns3xxx.c
index f11fb908ad78..416f4a4c2e35 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-cns3xxx.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-cns3xxx.c
@@ -30,6 +30,8 @@ static void sdhci_cns3xxx_set_clock(struct sdhci_host *host, unsigned int clock)
 	u16 clk;
 	unsigned long timeout;
 
=+DO NOT APPLY+=	host->mmc->actual_clock = 0;
=+DO NOT APPLY+=
 	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 
 	if (clock == 0)
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 1e68a77c9987..ce8939ff97a4 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-esdhc-imx.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -600,6 +600,8 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 	u32 temp, val;
 
 	if (clock == 0) {
=+DO NOT APPLY+=		host->mmc->actual_clock = 0;
=+DO NOT APPLY+=
 		if (esdhc_is_usdhc(imx_data)) {
 			val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
 			writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index d814b3ecb1f7..c4f8cd3f83c8 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-of-esdhc.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -199,11 +199,12 @@ static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
 
 static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 {
-
 	int pre_div = 2;
 	int div = 1;
 	u32 temp;
 
=+DO NOT APPLY+=	host->mmc->actual_clock = 0;
=+DO NOT APPLY+=
 	if (clock == 0)
 		return;
 
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index e7865d1da1f2..18579555a5f7 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-s3c.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-s3c.c
@@ -188,6 +188,8 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
 	int src;
 	u32 ctrl;
 
=+DO NOT APPLY+=	host->mmc->actual_clock = 0;
=+DO NOT APPLY+=
 	/* don't bother if the clock is going off. */
 	if (clock == 0)
 		return;
@@ -296,6 +298,8 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
 	unsigned long timeout;
 	u16 clk = 0;
 
=+DO NOT APPLY+=	host->mmc->actual_clock = 0;
=+DO NOT APPLY+=
 	/* If the clock is going off, set to 0 at clock control register */
 	if (clock == 0) {
 		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5fdf9f927a99..c370e6bd7ecd 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci.c
@@ -1119,14 +1119,14 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	u16 clk = 0;
 	unsigned long timeout;
 
-	host->mmc->actual_clock = 0;
-
 	if (host->ops->set_clock) {
 		host->ops->set_clock(host, clock);
 		if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK)
 			return;
 	}
 
=+DO NOT APPLY+=	host->mmc->actual_clock = 0;
=+DO NOT APPLY+=
 	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 
 	if (clock == 0)
-- 
1.8.3.1

