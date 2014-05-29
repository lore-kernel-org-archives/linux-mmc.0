From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v14 3/6] mmc: omap_hsmmc: enable wakeup event for sdio OMAP4
Date: Thu, 29 May 2014 10:28:02 +0200
Message-ID: <1401352085-22781-4-git-send-email-afenkart@gmail.com>
References: <1401352085-22781-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1401352085-22781-1-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, Andreas Mueller <schnitzeltony@googlemail.com>, Sebastian Reichel <sre@kernel.org>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Balaji T K <balajitk@ti.com>

To detect sdio irqs properly without spurious events,
OMAP4 needs IWE in CON and CTPL, CLKEXTFREE in HCTL to be set

Tested-by: Andreas Fenkart <afenkart@gmail.com>
Signed-off-by: Balaji T K <balajitk@ti.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 332d3d2..b8be438 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -94,7 +94,10 @@
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
@@ -687,6 +690,9 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 		capa = VS18;
 	}
 
+	if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
+		hctl |= IWE;
+
 	OMAP_HSMMC_WRITE(host->base, HCTL,
 			OMAP_HSMMC_READ(host->base, HCTL) | hctl);
 
@@ -1684,19 +1690,23 @@ static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
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
@@ -1746,6 +1756,8 @@ static int omap_hsmmc_configure_wake_irq(struct omap_hsmmc_host *host)
 		goto err;
 	}
 
+	OMAP_HSMMC_WRITE(host->base, HCTL,
+			 OMAP_HSMMC_READ(host->base, HCTL) | IWE);
 	return 0;
 
 err:
-- 
1.7.10.4

