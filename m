From: Chris Ball <chris@printf.net>
Subject: [PATCH] mmc: sdhci-s3c: Remove use of card_tasklet, which no longer exists
Date: Wed, 04 Jun 2014 20:08:51 +0100
Message-ID: <86mwdspk58.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48347 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751760AbaFDTIz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 Jun 2014 15:08:55 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>

"mmc: sdhci: push card_tasklet into threaded irq handler" removed
the card_tasklet, but it is still in use by sdhci-s3c.c.

Signed-off-by: Chris Ball <chris@printf.net>
---
Hi,

sdhci-s3c is currently failing to build due to the removal of
card_tasklet.  I think this trivial patch might do the right
thing -- please could someone test that card detection still
works and ACK if so?  Thanks!

 drivers/mmc/host/sdhci-s3c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 781b8a9..53a32e2 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -399,7 +399,6 @@ static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
 			clk_disable_unprepare(sc->clk_io);
 #endif
 		}
-		tasklet_schedule(&host->card_tasklet);
 		spin_unlock_irqrestore(&host->lock, flags);
 	}
 }
-- 
Chris Ball   <http://printf.net/>
