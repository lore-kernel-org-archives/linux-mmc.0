From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 2/2] mmci: handle clock frequency 0 properly v8
Date: Wed,  3 Nov 2010 10:23:01 +0100
Message-ID: <1288776181-10407-1-git-send-email-linus.walleij@stericsson.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:46773 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752523Ab0KCJXh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 3 Nov 2010 05:23:37 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ghorai Sukumar <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, David Vrabel <david.vrabel@csr.com>, Kyungmin Park <kmpark@infradead.org>, jh80.chung@samsung.com, Linus Walleij <linus.walleij@stericsson.com>

This removes the default clocking for the MMCI controller so that
the external MCI card clock does not activate until the first
.set_ios() call is issued. It will further handle the transitions
from a clock != 0 to 0 and vice versa by gating/ungating the
clock with clk_disable()/clk_enable().

This assures that the MCI clock will not be active unless there
is a card in the MMC slot.

By default the MMC core will not gate off the clock to a card
once it's enabled, but with the separate patch for aggressive
clocking this can optionally be enabled for the system.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/host/mmci.c |   35 +++++++++++++++++++++++------------
 drivers/mmc/host/mmci.h |    1 +
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index d4081d5..ea5e320 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -924,7 +924,23 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	spin_lock_irqsave(&host->lock, flags);
 
-	mmci_set_clkreg(host, ios->clock);
+	/*
+	 * Turn on clock whenever ios->clock transitions
+	 * from 0 to !=0 and gate it off whenever ios->clock
+	 * transitions from !=0 to 0.
+	 */
+	if (host->iosclock == 0 && ios->clock != 0) {
+		dev_dbg(mmc_dev(mmc), "enable clock f=%d\n", ios->clock);
+		clk_enable(host->clk);
+		mmci_set_clkreg(host, ios->clock);
+	} else if (host->iosclock != 0 && ios->clock == 0) {
+		dev_dbg(mmc_dev(mmc), "disable clock\n");
+		clk_disable(host->clk);
+	} else if (ios->clock != 0) {
+		mmci_set_clkreg(host, ios->clock);
+		dev_dbg(mmc_dev(mmc), "set clock f=%d\n", ios->clock);
+	}
+	host->iosclock = ios->clock;
 
 	if (host->pwr != pwr) {
 		host->pwr = pwr;
@@ -1009,6 +1025,8 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
+	host->plat = plat;
+	host->variant = variant;
 
 	host->gpio_wp = -ENOSYS;
 	host->gpio_cd = -ENOSYS;
@@ -1019,19 +1037,14 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	dev_dbg(mmc_dev(mmc), "designer ID = 0x%02x\n", host->hw_designer);
 	dev_dbg(mmc_dev(mmc), "revision = 0x%01x\n", host->hw_revision);
 
+	/* This clock will be enabled/disabled by set_ios() calls later */
 	host->clk = clk_get(&dev->dev, NULL);
 	if (IS_ERR(host->clk)) {
 		ret = PTR_ERR(host->clk);
 		host->clk = NULL;
 		goto host_free;
 	}
-
-	ret = clk_enable(host->clk);
-	if (ret)
-		goto clk_free;
-
-	host->plat = plat;
-	host->variant = variant;
+	host->iosclock = 0;
 	host->mclk = clk_get_rate(host->clk);
 	/*
 	 * According to the spec, mclk is max 100 MHz,
@@ -1041,7 +1054,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	if (host->mclk > 100000000) {
 		ret = clk_set_rate(host->clk, 100000000);
 		if (ret < 0)
-			goto clk_disable;
+			goto clk_free;
 		host->mclk = clk_get_rate(host->clk);
 		dev_dbg(mmc_dev(mmc), "eventual mclk rate: %u Hz\n",
 			host->mclk);
@@ -1050,7 +1063,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	host->base = ioremap(dev->res.start, resource_size(&dev->res));
 	if (!host->base) {
 		ret = -ENOMEM;
-		goto clk_disable;
+		goto clk_free;
 	}
 
 	mmc->ops = &mmci_ops;
@@ -1203,8 +1216,6 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 		gpio_free(host->gpio_cd);
  err_gpio_cd:
 	iounmap(host->base);
- clk_disable:
-	clk_disable(host->clk);
  clk_free:
 	clk_put(host->clk);
  host_free:
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index bc3b71e..5701d33 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -170,6 +170,7 @@ struct mmci_host {
 
 	unsigned int		mclk;
 	unsigned int		cclk;
+	unsigned int		iosclock;
 	u32			pwr;
 	struct mmci_platform_data *plat;
 	struct variant_data	*variant;
-- 
1.7.2.3

