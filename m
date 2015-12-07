From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] mmc: pwrseq_simple: Fix regression with optional GPIOs
Date: Mon,  7 Dec 2015 14:54:05 -0800
Message-ID: <1449528845-25189-1-git-send-email-tony@atomide.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:51388 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756784AbbLGWyK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 7 Dec 2015 17:54:10 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>

Commit ce037275861e ("mmc: pwrseq_simple: use GPIO descriptors array API")
changed the handling MMC power sequence so GPIOs no longer are optional.

This broke SDIO WLAN at least for omap5 that can't yet use the reset GPIOs
with pwrseq_simple as a wait is needed after enabling the SDIO device.

Let's fix the problem by allocating the GPIO values array during init
depending on the optional GPIOs found.

Note that depending on the board specific configuration, some of the GPIOs
can be permanently set up with pulls, so we want to keep pwrseq_simple
GPIOs optional.

Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/core/pwrseq_simple.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -24,6 +24,7 @@ struct mmc_pwrseq_simple {
 	bool clk_enabled;
 	struct clk *ext_clk;
 	struct gpio_descs *reset_gpios;
+	int *values;
 };
 
 static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
@@ -31,13 +32,15 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 {
 	int i;
 	struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
-	int values[reset_gpios->ndescs];
+
+	if (!reset_gpios || !reset_gpios->ndescs)
+		return;
 
 	for (i = 0; i < reset_gpios->ndescs; i++)
-		values[i] = value;
+		pwrseq->values[i] = value;
 
 	gpiod_set_array_value_cansleep(reset_gpios->ndescs, reset_gpios->desc,
-				       values);
+				       pwrseq->values);
 }
 
 static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
@@ -84,6 +87,7 @@ static void mmc_pwrseq_simple_free(struct mmc_host *host)
 	if (!IS_ERR(pwrseq->ext_clk))
 		clk_put(pwrseq->ext_clk);
 
+	kfree(pwrseq->values);
 	kfree(pwrseq);
 }
 
@@ -111,12 +115,20 @@ struct mmc_pwrseq *mmc_pwrseq_simple_alloc(struct mmc_host *host,
 		goto free;
 	}
 
-	pwrseq->reset_gpios = gpiod_get_array(dev, "reset", GPIOD_OUT_HIGH);
+	pwrseq->reset_gpios = gpiod_get_array_optional(dev, "reset",
+						       GPIOD_OUT_HIGH);
 	if (IS_ERR(pwrseq->reset_gpios)) {
 		ret = PTR_ERR(pwrseq->reset_gpios);
 		goto clk_put;
 	}
 
+	if (pwrseq->reset_gpios && pwrseq->reset_gpios->ndescs) {
+		pwrseq->values = kzalloc(pwrseq->reset_gpios->ndescs *
+					 sizeof(int), GFP_KERNEL);
+		if (!pwrseq->values)
+			goto clk_put;
+	}
+
 	pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
 
 	return &pwrseq->pwrseq;
-- 
2.6.2

