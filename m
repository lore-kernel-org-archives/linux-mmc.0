From: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Subject: [PATCH 7/8] sdhci: Get rid of mdelay()s where it is safe and makes sense
Date: Fri, 24 May 2013 18:00:41 +0200
Message-ID: <1369411242-20515-8-git-send-email-jeremie.samuel.ext@parrot.com>
References: <1369411242-20515-1-git-send-email-jeremie.samuel.ext@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:35680 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755521Ab3EXQBe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 24 May 2013 12:01:34 -0400
In-Reply-To: <1369411242-20515-1-git-send-email-jeremie.samuel.ext@parrot.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: matthieu.castet@parrot.com, gregor.boirie@parrot.com, Jeremie Samuel <jeremie.samuel.ext@parrot.com>, Anton Vorontsov <avorontsov@mvista.com>

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
index 10a7684..4a6b716 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -209,7 +209,7 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		msleep(1);
 	}
 
 	if (host->ops->platform_reset_exit)
@@ -1226,7 +1226,7 @@ clock_set:
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		msleep(1);
 	}
 
 	clk |= SDHCI_CLOCK_CARD_EN;
@@ -1300,7 +1300,7 @@ static int sdhci_set_power(struct sdhci_host *host, unsigned short power)
 	 * can apply clock after applying power
 	 */
 	if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
-		mdelay(10);
+		msleep(10);
 
 	return power;
 }
@@ -1955,7 +1955,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 		tuning_loop_counter--;
 		timeout--;
-		mdelay(1);
+		msleep(1);
 	} while (ctrl & SDHCI_CTRL_EXEC_TUNING);
 
 	/*
-- 
1.7.10.4

