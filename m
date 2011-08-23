From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: [PATCH v2 1/1] mmc: Support of SDIO irq for dw_mmc
Date: Tue, 23 Aug 2011 18:50:02 +0530
Message-ID: <CANYdXnqfBP74Xi1SuWJh3pjrZ4h7hjrc7xE+vXL0Bw41xEbVUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53468 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab1HWNUD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Aug 2011 09:20:03 -0400
Received: by gxk21 with SMTP id 21so72960gxk.19
        for <linux-mmc@vger.kernel.org>; Tue, 23 Aug 2011 06:20:02 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Matt Fleming <matt@console-pimps.org>
Cc: linux-mmc@vger.kernel.org, Shashidhar Hiremath <shashidharh@vayavyalabs.com>

The Patch adds the support for SDIO interrupts for all slots.
It includes enabling of SDIO interrupts through dw_mci_enable_sdio_irq
and the handling of the slot specific interrupts in the Interrupt Service
Routine.

Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
---
v2:
* As per Suggestions by James Hogan
-fixed code that was disabling other interrupts.
-removed [int_mask &= 0xFFFF0000; and int_mask &= 0xFFFF0000;] as it
was unnecessary
-modified (slot->id + 16) with appropriate Macro SDMMC_INT_SDIO(i)
 drivers/mmc/host/dw_mmc.c |   35 +++++++++++++++++++++++++++++++----
 drivers/mmc/host/dw_mmc.h |    2 +-
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 66dcddb..b06f8f1 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -746,11 +746,29 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 	return present;
 }

+static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = slot->host;
+	u32 int_mask;
+
+	/* Enable/disable Slot Specific SDIO interrupt */
+	int_mask = mci_readl(host, INTMASK);
+	if (enb) {
+		mci_writel(host, INTMASK,
+			   (int_mask | (1 << SDMMC_INT_SDIO(slot->id))));
+	} else {
+		mci_writel(host, INTMASK,
+			   (int_mask & ~(1 << SDMMC_INT_SDIO(slot->id))));
+	}
+}
+
 static const struct mmc_host_ops dw_mci_ops = {
-	.request	= dw_mci_request,
-	.set_ios	= dw_mci_set_ios,
-	.get_ro		= dw_mci_get_ro,
-	.get_cd		= dw_mci_get_cd,
+	.request		= dw_mci_request,
+	.set_ios		= dw_mci_set_ios,
+	.get_ro			= dw_mci_get_ro,
+	.get_cd			= dw_mci_get_cd,
+	.enable_sdio_irq	= dw_mci_enable_sdio_irq,
 };

 static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
@@ -1179,6 +1197,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 	struct dw_mci *host = dev_id;
 	u32 status, pending;
 	unsigned int pass_count = 0;
+	int i;

 	do {
 		status = mci_readl(host, RINTSTS);
@@ -1249,6 +1268,14 @@ static irqreturn_t dw_mci_interrupt(int irq,
void *dev_id)
 			tasklet_schedule(&host->card_tasklet);
 		}

+		/* Handle SDIO Interrupts */
+		for (i = 0; i < host->num_slots; i++) {
+			struct dw_mci_slot *slot = host->slot[i];
+			if (pending & SDMMC_INT_SDIO(i)) {
+				mci_writel(host, RINTSTS, SDMMC_INT_SDIO(i));
+				mmc_signal_sdio_irq(slot->mmc);
+			}
+		}
 	} while (pass_count++ < 5);

 #ifdef CONFIG_MMC_DW_IDMAC
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 23c662a..ecf1043 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -82,7 +82,7 @@
 #define SDMMC_CTYPE_4BIT		BIT(0)
 #define SDMMC_CTYPE_1BIT		0
 /* Interrupt status & mask register defines */
-#define SDMMC_INT_SDIO			BIT(16)
+#define SDMMC_INT_SDIO(n)		BIT((16 + (n)))
 #define SDMMC_INT_EBE			BIT(15)
 #define SDMMC_INT_ACD			BIT(14)
 #define SDMMC_INT_SBE			BIT(13)
-- 
1.7.2.3


--
regards,
Shashidhar Hiremath
