From: Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v3 1/9] mmc: mmci: don't pretend IP variants with only one IRQ to have two mask regs
Date: Mon, 16 Jan 2017 08:37:10 +0100
Message-ID: <1484552238-23171-2-git-send-email-andrea.merello@gmail.com>
References: <1484552238-23171-1-git-send-email-andrea.merello@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35483 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbdAPHhi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2017 02:37:38 -0500
Received: by mail-wm0-f65.google.com with SMTP id d140so12347608wmd.2
        for <linux-mmc@vger.kernel.org>; Sun, 15 Jan 2017 23:37:37 -0800 (PST)
In-Reply-To: <1484552238-23171-1-git-send-email-andrea.merello@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc: linux-mmc@vger.kernel.org, bruherrera@gmail.com, Andrea Merello <andrea.merello@gmail.com>

Currently the driver supports both devices with one and two IRQ lines.

Two mask registers are used in order to select which events have to
actually generate an interrupt on each IRQ line.

It seems that in the single-IRQ case it's assumed that the IRQs lines
are simply OR-ed, while the two mask registers are still present. The
driver still programs the two mask registers separately.

However the STM32 variant has only one IRQ, and also has only one mask
register.

This patch prepares for STM32 variant support by making the driver using
only one mask register when only one IRQ is available.

Tested only on STM32 variant. RFT for variants other than STM32

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/mmc/host/mmci.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 01a8047..597fab8 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -404,9 +404,9 @@ static void mmci_set_mask1(struct mmci_host *host, unsigned int mask)
 		mask0 |= mask;
 
 		writel(mask0, base + MMCIMASK0);
+	} else {
+		writel(mask, base + MMCIMASK1);
 	}
-
-	writel(mask, base + MMCIMASK1);
 }
 
 static void mmci_stop_data(struct mmci_host *host)
@@ -1274,12 +1274,10 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 
 	do {
 		status = readl(host->base + MMCISTATUS);
+		status &= readl(host->base + MMCIMASK0);
 
 		if (host->singleirq) {
-			if (status & readl(host->base + MMCIMASK1))
-				mmci_pio_irq(irq, dev_id);
-
-			status &= ~MCI_IRQ1MASK;
+			mmci_pio_irq(irq, dev_id);
 		}
 
 		/*
@@ -1287,7 +1285,6 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 		 * enabled) since the HW seems to be triggering the IRQ on both
 		 * edges while monitoring DAT0 for busy completion.
 		 */
-		status &= readl(host->base + MMCIMASK0);
 		writel(status, host->base + MMCICLEAR);
 
 		dev_dbg(mmc_dev(host->mmc), "irq0 (data+cmd) %08x\n", status);
@@ -1710,7 +1707,8 @@ static int mmci_probe(struct amba_device *dev,
 	spin_lock_init(&host->lock);
 
 	writel(0, host->base + MMCIMASK0);
-	writel(0, host->base + MMCIMASK1);
+	if (!host->singleirq)
+		writel(0, host->base + MMCIMASK1);
 	writel(0xfff, host->base + MMCICLEAR);
 
 	/*
@@ -1800,7 +1798,8 @@ static int mmci_remove(struct amba_device *dev)
 		mmc_remove_host(mmc);
 
 		writel(0, host->base + MMCIMASK0);
-		writel(0, host->base + MMCIMASK1);
+		if (!host->singleirq)
+			writel(0, host->base + MMCIMASK1);
 
 		writel(0, host->base + MMCICOMMAND);
 		writel(0, host->base + MMCIDATACTRL);
-- 
2.7.4

