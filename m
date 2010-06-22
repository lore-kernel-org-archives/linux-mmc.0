From: Rabin Vincent <rabin.vincent@stericsson.com>
Subject: [PATCH 03/12] mmci: let core poll for card detection
Date: Tue, 22 Jun 2010 14:47:38 +0530
Message-ID: <1277198267-10860-3-git-send-email-rabin.vincent@stericsson.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:36299 "EHLO
	eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759114Ab0FVJTC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jun 2010 05:19:02 -0400
In-Reply-To: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mmc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, Rabin Vincent <rabin.vincent@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

Use the MMC core's ability to poll for card detection.  This also has
the advantage of doing the gpio_get_value from a workqueue instead of
timer, allowing the gpio to be on a sleeping gpiochip.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 drivers/mmc/host/mmci.c |   22 +---------------------
 1 files changed, 1 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 84d782b..65f0e12 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -548,18 +548,6 @@ static const struct mmc_host_ops mmci_ops = {
 	.get_cd		= mmci_get_cd,
 };
 
-static void mmci_check_status(unsigned long data)
-{
-	struct mmci_host *host = (struct mmci_host *)data;
-	unsigned int status = mmci_get_cd(host->mmc);
-
-	if (status ^ host->oldstat)
-		mmc_detect_change(host->mmc, 0);
-
-	host->oldstat = status;
-	mod_timer(&host->timer, jiffies + HZ);
-}
-
 static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 {
 	struct mmci_platform_data *plat = dev->dev.platform_data;
@@ -666,6 +654,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	if (host->vcc == NULL)
 		mmc->ocr_avail = plat->ocr_mask;
 	mmc->caps = plat->capabilities;
+	mmc->caps |= MMC_CAP_NEEDS_POLL;
 
 	/*
 	 * We can do SGIO
@@ -731,7 +720,6 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	writel(MCI_IRQENABLE, host->base + MMCIMASK0);
 
 	amba_set_drvdata(dev, mmc);
-	host->oldstat = mmci_get_cd(host->mmc);
 
 	mmc_add_host(mmc);
 
@@ -739,12 +727,6 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 		mmc_hostname(mmc), amba_rev(dev), amba_config(dev),
 		(unsigned long long)dev->res.start, dev->irq[0], dev->irq[1]);
 
-	init_timer(&host->timer);
-	host->timer.data = (unsigned long)host;
-	host->timer.function = mmci_check_status;
-	host->timer.expires = jiffies + HZ;
-	add_timer(&host->timer);
-
 	return 0;
 
  irq0_free:
@@ -778,8 +760,6 @@ static int __devexit mmci_remove(struct amba_device *dev)
 	if (mmc) {
 		struct mmci_host *host = mmc_priv(mmc);
 
-		del_timer_sync(&host->timer);
-
 		mmc_remove_host(mmc);
 
 		writel(0, host->base + MMCIMASK0);
-- 
1.7.0

