From: Ido Yariv <ido@wizery.com>
Subject: [RFC 1/2] mmc: davinci: Eliminate spurious interrupts
Date: Tue, 24 Jan 2012 13:16:05 +0200
Message-ID: <1327403766-962-1-git-send-email-ido@wizery.com>
References: <4F1E9194.90608@mvista.com>
Mime-Version: 1.0
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:49336 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755692Ab2AXLQd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jan 2012 06:16:33 -0500
Received: by wics10 with SMTP id s10so2850293wic.19
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jan 2012 03:16:32 -0800 (PST)
In-Reply-To: <4F1E9194.90608@mvista.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Sekhar Nori <nsekhar@ti.com>
Cc: Ido Yariv <ido@wizery.com>

The davinci mmc interrupt handler fills the fifo, as long as the DXRDY
or DRRDY bits are set in the status register.

If interrupts fire during this loop, they will be handled by the
handler, but the interrupt controller will still buffer these. As a
result, the handler will be called again to serve these needlessly. In
order to avoid these spurious interrupts, keep interrupts masked while
filling the fifo.

Signed-off-by: Ido Yariv <ido@wizery.com>
---
 drivers/mmc/host/davinci_mmc.c |   33 +++++++++++++++++++++++++++------
 1 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 64a8325..9cea66f 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1009,12 +1009,33 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id)
 	 * by read. So, it is not unbouned loop even in the case of
 	 * non-dma.
 	 */
-	while (host->bytes_left && (status & (MMCST0_DXRDY | MMCST0_DRRDY))) {
-		davinci_fifo_data_trans(host, rw_threshold);
-		status = readl(host->base + DAVINCI_MMCST0);
-		if (!status)
-			break;
-		qstatus |= status;
+	if (host->bytes_left && (status & (MMCST0_DXRDY | MMCST0_DRRDY))) {
+		unsigned long im_val;
+
+		/*
+		 * If interrupts fire during the following loop, they will be
+		 * handled by the handler, but the PIC will still buffer these.
+		 * As a result, the handler will be called again to serve these
+		 * needlessly. In order to avoid these spurious interrupts,
+		 * keep interrupts masked during the loop.
+		 */
+		im_val = readl(host->base + DAVINCI_MMCIM);
+		writel(0, host->base + DAVINCI_MMCIM);
+
+		do {
+			davinci_fifo_data_trans(host, rw_threshold);
+			status = readl(host->base + DAVINCI_MMCST0);
+			qstatus |= status;
+		} while (host->bytes_left &&
+			 (status & (MMCST0_DXRDY | MMCST0_DRRDY)));
+
+		/*
+		 * If an interrupt is pending, it is assumed it will fire when
+		 * it is unmasked. This assumption is also taken when the MMCIM
+		 * is first set. Otherwise, writing to MMCIM after reading the
+		 * status is race-prone.
+		 */
+		writel(im_val, host->base + DAVINCI_MMCIM);
 	}
 
 	if (qstatus & MMCST0_DATDNE) {
-- 
1.7.7.5

