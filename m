From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v11 3/7] mmc: omap_hsmmc: enable wakeup event for sdio OMAP4
Date: Fri,  9 May 2014 01:20:30 +0200
Message-ID: <1399591234-13089-3-git-send-email-afenkart@gmail.com>
References: <1399591018-12930-1-git-send-email-afenkart@gmail.com>
 <1399591234-13089-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:52467 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755909AbaEHXVQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 May 2014 19:21:16 -0400
In-Reply-To: <1399591234-13089-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, Andreas Mueller <schnitzeltony@googlemail.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

From: Balaji T K <balajitk@ti.com>

To detect sdio irqs properly without spurious events,
OMAP4 needs IWE in CON and CTPL, CLKEXTFREE in HCTL to be set

Signed-off-by: Balaji T K <balajitk@ti.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index f43a69e..f76462d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -120,7 +120,10 @@ static void apply_clk_hack(struct device *dev)
 #define BCE			(1 << 1)
 #define FOUR_BIT		(1 << 1)
 #define HSPE			(1 << 2)
+#define IWE			(1 << 24)
 #define DDR			(1 << 19)
+#define CLKEXTFREE		(1 << 16)
+#define CTPL			(1 << 11)
 #define DW8			(1 << 5)
 #define OD			0x1
 #define STAT_CLEAR		0xFFFFFFFF
@@ -713,6 +716,9 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 		capa = VS18;
 	}
 
+	if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
+		hctl |= IWE;
+
 	OMAP_HSMMC_WRITE(host->base, HCTL,
 			OMAP_HSMMC_READ(host->base, HCTL) | hctl);
 
@@ -1709,19 +1715,23 @@ static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
 static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
-	u32 irq_mask;
+	u32 irq_mask, con;
 	unsigned long flags;
 
 	spin_lock_irqsave(&host->irq_lock, flags);
 
+	con = OMAP_HSMMC_READ(host->base, CON);
 	irq_mask = OMAP_HSMMC_READ(host->base, ISE);
 	if (enable) {
 		host->flags |= HSMMC_SDIO_IRQ_ENABLED;
 		irq_mask |= CIRQ_EN;
+		con |= CTPL | CLKEXTFREE;
 	} else {
 		host->flags &= ~HSMMC_SDIO_IRQ_ENABLED;
 		irq_mask &= ~CIRQ_EN;
+		con &= ~(CTPL | CLKEXTFREE);
 	}
+	OMAP_HSMMC_WRITE(host->base, CON, con);
 	OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
 
 	/*
@@ -1773,6 +1783,8 @@ static int omap_hsmmc_configure_wake_irq(struct omap_hsmmc_host *host)
 		goto err;
 	}
 
+	OMAP_HSMMC_WRITE(host->base, HCTL,
+			 OMAP_HSMMC_READ(host->base, HCTL) | IWE);
 	return 0;
 
 err:
-- 
1.7.10.4

