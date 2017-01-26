From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 04/13] mmc: bcm2835: add bcm2835_check_data_error
Date: Fri, 27 Jan 2017 00:37:17 +0100
Message-ID: <1485473846-24537-5-git-send-email-kraxel@redhat.com>
References: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752456AbdAZXhn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Jan 2017 18:37:43 -0500
In-Reply-To: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-rpi-kernel@lists.infradead.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, "maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." <bcm-kernel-feedback-list@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, "moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>

Factor out common code.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/mmc/host/bcm2835.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 6f9fb12..d25b85a 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -951,6 +951,16 @@ static void bcm2835_timeout(unsigned long data)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
+static void bcm2835_check_data_error(struct bcm2835_host *host, u32 intmask)
+{
+	if (!host->data)
+		return;
+	if (intmask & (SDHSTS_CRC16_ERROR | SDHSTS_FIFO_ERROR))
+		host->data->error = -EILSEQ;
+	if (intmask & SDHSTS_REW_TIME_OUT)
+		host->data->error = -ETIMEDOUT;
+}
+
 static void bcm2835_busy_irq(struct bcm2835_host *host, u32 intmask)
 {
 	struct device *dev = &host->pdev->dev;
@@ -1007,15 +1017,7 @@ static void bcm2835_data_irq(struct bcm2835_host *host, u32 intmask)
 	if (!host->data)
 		return;
 
-	if (intmask & (SDHSTS_CRC16_ERROR |
-		       SDHSTS_FIFO_ERROR |
-		       SDHSTS_REW_TIME_OUT)) {
-		if (intmask & (SDHSTS_CRC16_ERROR |
-			       SDHSTS_FIFO_ERROR))
-			host->data->error = -EILSEQ;
-		else
-			host->data->error = -ETIMEDOUT;
-	}
+	bcm2835_check_data_error(host, intmask);
 
 	if (host->data->error) {
 		bcm2835_finish_data(host);
@@ -1043,15 +1045,7 @@ static void bcm2835_block_irq(struct bcm2835_host *host, u32 intmask)
 		return;
 	}
 
-	if (intmask & (SDHSTS_CRC16_ERROR |
-		       SDHSTS_FIFO_ERROR |
-		       SDHSTS_REW_TIME_OUT)) {
-		if (intmask & (SDHSTS_CRC16_ERROR |
-			       SDHSTS_FIFO_ERROR))
-			host->data->error = -EILSEQ;
-		else
-			host->data->error = -ETIMEDOUT;
-	}
+	bcm2835_check_data_error(host, intmask);
 
 	if (!host->dma_desc) {
 		WARN_ON(!host->blocks);
-- 
1.8.3.1

