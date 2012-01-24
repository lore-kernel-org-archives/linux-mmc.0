From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 01/11] mmc: simplify mmc_cd_gpio_request() by removing two parameters
Date: Tue, 24 Jan 2012 13:01:30 +0100
Message-ID: <1327406500-7233-2-git-send-email-g.liakhovetski@gmx.de>
References: <1327406500-7233-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1327406500-7233-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Calculate the IRQ number, using gpio_to_irq() and use fixed flags: trigger
on both edges. This makes two out of four arguments of the
mmc_cd_gpio_request() function redundant.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/core/cd-gpio.c  |   13 +++++++++----
 include/linux/mmc/cd-gpio.h |    3 +--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/cd-gpio.c b/drivers/mmc/core/cd-gpio.c
index 082202ae..29de31e 100644
--- a/drivers/mmc/core/cd-gpio.c
+++ b/drivers/mmc/core/cd-gpio.c
@@ -28,13 +28,17 @@ static irqreturn_t mmc_cd_gpio_irqt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-int mmc_cd_gpio_request(struct mmc_host *host, unsigned int gpio,
-			unsigned int irq, unsigned long flags)
+int mmc_cd_gpio_request(struct mmc_host *host, unsigned int gpio)
 {
 	size_t len = strlen(dev_name(host->parent)) + 4;
-	struct mmc_cd_gpio *cd = kmalloc(sizeof(*cd) + len, GFP_KERNEL);
+	struct mmc_cd_gpio *cd;
+	int irq = gpio_to_irq(gpio);
 	int ret;
 
+	if (irq < 0)
+		return irq;
+
+	cd = kmalloc(sizeof(*cd) + len, GFP_KERNEL);
 	if (!cd)
 		return -ENOMEM;
 
@@ -45,7 +49,8 @@ int mmc_cd_gpio_request(struct mmc_host *host, unsigned int gpio,
 		goto egpioreq;
 
 	ret = request_threaded_irq(irq, NULL, mmc_cd_gpio_irqt,
-				   flags, cd->label, host);
+				   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				   cd->label, host);
 	if (ret < 0)
 		goto eirqreq;
 
diff --git a/include/linux/mmc/cd-gpio.h b/include/linux/mmc/cd-gpio.h
index a8e4697..cefaba0 100644
--- a/include/linux/mmc/cd-gpio.h
+++ b/include/linux/mmc/cd-gpio.h
@@ -12,8 +12,7 @@
 #define MMC_CD_GPIO_H
 
 struct mmc_host;
-int mmc_cd_gpio_request(struct mmc_host *host, unsigned int gpio,
-			unsigned int irq, unsigned long flags);
+int mmc_cd_gpio_request(struct mmc_host *host, unsigned int gpio);
 void mmc_cd_gpio_free(struct mmc_host *host);
 
 #endif
-- 
1.7.2.5

