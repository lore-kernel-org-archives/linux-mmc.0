From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 5/7] mmc: sdhci: do not enable card cd wakeup for gpio case
Date: Wed, 3 Sep 2014 20:05:01 +0800
Message-ID: <1409745903-26550-6-git-send-email-b29396@freescale.com>
References: <1409745903-26550-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1lp0140.outbound.protection.outlook.com ([207.46.163.140]:21974
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932185AbaICM0u (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 3 Sep 2014 08:26:50 -0400
In-Reply-To: <1409745903-26550-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, b29396@freescale.com, linux-arm-kernel@lists.infradead.org

Do not need to enable the controller card cd interrupt wakeup
if using GPIO as card detect since it's meaningless.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4d0b7b5..7aa98b9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2548,13 +2548,16 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
 void sdhci_enable_irq_wakeups(struct sdhci_host *host)
 {
 	u8 val;
+	int gpio_cd = mmc_gpio_get_cd(host->mmc);
+
 	u8 mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE
 			| SDHCI_WAKE_ON_INT;
 
 	val = sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
 	val |= mask ;
 	/* Avoid fake wake up */
-	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
+	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION ||
+	    !IS_ERR_VALUE(gpio_cd))
 		val &= ~(SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE);
 	sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
 }
-- 
1.7.8

