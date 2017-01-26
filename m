From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 07/13] mmc: bcm2835: call bcm2835_busy_irq from irqthread
Date: Fri, 27 Jan 2017 00:37:20 +0100
Message-ID: <1485473846-24537-8-git-send-email-kraxel@redhat.com>
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
 drivers/mmc/host/bcm2835.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 33eaebd..814812b 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -170,6 +170,7 @@ struct bcm2835_host {
 
 	/* for threaded irq handler */
 	bool                    irq_block;
+	bool                    irq_busy;
 
 	/* DMA part */
 	struct dma_chan		*dma_chan_rx;
@@ -996,28 +997,19 @@ static void bcm2835_check_data_error(struct bcm2835_host *host, u32 intmask)
 		host->data->error = -ETIMEDOUT;
 }
 
-static void bcm2835_busy_irq(struct bcm2835_host *host, u32 intmask)
+static void bcm2835_busy_irq(struct bcm2835_host *host)
 {
-	struct device *dev = &host->pdev->dev;
-
-	if (!host->cmd) {
-		dev_err(dev, "got command busy interrupt 0x%08x even though no command operation was in progress.\n",
-			(unsigned int)intmask);
+	if (WARN_ON(!host->cmd)) {
 		bcm2835_dumpregs(host);
 		return;
 	}
 
-	if (!host->use_busy) {
-		dev_err(dev, "got command busy interrupt 0x%08x even though not expecting one.\n",
-			(unsigned int)intmask);
+	if (WARN_ON(!host->use_busy)) {
 		bcm2835_dumpregs(host);
 		return;
 	}
 	host->use_busy = false;
 
-	if (bcm2835_check_cmd_error(host, intmask))
-		return;
-
 	bcm2835_finish_command(host, NULL);
 }
 
@@ -1091,8 +1083,12 @@ static irqreturn_t bcm2835_irq(int irq, void *dev_id)
 	}
 
 	if (intmask & SDHSTS_BUSY_IRPT) {
-		bcm2835_busy_irq(host, intmask);
-		result = IRQ_HANDLED;
+		if (!bcm2835_check_cmd_error(host, intmask)) {
+			host->irq_busy = true;
+			result = IRQ_WAKE_THREAD;
+		} else {
+			result = IRQ_HANDLED;
+		}
 	}
 
 	/* There is no true data interrupt status bit, so it is
@@ -1114,15 +1110,19 @@ static irqreturn_t bcm2835_threaded_irq(int irq, void *dev_id)
 {
 	struct bcm2835_host *host = dev_id;
 	unsigned long flags;
-	bool block;
+	bool block, busy;
 
 	spin_lock_irqsave(&host->lock, flags);
 
 	block = host->irq_block;
+	busy  = host->irq_busy;
 	host->irq_block = false;
+	host->irq_busy  = false;
 
 	if (block)
 		bcm2835_block_irq(host);
+	if (busy)
+		bcm2835_busy_irq(host);
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-- 
1.8.3.1
