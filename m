From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 05/13] mmc: bcm2835: call bcm2835_block_irq from irqthread
Date: Fri, 27 Jan 2017 00:37:18 +0100
Message-ID: <1485473846-24537-6-git-send-email-kraxel@redhat.com>
References: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-rpi-kernel@lists.infradead.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, "maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." <bcm-kernel-feedback-list@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, "moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/mmc/host/bcm2835.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index d25b85a..8270c76 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -168,6 +168,9 @@ struct bcm2835_host {
 	bool			use_busy:1;	/* Wait for busy interrupt */
 	bool			use_sbc:1;	/* Send CMD23 */
 
+	/* for threaded irq handler */
+	bool                    irq_block;
+
 	/* DMA part */
 	struct dma_chan		*dma_chan_rx;
 	struct dma_chan		*dma_chan_tx;
@@ -1035,18 +1038,13 @@ static void bcm2835_data_irq(struct bcm2835_host *host, u32 intmask)
 	}
 }
 
-static void bcm2835_block_irq(struct bcm2835_host *host, u32 intmask)
+static void bcm2835_block_irq(struct bcm2835_host *host)
 {
-	if (!host->data) {
-		dev_err(&host->pdev->dev,
-			"got block interrupt 0x%08x even though no data operation was in progress.\n",
-			(unsigned int)intmask);
+	if (WARN_ON(!host->data)) {
 		bcm2835_dumpregs(host);
 		return;
 	}
 
-	bcm2835_check_data_error(host, intmask);
-
 	if (!host->dma_desc) {
 		WARN_ON(!host->blocks);
 		if (host->data->error || (--host->blocks == 0))
@@ -1075,8 +1073,9 @@ static irqreturn_t bcm2835_irq(int irq, void *dev_id)
 	       host->ioaddr + SDHSTS);
 
 	if (intmask & SDHSTS_BLOCK_IRPT) {
-		bcm2835_block_irq(host, intmask);
-		result = IRQ_HANDLED;
+		bcm2835_check_data_error(host, intmask);
+		host->irq_block = true;
+		result = IRQ_WAKE_THREAD;
 	}
 
 	if (intmask & SDHSTS_BUSY_IRPT) {
@@ -1101,6 +1100,20 @@ static irqreturn_t bcm2835_irq(int irq, void *dev_id)
 
 static irqreturn_t bcm2835_threaded_irq(int irq, void *dev_id)
 {
+	struct bcm2835_host *host = dev_id;
+	unsigned long flags;
+	bool block;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	block = host->irq_block;
+	host->irq_block = false;
+
+	if (block)
+		bcm2835_block_irq(host);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
 	return IRQ_HANDLED;
 }
 
-- 
1.8.3.1
