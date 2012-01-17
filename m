From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 1/8] mmc: mmci: Cache MMCICLOCK and MMCIPOWER register
Date: Tue, 17 Jan 2012 15:34:20 +0100
Message-ID: <1326810867-5346-2-git-send-email-ulf.hansson@stericsson.com>
References: <1326810867-5346-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:60028 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753524Ab2AQOev (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jan 2012 09:34:51 -0500
In-Reply-To: <1326810867-5346-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

Instead of reading a register value everytime we need to
apply a new value for it, maintain a cached copy for it.
This also means we are able to skip writes that are not
needed.

Tested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |   41 +++++++++++++++++++++++++++++------------
 drivers/mmc/host/mmci.h |    3 ++-
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 9e544cf..0de2f3d 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -121,6 +121,28 @@ static struct variant_data variant_ux500v2 = {
 /*
  * This must be called with host->lock held
  */
+static void mmci_write_clkreg(struct mmci_host *host, u32 clk)
+{
+	if (host->clk_reg != clk) {
+		host->clk_reg = clk;
+		writel(clk, host->base + MMCICLOCK);
+	}
+}
+
+/*
+ * This must be called with host->lock held
+ */
+static void mmci_write_pwrreg(struct mmci_host *host, u32 pwr)
+{
+	if (host->pwr_reg != pwr) {
+		host->pwr_reg = pwr;
+		writel(pwr, host->base + MMCIPOWER);
+	}
+}
+
+/*
+ * This must be called with host->lock held
+ */
 static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 {
 	struct variant_data *variant = host->variant;
@@ -165,7 +187,7 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_8)
 		clk |= MCI_ST_8BIT_BUS;
 
-	writel(clk, host->base + MMCICLOCK);
+	mmci_write_clkreg(host, clk);
 }
 
 static void
@@ -843,14 +865,13 @@ static int mmci_pio_write(struct mmci_host *host, char *buffer, unsigned int rem
 		 */
 		if (variant->sdio &&
 		    mmc_card_sdio(host->mmc->card)) {
+			u32 clk;
 			if (count < 8)
-				writel(readl(host->base + MMCICLOCK) &
-					~variant->clkreg_enable,
-					host->base + MMCICLOCK);
+				clk = host->clk_reg & ~variant->clkreg_enable;
 			else
-				writel(readl(host->base + MMCICLOCK) |
-					variant->clkreg_enable,
-					host->base + MMCICLOCK);
+				clk = host->clk_reg | variant->clkreg_enable;
+
+			mmci_write_clkreg(host, clk);
 		}
 
 		/*
@@ -1111,11 +1132,7 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	spin_lock_irqsave(&host->lock, flags);
 
 	mmci_set_clkreg(host, ios->clock);
-
-	if (host->pwr != pwr) {
-		host->pwr = pwr;
-		writel(pwr, host->base + MMCIPOWER);
-	}
+	mmci_write_pwrreg(host, pwr);
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 89eb2e3..d437ccf 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -179,7 +179,8 @@ struct mmci_host {
 
 	unsigned int		mclk;
 	unsigned int		cclk;
-	u32			pwr;
+	u32			pwr_reg;
+	u32			clk_reg;
 	struct mmci_platform_data *plat;
 	struct variant_data	*variant;
 
-- 
1.7.5.4

