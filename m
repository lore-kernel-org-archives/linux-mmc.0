From: Anton Vorontsov <avorontsov@mvista.com>
Subject: [PATCH 7/8] sdhci: Get rid of mdelay()s where it is safe and makes
 sense
Date: Wed, 14 Jul 2010 17:08:09 +0400
Message-ID: <20100714130809.GG517@oksana.dev.rtsoft.ru>
References: <20100714130728.GA27339@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from imap.ru.mvista.com ([213.79.90.228]:18762 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756861Ab0GNNIM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jul 2010 09:08:12 -0400
Content-Disposition: inline
In-Reply-To: <20100714130728.GA27339@oksana.dev.rtsoft.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Albert Herranz <albert_herranz@yahoo.es>, Matt Fleming <matt@console-pimps.org>, Ben Dooks <ben-linux@fluff.org>, Pierre Ossman <pierre@ossman.eu>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org

Since we don't run in the atomic context any longer, we can
turn mdelay()s into msleep()s.

The only place where the driver is still using mdelay() is
sdhci_send_command(). There it is possible to use sleepable
delays too, but we don't actually want to force rescheduling
in a hot path.

Sure, we might end up calling msleep() there too, just not
via this safe patch.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c |    2 +-
 drivers/mmc/host/sdhci.c          |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index c8623de..e9f99fe 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -94,7 +94,7 @@ static void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
 	setbits32(host->ioaddr + ESDHC_SYSTEM_CONTROL, ESDHC_CLOCK_IPGEN |
 		  ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN |
 		  div << ESDHC_DIVIDER_SHIFT | pre_div << ESDHC_PREDIV_SHIFT);
-	mdelay(100);
+	msleep(100);
 out:
 	host->clock = clock;
 }
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 56d5c56..e6adda8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -171,7 +171,7 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		msleep(1);
 	}
 
 	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
@@ -1019,7 +1019,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		msleep(1);
 	}
 
 	clk |= SDHCI_CLOCK_CARD_EN;
@@ -1086,7 +1086,7 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
 	 * can apply clock after applying power
 	 */
 	if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
-		mdelay(10);
+		msleep(10);
 }
 
 /*****************************************************************************\
-- 
1.7.0.5

