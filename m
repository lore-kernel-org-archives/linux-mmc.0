From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] sdhci: Make sdhci_disable_irq_wakeups() static
Date: Sat, 30 Aug 2014 14:53:13 -0300
Message-ID: <1409421193-17077-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f47.google.com ([209.85.213.47]:44120 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbaH3Rxu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 30 Aug 2014 13:53:50 -0400
Received: by mail-yh0-f47.google.com with SMTP id c41so2367559yho.20
        for <linux-mmc@vger.kernel.org>; Sat, 30 Aug 2014 10:53:49 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: chris@printf.net, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

sdhci_disable_irq_wakeups() is exported, but it is not called outside sdhci.c.

Make it static and do not export it, so that the following sparse warning is
fixed:

drivers/mmc/host/sdhci.c:2548:6: warning: symbol 'sdhci_disable_irq_wakeups' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/host/sdhci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4cc2ff9..930c190 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2545,7 +2545,7 @@ void sdhci_enable_irq_wakeups(struct sdhci_host *host)
 }
 EXPORT_SYMBOL_GPL(sdhci_enable_irq_wakeups);
 
-void sdhci_disable_irq_wakeups(struct sdhci_host *host)
+static void sdhci_disable_irq_wakeups(struct sdhci_host *host)
 {
 	u8 val;
 	u8 mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE
@@ -2555,7 +2555,6 @@ void sdhci_disable_irq_wakeups(struct sdhci_host *host)
 	val &= ~mask;
 	sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
 }
-EXPORT_SYMBOL_GPL(sdhci_disable_irq_wakeups);
 
 int sdhci_suspend_host(struct sdhci_host *host)
 {
-- 
1.9.1

