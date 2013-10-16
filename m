From: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Subject: [PATCH 7/8] sdhci: Get rid of mdelay()s where it is safe and makes sense
Date: Wed, 16 Oct 2013 18:20:57 +0200
Message-ID: <1381940458-12628-8-git-send-email-jeremie.samuel.ext@parrot.com>
References: <1381940458-12628-1-git-send-email-jeremie.samuel.ext@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:33774 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932589Ab3JPQWg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Oct 2013 12:22:36 -0400
In-Reply-To: <1381940458-12628-1-git-send-email-jeremie.samuel.ext@parrot.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, =?UTF-8?q?Gr=C3=A9gor=20Boirie?= <gregor.boirie@parrot.com>, Matthieu Castet <matthieu.castet@parrot.com>, Jeremie Samuel <jeremie.samuel.ext@parrot.com>, Anton Vorontsov <avorontsov@mvista.com>

Since we don't run in the atomic context any longer, we can
turn mdelay()s into msleep()s.

The only place where the driver is still using mdelay() is
sdhci_send_command(). There it is possible to use sleepable
delays too, but we don't actually want to force rescheduling
in a hot path.

Sure, we might end up calling msleep() there too, just not
via this safe patch.

PAtch based on: http://thread.gmane.org/gmane.linux.kernel.mmc/2579.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
Signed-off-by: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
---
 drivers/mmc/host/sdhci.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ce7c99b..843e99d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -220,7 +220,7 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		msleep(1);
 	}
 
 	if (host->ops->platform_reset_exit)
@@ -1238,7 +1238,7 @@ clock_set:
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		msleep(1);
 	}
 
 	clk |= SDHCI_CLOCK_CARD_EN;
@@ -1317,7 +1317,7 @@ static int sdhci_set_power(struct sdhci_host *host, unsigned short power)
 	 * can apply clock after applying power
 	 */
 	if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
-		mdelay(10);
+		msleep(10);
 
 	return power;
 }
@@ -1979,7 +1979,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 		tuning_loop_counter--;
 		timeout--;
-		mdelay(1);
+		msleep(1);
 	} while (ctrl & SDHCI_CTRL_EXEC_TUNING);
 
 	/*
-- 
1.7.10.4

