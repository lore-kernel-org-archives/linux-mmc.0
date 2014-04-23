From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 16/38] mmc: sdhci: move setting mmc->actual_clock into
 set_clock handlers
Date: Wed, 23 Apr 2014 20:07:32 +0100
Message-ID: <E1Wd2W4-0003vM-0A@rmk-PC.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46429 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751182AbaDWTHg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Apr 2014 15:07:36 -0400
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>, Ben Dooks <ben-linux@fluff.org>

Move the setting of mmc->actual_clock to zero into the set_clock
handlers themselves.  This will allow us to clean up the calling
logic for the set_clock() method, and turn sdhci_set_clock() into
a library function.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-cns3xxx.c   | 2 ++
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 ++
 drivers/mmc/host/sdhci-of-esdhc.c  | 3 ++-
 drivers/mmc/host/sdhci-s3c.c       | 4 ++++
 drivers/mmc/host/sdhci.c           | 4 ++--
 5 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-cns3xxx.c
index f11fb908ad78..416f4a4c2e35 100644
--- a/drivers/mmc/host/sdhci-cns3xxx.c
+++ b/drivers/mmc/host/sdhci-cns3xxx.c
@@ -30,6 +30,8 @@ static void sdhci_cns3xxx_set_clock(struct sdhci_host *host, unsigned int clock)
 	u16 clk;
 	unsigned long timeout;
 
+	host->mmc->actual_clock = 0;
+
 	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 
 	if (clock == 0)
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 1e68a77c9987..ce8939ff97a4 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -600,6 +600,8 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 	u32 temp, val;
 
 	if (clock == 0) {
+		host->mmc->actual_clock = 0;
+
 		if (esdhc_is_usdhc(imx_data)) {
 			val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
 			writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index d814b3ecb1f7..c4f8cd3f83c8 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -199,11 +199,12 @@ static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
 
 static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 {
-
 	int pre_div = 2;
 	int div = 1;
 	u32 temp;
 
+	host->mmc->actual_clock = 0;
+
 	if (clock == 0)
 		return;
 
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 6b424a6f79c4..464059c91a24 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -161,6 +161,8 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
 	int src;
 	u32 ctrl;
 
+	host->mmc->actual_clock = 0;
+
 	/* don't bother if the clock is going off. */
 	if (clock == 0)
 		return;
@@ -295,6 +297,8 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
 	unsigned long timeout;
 	u16 clk = 0;
 
+	host->mmc->actual_clock = 0;
+
 	/* If the clock is going off, set to 0 at clock control register */
 	if (clock == 0) {
 		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a8ee5f786660..67b7a5752049 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
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
 
+	host->mmc->actual_clock = 0;
+
 	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 
 	if (clock == 0)
-- 
1.8.3.1

