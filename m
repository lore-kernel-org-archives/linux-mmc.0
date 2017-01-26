From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 08/13] mmc: bcm2835: split bcm2835_data_irq
Date: Fri, 27 Jan 2017 00:37:21 +0100
Message-ID: <1485473846-24537-9-git-send-email-kraxel@redhat.com>
References: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-rpi-kernel@lists.infradead.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, "maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." <bcm-kernel-feedback-list@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, "moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

pio transfers stay in irq handler.
handle finished xfers moved to threaded handler.
most bcm2835 code runs in thread context now.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/mmc/host/bcm2835.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 814812b..2bea4e0 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -171,6 +171,7 @@ struct bcm2835_host {
 	/* for threaded irq handler */
 	bool                    irq_block;
 	bool                    irq_busy;
+	bool                    irq_data;
 
 	/* DMA part */
 	struct dma_chan		*dma_chan_rx;
@@ -1025,10 +1026,10 @@ static void bcm2835_data_irq(struct bcm2835_host *host, u32 intmask)
 		return;
 
 	bcm2835_check_data_error(host, intmask);
+	if (host->data->error)
+		goto finished;
 
-	if (host->data->error) {
-		bcm2835_finish_data(host);
-	} else if (host->data->flags & MMC_DATA_WRITE) {
+	if (host->data->flags & MMC_DATA_WRITE) {
 		/* Use the block interrupt for writes after the first block */
 		host->hcfg &= ~(SDHCFG_DATA_IRPT_EN);
 		host->hcfg |= SDHCFG_BLOCK_IRPT_EN;
@@ -1038,8 +1039,22 @@ static void bcm2835_data_irq(struct bcm2835_host *host, u32 intmask)
 		bcm2835_transfer_pio(host);
 		host->blocks--;
 		if ((host->blocks == 0) || host->data->error)
-			bcm2835_finish_data(host);
+			goto finished;
 	}
+	return;
+
+finished:
+	host->hcfg &= ~(SDHCFG_DATA_IRPT_EN | SDHCFG_BLOCK_IRPT_EN);
+	writel(host->hcfg, host->ioaddr + SDHCFG);
+	return;
+}
+
+static void bcm2835_data_threaded_irq(struct bcm2835_host *host)
+{
+	if (!host->data)
+		return;
+	if ((host->blocks == 0) || host->data->error)
+		bcm2835_finish_data(host);
 }
 
 static void bcm2835_block_irq(struct bcm2835_host *host)
@@ -1098,7 +1113,8 @@ static irqreturn_t bcm2835_irq(int irq, void *dev_id)
 	if ((intmask & SDHSTS_DATA_FLAG) &&
 	    (host->hcfg & SDHCFG_DATA_IRPT_EN)) {
 		bcm2835_data_irq(host, intmask);
-		result = IRQ_HANDLED;
+		host->irq_data = true;
+		result = IRQ_WAKE_THREAD;
 	}
 
 	spin_unlock(&host->lock);
@@ -1110,19 +1126,23 @@ static irqreturn_t bcm2835_threaded_irq(int irq, void *dev_id)
 {
 	struct bcm2835_host *host = dev_id;
 	unsigned long flags;
-	bool block, busy;
+	bool block, busy, data;
 
 	spin_lock_irqsave(&host->lock, flags);
 
 	block = host->irq_block;
 	busy  = host->irq_busy;
+	data  = host->irq_data;
 	host->irq_block = false;
 	host->irq_busy  = false;
+	host->irq_data  = false;
 
 	if (block)
 		bcm2835_block_irq(host);
 	if (busy)
 		bcm2835_busy_irq(host);
+	if (data)
+		bcm2835_data_threaded_irq(host);
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-- 
1.8.3.1
