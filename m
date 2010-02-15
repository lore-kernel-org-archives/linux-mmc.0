From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 2/3] [MMCI] Pass max frequency from platform
Date: Mon, 15 Feb 2010 12:23:49 +0100
Message-ID: <1266233029-16839-1-git-send-email-linus.walleij@stericsson.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:55610 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754963Ab0BOLXw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 15 Feb 2010 06:23:52 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Linus Walleij <linus.walleij@stericsson.com>

This introduce the field f_max into the mmci_platform_data,
making it possible to pass in a desired block clocking frequency
from a board configuration. This is often more desirable than
using a module parameter. We keep the module parameter as a
fallback as well as the default frequency specified for this
parameter if a parameter is not provided.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/host/mmci.c   |   15 ++++++++++++++-
 include/linux/amba/mmci.h |    4 ++++
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 2ea7dad..9b0b763 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -807,7 +807,20 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 
 	mmc->ops = &mmci_ops;
 	mmc->f_min = (host->mclk + 511) / 512;
-	mmc->f_max = min(host->mclk, fmax);
+	/*
+	 * If the platform data supplies a maximum operating
+	 * frequency, this takes precedence. Else, we fall back
+	 * to using the module parameter, which has a (low)
+	 * default value in case it is not specified. Either
+	 * value must not exceed the clock rate into the block,
+	 * of course.
+	 */
+	if (plat->f_max)
+		mmc->f_max = min(host->mclk, plat->f_max);
+	else
+		mmc->f_max = min(host->mclk, fmax);
+	dev_dbg(mmc_dev(mmc), "clocking block at %u Hz\n", mmc->f_max);
+
 #ifdef CONFIG_REGULATOR
 	/* If we're using the regulator framework, try to fetch a regulator */
 	host->vcc = regulator_get(&dev->dev, "vmmc");
diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
index a4937a8..0c89072 100644
--- a/include/linux/amba/mmci.h
+++ b/include/linux/amba/mmci.h
@@ -9,6 +9,9 @@
 /**
  * struct mmci_platform_data - platform configuration for the MMCI
  * (also known as PL180) block.
+ * @f_max: the maximum operational frequency for this host in this
+ * platform configuration. When this is specified it takes precedence
+ * over the module parameter for the same frequency.
  * @ocr_mask: available voltages on the 4 pins from the block, this
  * is ignored if a regulator is used, see the MMC_VDD_* masks in
  * mmc/host.h
@@ -35,6 +38,7 @@
  * bidirectional channel
  */
 struct mmci_platform_data {
+	unsigned int f_max;
 	unsigned int ocr_mask;
 	u32 (*translate_vdd)(struct device *, unsigned int);
 	unsigned int (*status)(struct device *);
-- 
1.6.3.3

