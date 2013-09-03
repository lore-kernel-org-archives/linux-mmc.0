From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 2/5] mmc:sdhc: Share function sdhci_reset for platform use
Date: Tue, 3 Sep 2013 15:33:14 +0800
Message-ID: <1378193597-29059-2-git-send-email-Haijun.Zhang@freescale.com>
References: <1378193597-29059-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [216.32.181.182] ([216.32.181.182]:4507 "EHLO
	ch1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S932637Ab3ICHh2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2013 03:37:28 -0400
In-Reply-To: <1378193597-29059-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cbouatmailru@gmail.com, galak@kernel.crashing.org
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>

In some case, sdhci_reset is need to be invoked in some
platform related workaround. So export it for public use.

Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 57541e0..f81439b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -181,7 +181,7 @@ static void sdhci_disable_card_detection(struct sdhci_host *host)
 	sdhci_set_card_detection(host, false);
 }
 
-static void sdhci_reset(struct sdhci_host *host, u8 mask)
+void sdhci_reset(struct sdhci_host *host, u8 mask)
 {
 	unsigned long timeout;
 	u32 uninitialized_var(ier);
@@ -233,6 +233,7 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 			host->ops->enable_dma(host);
 	}
 }
+EXPORT_SYMBOL_GPL(sdhci_reset);
 
 static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b037f18..26fca04 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -393,6 +393,7 @@ static inline void *sdhci_priv(struct sdhci_host *host)
 extern void sdhci_card_detect(struct sdhci_host *host);
 extern int sdhci_add_host(struct sdhci_host *host);
 extern void sdhci_remove_host(struct sdhci_host *host, int dead);
+extern void sdhci_reset(struct sdhci_host *host, u8 mask);
 
 #ifdef CONFIG_PM
 extern int sdhci_suspend_host(struct sdhci_host *host);
-- 
1.8.0


