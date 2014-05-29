From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v14 4/6] mmc: omap_hsmmc: abort runtime suspend if pending sdio irq detected
Date: Thu, 29 May 2014 10:28:03 +0200
Message-ID: <1401352085-22781-5-git-send-email-afenkart@gmail.com>
References: <1401352085-22781-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1401352085-22781-1-git-send-email-afenkart@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, Andreas Mueller <schnitzeltony@googlemail.com>, Sebastian Reichel <sre@kernel.org>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On multicores, an sdio irq handler could be running in parallel to
runtime suspend. In the worst case it could be waiting for the spinlock
held by the runtime suspend. When runtime suspend is complete and the
functional clock (fclk) turned off, the irq handler will continue and
cause a SIGBUS on the first register access.

Acked-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index b8be438..2408ec9 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -107,6 +107,9 @@
 #define SRD			(1 << 26)
 #define SOFTRESET		(1 << 1)
 
+/* PSTATE */
+#define DLEV_DAT(x)		(1 << (20 + (x)))
+
 /* Interrupt masks for IE and ISE register */
 #define CC_EN			(1 << 0)
 #define TC_EN			(1 << 1)
@@ -2397,6 +2400,7 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
 {
 	struct omap_hsmmc_host *host;
 	unsigned long flags;
+	int ret = 0;
 
 	host = platform_get_drvdata(to_platform_device(dev));
 	omap_hsmmc_context_save(host);
@@ -2408,14 +2412,29 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
 		/* disable sdio irq handling to prevent race */
 		OMAP_HSMMC_WRITE(host->base, ISE, 0);
 		OMAP_HSMMC_WRITE(host->base, IE, 0);
-		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
+
+		if (!(OMAP_HSMMC_READ(host->base, PSTATE) & DLEV_DAT(1))) {
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

