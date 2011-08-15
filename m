From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 3/4] mmc: tmio, sdhi: Provide separate interrupt hadnlers
Date: Mon, 15 Aug 2011 14:51:27 +0900
Message-ID: <1313387488-28175-4-git-send-email-horms@verge.net.au>
References: <1313387488-28175-1-git-send-email-horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1313387488-28175-1-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Provide separate interrupt handlers which may be used by platforms where
SDHI has three interrupt sources.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 drivers/mmc/host/tmio_mmc.h     |    3 +++
 drivers/mmc/host/tmio_mmc_pio.c |   35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index eeaf643..647a24c 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -93,6 +93,9 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host);
 void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 irqreturn_t tmio_mmc_irq(int irq, void *devid);
+irqreturn_t tmio_mmc_card_access_irq(int irq, void *devid);
+irqreturn_t tmio_mmc_card_detect_irq(int irq, void *devid);
+irqreturn_t tmio_mmc_sdio_irq(int irq, void *devid);
 
 static inline char *tmio_mmc_kmap_atomic(struct scatterlist *sg,
 					 unsigned long *flags)
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 3880750..322aa1b 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -570,6 +570,18 @@ static void __tmio_mmc_card_detect_irq(struct tmio_mmc_host *host,
 	}
 }
 
+irqreturn_t tmio_mmc_card_detect_irq(int irq, void *devid)
+{
+	unsigned int ireg, irq_mask, status;
+	struct tmio_mmc_host *host = devid;
+
+	pr_debug("MMC Card Detect IRQ begin\n");
+	tmio_mmc_card_irq_status(host, &ireg, &irq_mask, &status);
+	__tmio_mmc_card_detect_irq(host, ireg, irq_mask, status);
+
+	return IRQ_HANDLED;
+}
+
 void __tmio_mmc_card_access_irq(struct tmio_mmc_host *host,
 				int ireg, int irq_mask, int status)
 {
@@ -594,12 +606,23 @@ void __tmio_mmc_card_access_irq(struct tmio_mmc_host *host,
 	}
 }
 
-static void __tmio_mmc_card_irq(struct tmio_mmc_host *host)
+irqreturn_t tmio_mmc_card_access_irq(int irq, void *devid)
 {
 	unsigned int ireg, irq_mask, status;
+	struct tmio_mmc_host *host = devid;
 
+	pr_debug("MMC Card Access IRQ begin\n");
 	tmio_mmc_card_irq_status(host, &ireg, &irq_mask, &status);
+	__tmio_mmc_card_detect_irq(host, ireg, irq_mask, status);
 
+	return IRQ_HANDLED;
+}
+
+static void __tmio_mmc_card_irq(struct tmio_mmc_host *host)
+{
+	unsigned int ireg, irq_mask, status;
+
+	tmio_mmc_card_irq_status(host, &ireg, &irq_mask, &status);
 	__tmio_mmc_card_detect_irq(host, ireg, irq_mask, status);
 	__tmio_mmc_card_access_irq(host, ireg, irq_mask, status);
 }
@@ -623,6 +646,16 @@ static void __tmio_mmc_sdio_irq(struct tmio_mmc_host *host)
 		mmc_signal_sdio_irq(mmc);
 }
 
+irqreturn_t tmio_mmc_sdio_irq(int irq, void *devid)
+{
+	struct tmio_mmc_host *host = devid;
+
+	pr_debug("MMC SDIO IRQ begin\n");
+	__tmio_mmc_sdio_irq(host);
+
+	return IRQ_HANDLED;
+}
+
 irqreturn_t tmio_mmc_irq(int irq, void *devid)
 {
 	struct tmio_mmc_host *host = devid;
-- 
1.7.5.4

