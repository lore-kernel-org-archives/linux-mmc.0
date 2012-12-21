From: Chunhe Lan <Chunhe.Lan@freescale.com>
Subject: [v4 2/2] mmc: Use mmc_delay() instead of mdelay() for time delay
Date: Fri, 21 Dec 2012 17:28:00 +0800
Message-ID: <1356082080-7756-2-git-send-email-Chunhe.Lan@freescale.com>
References: <1356082080-7756-1-git-send-email-Chunhe.Lan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:49826
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751450Ab2LUJ0a (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Dec 2012 04:26:30 -0500
In-Reply-To: <1356082080-7756-1-git-send-email-Chunhe.Lan@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Chunhe Lan <Chunhe.Lan@freescale.com>, Kumar Gala <galak@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>

The mmc_delay() is a wrapper function for cond_resched() and udelay().

    o mdelay()
		block the system when busy-waiting.
    o cond_resched()
		suspend the currently running task to enable CPU
                to process other tasks, so it is non-blocking
                regarding the whole system.

Change mdelay() to mmc_delay() to avoid chewing CPU when busy wait.

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/sdhci-esdhc.h |    4 ++--
 drivers/mmc/host/sdhci.c       |   10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index d25f9ab..5e33732 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -1,7 +1,7 @@
 /*
  * Freescale eSDHC controller driver generics for OF and pltfm.
  *
- * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ * Copyright (c) 2007, 2012 Freescale Semiconductor, Inc.
  * Copyright (c) 2009 MontaVista Software, Inc.
  * Copyright (c) 2010 Pengutronix e.K.
  *   Author: Wolfram Sang <w.sang@pengutronix.de>
@@ -73,7 +73,7 @@ static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
 		| (div << ESDHC_DIVIDER_SHIFT)
 		| (pre_div << ESDHC_PREDIV_SHIFT));
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
-	mdelay(1);
+	mmc_delay(1);
 out:
 	host->clock = clock;
 }
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6f0bfc0..a20c4f0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -206,7 +206,7 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		mmc_delay(1);
 	}
 
 	if (host->ops->platform_reset_exit)
@@ -998,7 +998,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		mmc_delay(1);
 	}
 
 	mod_timer(&host->timer, jiffies + 10 * HZ);
@@ -1179,7 +1179,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		mmc_delay(1);
 	}
 
 	clk |= SDHCI_CLOCK_CARD_EN;
@@ -1244,7 +1244,7 @@ static int sdhci_set_power(struct sdhci_host *host, unsigned short power)
 	 * can apply clock after applying power
 	 */
 	if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
-		mdelay(10);
+		mmc_delay(10);
 
 	return power;
 }
@@ -1895,7 +1895,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 		tuning_loop_counter--;
 		timeout--;
-		mdelay(1);
+		mmc_delay(1);
 	} while (ctrl & SDHCI_CTRL_EXEC_TUNING);
 
 	/*
-- 
1.7.6.5


