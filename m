From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/4 v2] mmc: mmci: augment driver to handle gpio descriptors
Date: Wed, 27 Aug 2014 15:13:54 +0200
Message-ID: <1409145234-18761-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:46251 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933270AbaH0NN7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Aug 2014 09:13:59 -0400
Received: by mail-wi0-f177.google.com with SMTP id ho1so416579wib.10
        for <linux-mmc@vger.kernel.org>; Wed, 27 Aug 2014 06:13:58 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Russell King <linux@arm.linux.org.uk>

Currently the MMCI driver will only handle GPIO descriptors
implicitly through the device tree probe glue in mmc_of_init(),
but devices instatiated other ways such as through board files
and passing descriptors using the GPIO descriptor table will
not be able to exploit descriptors.

Augment the driver to look for a GPIO descriptor if device
tree is not used for the device, and if that doesn't work,
fall back to platform data GPIO assignment using the old
API. The end goal is to get rid of the platform data integer
GPIO assingments from the kernel.

This enable the MMCI-embedding platforms to be converted to
GPIO descritor tables.

Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Skip excess error/info/debug report prints.
---
 drivers/mmc/host/mmci.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index e4d470704150..4aec22439d0e 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1658,16 +1658,35 @@ static int mmci_probe(struct amba_device *dev,
 	writel(0, host->base + MMCIMASK1);
 	writel(0xfff, host->base + MMCICLEAR);
 
-	/* If DT, cd/wp gpios must be supplied through it. */
-	if (!np && gpio_is_valid(plat->gpio_cd)) {
-		ret = mmc_gpio_request_cd(mmc, plat->gpio_cd, 0);
-		if (ret)
-			goto clk_disable;
-	}
-	if (!np && gpio_is_valid(plat->gpio_wp)) {
-		ret = mmc_gpio_request_ro(mmc, plat->gpio_wp);
-		if (ret)
-			goto clk_disable;
+	/*
+	 * If:
+	 * - not using DT but using a descriptor table, or
+	 * - using a table of descriptors ALONGSIDE DT, or
+	 * look up these descriptors named "cd" and "wp" right here, fail
+	 * silently of these do not exist and proceed to try platform data
+	 */
+	if (!np) {
+		ret = mmc_gpiod_request_cd(mmc, "cd", 0, false, 0);
+		if (ret < 0) {
+			if (ret == -EPROBE_DEFER)
+				goto clk_disable;
+			else if (gpio_is_valid(plat->gpio_cd)) {
+				ret = mmc_gpio_request_cd(mmc, plat->gpio_cd, 0);
+				if (ret)
+					goto clk_disable;
+			}
+		}
+
+		ret = mmc_gpiod_request_ro(mmc, "wp", 0, false, 0);
+		if (ret < 0) {
+			if (ret == -EPROBE_DEFER)
+				goto clk_disable;
+			else if (gpio_is_valid(plat->gpio_wp)) {
+				ret = mmc_gpio_request_ro(mmc, plat->gpio_wp);
+				if (ret)
+					goto clk_disable;
+			}
+		}
 	}
 
 	ret = devm_request_irq(&dev->dev, dev->irq[0], mmci_irq, IRQF_SHARED,
-- 
1.9.3

