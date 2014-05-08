From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v11 5/7] mmc: omap_hsmmc: abort runtime suspend if pending sdio irq detected
Date: Fri,  9 May 2014 01:20:32 +0200
Message-ID: <1399591234-13089-5-git-send-email-afenkart@gmail.com>
References: <1399591018-12930-1-git-send-email-afenkart@gmail.com>
 <1399591234-13089-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:34105 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887AbaEHXV0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 May 2014 19:21:26 -0400
In-Reply-To: <1399591234-13089-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, Andreas Mueller <schnitzeltony@googlemail.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>

On multicores, an sdio irq handler could be running in parallel to
runtime suspend. In the worst case it could be waiting for the spinlock
held by the runtime suspend. When runtime suspend is complete and the
functional clock (fclk) turned off, the irq handler will continue and
cause a SIGBUS on the first register access.

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 14857d7..47a5982 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -134,6 +134,9 @@ static void apply_clk_hack(struct device *dev)
 #define SRD			(1 << 26)
 #define SOFTRESET		(1 << 1)
 
+/* PSTATE */
+#define DLEV_DAT(x)		(1 << (20 + (x)))
+
 /* Interrupt masks for IE and ISE register */
 #define CC_EN			(1 << 0)
 #define TC_EN			(1 << 1)
@@ -2455,6 +2458,7 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
 {
 	struct omap_hsmmc_host *host;
 	unsigned long flags;
+	int ret = 0;
 
 	host = platform_get_drvdata(to_platform_device(dev));
 	omap_hsmmc_context_save(host);
@@ -2466,14 +2470,29 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
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

