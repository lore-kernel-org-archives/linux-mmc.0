From: Francesco Lavra <francescolavra.fl@gmail.com>
Subject: [PATCH] mmc: omap_hsmmc: clear status flags before starting a new
 command
Date: Sat, 29 Jun 2013 08:25:12 +0200
Message-ID: <51CE7DC8.2070905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Commit 1f6b9fa40e76fffaaa0b3bd6a0bfdcf1cdc06efa consolidated writes to 
the STAT register in one location, moving them from omap_hsmmc_do_irq() 
to omap_hsmmc_irq(). This move has the unwanted side effect that the 
controller status flags are potentially cleared after a new command has 
been started as a consequence of reading the previous status flags. 
This means that if the new command changes the status flags before the 
IRQ routine returns, those flags may be cleared without handling the 
event which asserted them, and thus missing the event.
Move the writing of the STAT register back in omap_hsmmc_do_irq(), 
before handling the status flags which generated the interrupt.

Signed-off-by: Francesco Lavra <francescolavra.fl@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index eccedc7..301cb7e 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1041,6 +1041,7 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 		}
 	}
 
+	OMAP_HSMMC_WRITE(host->base, STAT, status);
 	if (end_cmd || ((status & CC_EN) && host->cmd))
 		omap_hsmmc_cmd_done(host, host->cmd);
 	if ((end_trans || (status & TC_EN)) && host->mrq)
@@ -1060,7 +1061,6 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
 		omap_hsmmc_do_irq(host, status);
 
 		/* Flush posted write */
-		OMAP_HSMMC_WRITE(host->base, STAT, status);
 		status = OMAP_HSMMC_READ(host->base, STAT);
 	}
 
-- 
1.7.5.4
