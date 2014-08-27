From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/4] mmc: mmci: augment driver to handle gpio descriptors
Date: Wed, 27 Aug 2014 13:00:53 +0200
Message-ID: <1409137253-25189-4-git-send-email-linus.walleij@linaro.org>
References: <1409137253-25189-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1409137253-25189-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-mmc@vger.kernel.org

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
 drivers/mmc/host/mmci.c | 53 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index e4d470704150..37a6542f056c 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1658,16 +1658,49 @@ static int mmci_probe(struct amba_device *dev,
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
+		if (!ret)
+			dev_info(mmc_dev(mmc), "got CD GPIO (table)\n");
+		else {
+			if (ret == -EPROBE_DEFER)
+				goto clk_disable;
+			else if (gpio_is_valid(plat->gpio_cd)) {
+				ret = mmc_gpio_request_cd(mmc, plat->gpio_cd, 0);
+				if (ret)
+					goto clk_disable;
+				else
+					dev_info(mmc_dev(mmc), "got CD GPIO (pdata)\n");
+			} else {
+				dev_dbg(mmc_dev(mmc),
+					"no CD GPIO in DT, table or pdata\n");
+			}
+		}
+
+		ret = mmc_gpiod_request_ro(mmc, "wp", 0, false, 0);
+		if (!ret)
+			dev_info(mmc_dev(mmc), "got WP GPIO (table)\n");
+		else {
+			if (ret == -EPROBE_DEFER)
+				goto clk_disable;
+			else if (gpio_is_valid(plat->gpio_wp)) {
+				ret = mmc_gpio_request_ro(mmc, plat->gpio_wp);
+				if (ret)
+					goto clk_disable;
+				else
+					dev_info(mmc_dev(mmc), "got WP GPIO (pdata)\n");
+			} else {
+				dev_dbg(mmc_dev(mmc),
+					"no WP GPIO in DT, table or pdata\n");
+			}
+		}
 	}
 
 	ret = devm_request_irq(&dev->dev, dev->irq[0], mmci_irq, IRQF_SHARED,
-- 
1.9.3

