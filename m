From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v10 2/5] mmc: omap_hsmmc: bug: abort runtime suspend if pending sdio irq detected
Date: Mon, 28 Apr 2014 09:40:57 +0200
Message-ID: <1398670860-30695-3-git-send-email-afenkart@gmail.com>
References: <1398670860-30695-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1398670860-30695-1-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

on multicores, an sdio irq handler could be running in parallel to
runtime suspend. In the worst case it could be waiting for the spinlock
held by the runtime suspend. When runtime suspend is complete and the
functional clock (fclk) turned off, the irq handler will continue and
cause a SIGBUS on the first register access.

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 700fb91..e675042 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -56,6 +56,7 @@
 #define OMAP_HSMMC_RSP54	0x0118
 #define OMAP_HSMMC_RSP76	0x011C
 #define OMAP_HSMMC_DATA		0x0120
+#define OMAP_HSMMC_PSTATE	0x0124
 #define OMAP_HSMMC_HCTL		0x0128
 #define OMAP_HSMMC_SYSCTL	0x012C
 #define OMAP_HSMMC_STAT		0x0130
@@ -2400,6 +2401,7 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
 {
 	struct omap_hsmmc_host *host;
 	unsigned long flags;
+	int ret = 0;
 
 	host = platform_get_drvdata(to_platform_device(dev));
 	omap_hsmmc_context_save(host);
@@ -2411,14 +2413,29 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
 		/* disable sdio irq handling to prevent race */
 		OMAP_HSMMC_WRITE(host->base, ISE, 0);
 		OMAP_HSMMC_WRITE(host->base, IE, 0);
-		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
+
+		if (!(OMAP_HSMMC_READ(host->base, PSTATE) & BIT(21))) {
+			/*
+			 * dat1 line low, pending sdio irq
+			 * race condition: possible irq handler running on
+			 * multi-core, abort
+			 */
+			dev_dbg(dev, "pending sdio irq, abort suspend\n");
+			OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
+			OMAP_HSMMC_WRITE(host->base, ISE, CIRQ_EN);
+			OMAP_HSMMC_WRITE(host->base, IE, CIRQ_EN);
+			pm_runtime_mark_last_busy(dev);
+			ret = -EBUSY;
+			goto abort;
+		}
 
 		WARN_ON(host->flags & HSMMC_WAKE_IRQ_ENABLED);
 		enable_irq(host->wake_irq);
 		host->flags |= HSMMC_WAKE_IRQ_ENABLED;
 	}
+abort:
 	spin_unlock_irqrestore(&host->irq_lock, flags);
-	return 0;
+	return ret;
 }
 
 static int omap_hsmmc_runtime_resume(struct device *dev)
-- 
1.7.10.4

