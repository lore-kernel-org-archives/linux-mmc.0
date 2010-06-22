From: Rabin Vincent <rabin.vincent@stericsson.com>
Subject: [PATCH 06/12] mmci: allow neither ->status nor gpio_cd to be specified
Date: Tue, 22 Jun 2010 14:47:41 +0530
Message-ID: <1277198267-10860-6-git-send-email-rabin.vincent@stericsson.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:51414 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759080Ab0FVJSs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jun 2010 05:18:48 -0400
In-Reply-To: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mmc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, Rabin Vincent <rabin.vincent@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

The card may be always present on the board, and for these cases neither
a status callback nor a card detect GPIO is required, and card detection
polling can be disabled.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 drivers/mmc/host/mmci.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index e6477e6..322958f 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -533,9 +533,12 @@ static int mmci_get_cd(struct mmc_host *mmc)
 	struct mmci_host *host = mmc_priv(mmc);
 	unsigned int status;
 
-	if (host->gpio_cd == -ENOSYS)
+	if (host->gpio_cd == -ENOSYS) {
+		if (!host->plat->status)
+			return 1; /* Assume always present */
+
 		status = host->plat->status(mmc_dev(host->mmc));
-	else
+	} else
 		status = gpio_get_value(host->gpio_cd);
 
 	return !status ^ host->plat->cd_noinvert;
@@ -724,7 +727,8 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 			goto err_gpio_wp;
 	}
 
-	if (host->gpio_cd_irq < 0)
+	if ((host->plat->status || host->gpio_cd != -ENOSYS)
+	    && host->gpio_cd_irq < 0)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
 	ret = request_irq(dev->irq[0], mmci_irq, IRQF_SHARED, DRIVER_NAME " (cmd)", host);
-- 
1.7.0

