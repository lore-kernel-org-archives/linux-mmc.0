From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 01/10 v3] mmc: simplify mmc_cd_gpio_request() by removing two parameters
Date: Thu,  9 Feb 2012 22:57:07 +0100
Message-ID: <1328824636-10553-2-git-send-email-g.liakhovetski@gmx.de>
References: <1328824636-10553-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57931 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932220Ab2BIV5W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Feb 2012 16:57:22 -0500
In-Reply-To: <1328824636-10553-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

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

