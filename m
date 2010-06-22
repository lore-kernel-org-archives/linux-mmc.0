From: Rabin Vincent <rabin.vincent@stericsson.com>
Subject: [PATCH 05/12] mmci: support card detection interrupts
Date: Tue, 22 Jun 2010 14:47:40 +0530
Message-ID: <1277198267-10860-5-git-send-email-rabin.vincent@stericsson.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:45701 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759053Ab0FVJSo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jun 2010 05:18:44 -0400
In-Reply-To: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mmc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, Rabin Vincent <rabin.vincent@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

If an IRQ can be requested on the card detected GPIO, use it instead of
polling.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 drivers/mmc/host/mmci.c |   24 +++++++++++++++++++++++-
 drivers/mmc/host/mmci.h |    1 +
 2 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 7e56726..e6477e6 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -541,6 +541,15 @@ static int mmci_get_cd(struct mmc_host *mmc)
 	return !status ^ host->plat->cd_noinvert;
 }
 
+static irqreturn_t mmci_cd_irq(int irq, void *dev_id)
+{
+	struct mmci_host *host = dev_id;
+
+	mmc_detect_change(host->mmc, msecs_to_jiffies(500));
+
+	return IRQ_HANDLED;
+}
+
 static const struct mmc_host_ops mmci_ops = {
 	.request	= mmci_request,
 	.set_ios	= mmci_set_ios,
@@ -576,6 +585,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 
 	host->gpio_wp = -ENOSYS;
 	host->gpio_cd = -ENOSYS;
+	host->gpio_cd_irq = -1;
 
 	host->hw_designer = amba_manf(dev);
 	host->hw_revision = amba_rev(dev);
@@ -654,7 +664,6 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	if (host->vcc == NULL)
 		mmc->ocr_avail = plat->ocr_mask;
 	mmc->caps = plat->capabilities;
-	mmc->caps |= MMC_CAP_NEEDS_POLL;
 
 	/*
 	 * We can do SGIO
@@ -698,6 +707,12 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 			host->gpio_cd = plat->gpio_cd;
 		else if (ret != -ENOSYS)
 			goto err_gpio_cd;
+
+		ret = request_any_context_irq(gpio_to_irq(plat->gpio_cd),
+					      mmci_cd_irq, 0,
+					      DRIVER_NAME " (cd)", host);
+		if (ret >= 0)
+			host->gpio_cd_irq = gpio_to_irq(plat->gpio_cd);
 	}
 	if (gpio_is_valid(plat->gpio_wp)) {
 		ret = gpio_request(plat->gpio_wp, DRIVER_NAME " (wp)");
@@ -709,6 +724,9 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 			goto err_gpio_wp;
 	}
 
+	if (host->gpio_cd_irq < 0)
+		mmc->caps |= MMC_CAP_NEEDS_POLL;
+
 	ret = request_irq(dev->irq[0], mmci_irq, IRQF_SHARED, DRIVER_NAME " (cmd)", host);
 	if (ret)
 		goto unmap;
@@ -735,6 +753,8 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	if (host->gpio_wp != -ENOSYS)
 		gpio_free(host->gpio_wp);
  err_gpio_wp:
+	if (host->gpio_cd_irq >= 0)
+		free_irq(host->gpio_cd_irq, host);
 	if (host->gpio_cd != -ENOSYS)
 		gpio_free(host->gpio_cd);
  err_gpio_cd:
@@ -773,6 +793,8 @@ static int __devexit mmci_remove(struct amba_device *dev)
 
 		if (host->gpio_wp != -ENOSYS)
 			gpio_free(host->gpio_wp);
+		if (host->gpio_cd_irq >= 0)
+			free_irq(host->gpio_cd_irq, host);
 		if (host->gpio_cd != -ENOSYS)
 			gpio_free(host->gpio_cd);
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 7cb24ab..516adc6 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -155,6 +155,7 @@ struct mmci_host {
 	struct clk		*clk;
 	int			gpio_cd;
 	int			gpio_wp;
+	int			gpio_cd_irq;
 
 	unsigned int		data_xfered;
 
-- 
1.7.0

