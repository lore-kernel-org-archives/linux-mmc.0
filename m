From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 03/13] mmc: bcm2835: add bcm2835_threaded_irq
Date: Fri, 27 Jan 2017 00:37:16 +0100
Message-ID: <1485473846-24537-4-git-send-email-kraxel@redhat.com>
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
 drivers/mmc/host/bcm2835.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index ffb9140..6f9fb12 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1105,6 +1105,11 @@ static irqreturn_t bcm2835_irq(int irq, void *dev_id)
 	return result;
 }
 
+static irqreturn_t bcm2835_threaded_irq(int irq, void *dev_id)
+{
+	return IRQ_HANDLED;
+}
+
 void bcm2835_set_clock(struct bcm2835_host *host, unsigned int clock)
 {
 	int div = 0; /* Initialized for compiler warning */
@@ -1405,8 +1410,9 @@ int bcm2835_add_host(struct bcm2835_host *host)
 
 	bcm2835_reset_internal(host);
 
-	ret = request_irq(host->irq, bcm2835_irq, 0 /*IRQF_SHARED*/,
-			  mmc_hostname(mmc), host);
+	ret = request_threaded_irq(host->irq, bcm2835_irq,
+				   bcm2835_threaded_irq,
+				   0, mmc_hostname(mmc), host);
 	if (ret) {
 		dev_err(dev, "failed to request IRQ %d: %d\n",
 			host->irq, ret);
-- 
1.8.3.1
