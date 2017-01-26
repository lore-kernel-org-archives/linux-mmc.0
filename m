From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 06/13] mmc: bcm2835: add bcm2835_check_cmd_error
Date: Fri, 27 Jan 2017 00:37:19 +0100
Message-ID: <1485473846-24537-7-git-send-email-kraxel@redhat.com>
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
 drivers/mmc/host/bcm2835.c | 58 ++++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 8270c76..33eaebd 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -954,6 +954,38 @@ static void bcm2835_timeout(unsigned long data)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
+static bool bcm2835_check_cmd_error(struct bcm2835_host *host, u32 intmask)
+{
+	struct device *dev = &host->pdev->dev;
+
+	if (!(intmask & SDHSTS_ERROR_MASK))
+		return false;
+
+	if (!host->cmd)
+		return true;
+
+	dev_err(dev, "sdhost_busy_irq: intmask %x, data %p\n",
+		intmask, host->mrq->data);
+	if (intmask & SDHSTS_CRC7_ERROR) {
+		host->cmd->error = -EILSEQ;
+	} else if (intmask & (SDHSTS_CRC16_ERROR |
+			      SDHSTS_FIFO_ERROR)) {
+		if (host->mrq->data)
+			host->mrq->data->error = -EILSEQ;
+		else
+			host->cmd->error = -EILSEQ;
+	} else if (intmask & SDHSTS_REW_TIME_OUT) {
+		if (host->mrq->data)
+			host->mrq->data->error = -ETIMEDOUT;
+		else
+			host->cmd->error = -ETIMEDOUT;
+	} else if (intmask & SDHSTS_CMD_TIME_OUT) {
+		host->cmd->error = -ETIMEDOUT;
+	}
+	bcm2835_dumpregs(host);
+	return true;
+}
+
 static void bcm2835_check_data_error(struct bcm2835_host *host, u32 intmask)
 {
 	if (!host->data)
@@ -983,30 +1015,10 @@ static void bcm2835_busy_irq(struct bcm2835_host *host, u32 intmask)
 	}
 	host->use_busy = false;
 
-	if (intmask & SDHSTS_ERROR_MASK) {
-		dev_err(dev, "sdhost_busy_irq: intmask %x, data %p\n",
-			intmask, host->mrq->data);
-		if (intmask & SDHSTS_CRC7_ERROR) {
-			host->cmd->error = -EILSEQ;
-		} else if (intmask & (SDHSTS_CRC16_ERROR |
-				    SDHSTS_FIFO_ERROR)) {
-			if (host->mrq->data)
-				host->mrq->data->error = -EILSEQ;
-			else
-				host->cmd->error = -EILSEQ;
-		} else if (intmask & SDHSTS_REW_TIME_OUT) {
-			if (host->mrq->data)
-				host->mrq->data->error = -ETIMEDOUT;
-			else
-				host->cmd->error = -ETIMEDOUT;
-		} else if (intmask & SDHSTS_CMD_TIME_OUT) {
-			host->cmd->error = -ETIMEDOUT;
-		}
+	if (bcm2835_check_cmd_error(host, intmask))
+		return;
 
-		bcm2835_dumpregs(host);
-	} else {
-		bcm2835_finish_command(host, NULL);
-	}
+	bcm2835_finish_command(host, NULL);
 }
 
 static void bcm2835_data_irq(struct bcm2835_host *host, u32 intmask)
-- 
1.8.3.1
