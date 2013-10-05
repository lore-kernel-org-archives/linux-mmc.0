From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/3] mmc: host: sdhci: Make sdhci_disable_irq_wakeups static
Date: Fri,  4 Oct 2013 22:59:24 -0300
Message-ID: <1380938365-7769-2-git-send-email-festevam@gmail.com>
References: <1380938365-7769-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41]:37078 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab3JEB7l (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Oct 2013 21:59:41 -0400
Received: by mail-yh0-f41.google.com with SMTP id f73so1182451yha.14
        for <linux-mmc@vger.kernel.org>; Fri, 04 Oct 2013 18:59:40 -0700 (PDT)
In-Reply-To: <1380938365-7769-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

sdhci_disable_irq_wakeups() is not used anywhere else, so make it static.

Fix the following sparse warning:

drivers/mmc/host/sdhci.c:2543:6: warning: symbol 'sdhci_disable_irq_wakeups' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/host/sdhci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 66bce7a..35e251c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2540,7 +2540,7 @@ void sdhci_enable_irq_wakeups(struct sdhci_host *host)
 }
 EXPORT_SYMBOL_GPL(sdhci_enable_irq_wakeups);
 
-void sdhci_disable_irq_wakeups(struct sdhci_host *host)
+static void sdhci_disable_irq_wakeups(struct sdhci_host *host)
 {
 	u8 val;
 	u8 mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE
@@ -2550,7 +2550,6 @@ void sdhci_disable_irq_wakeups(struct sdhci_host *host)
 	val &= ~mask;
 	sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
 }
-EXPORT_SYMBOL_GPL(sdhci_disable_irq_wakeups);
 
 int sdhci_suspend_host(struct sdhci_host *host)
 {
-- 
1.8.1.2

