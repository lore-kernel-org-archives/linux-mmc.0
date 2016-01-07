From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v2 06/12] mmc: pwrseq: add support for power-on sequencing through DT
Date: Thu,  7 Jan 2016 16:25:49 +0800
Message-ID: <1452155155-16232-7-git-send-email-wxt@rock-chips.com>
References: <1452155155-16232-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34843 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbcAGI1V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jan 2016 03:27:21 -0500
In-Reply-To: <1452155155-16232-1-git-send-email-wxt@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-rockchip@lists.infradead.org, leecam@google.com, leozwang@google.com, keescook@google.com, Caesar Wang <wxt@rock-chips.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, Javier Martinez Canillas <javier@osg.samsung.com>, NeilBrown <neil@brown.name>

This patch enables support for power-on sequencing of SDIO
peripherals through DT.

In general, it's quite common that wifi modules and other similar
peripherals have several signals in addition to the SDIO interface that
needs wiggling before the module will power on.

For example:
we need enable wifi module power to via the WL_REG_ON
pin, we need enable it as the regulator if this pin is connected to
the gpio of cpu.

Maybe, someone will say that can pull up/down from dts.
Unfortunately some SoCs can't support pinctrl pull up/down in
internal.

Anyway, we can add this patch to supprt the power-on sequencing for
sdio.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v2:
- This fix inmmc-power-sequences, as Heiko comment on
  https://patchwork.kernel.org/patch/7903161/

 drivers/mmc/core/pwrseq_simple.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index d10538b..455dd0c 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/of_gpio.h>
 #include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/mmc/host.h>
 
@@ -24,6 +25,7 @@ struct mmc_pwrseq_simple {
 	bool clk_enabled;
 	struct clk *ext_clk;
 	struct gpio_descs *reset_gpios;
+	struct regulator *regulator;
 };
 
 static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
@@ -45,6 +47,13 @@ static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
 	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
 					struct mmc_pwrseq_simple, pwrseq);
 
+	if (!IS_ERR(pwrseq->regulator)) {
+		dev_dbg(host->parent, "Enabling external regulator\n");
+		if (regulator_enable(pwrseq->regulator))
+			dev_err(host->parent,
+				"Failed to enable external regulator\n");
+	}
+
 	if (!IS_ERR(pwrseq->ext_clk) && !pwrseq->clk_enabled) {
 		clk_prepare_enable(pwrseq->ext_clk);
 		pwrseq->clk_enabled = true;
@@ -117,6 +126,13 @@ struct mmc_pwrseq *mmc_pwrseq_simple_alloc(struct mmc_host *host,
 		goto clk_put;
 	}
 
+	pwrseq->regulator = devm_regulator_get(dev, "ext-vcc");
+	if (IS_ERR(pwrseq->regulator) &&
+	    PTR_ERR(pwrseq->regulator) != -EPROBE_DEFER) {
+		ret = PTR_ERR(pwrseq->regulator);
+		goto clk_put;
+	}
+
 	pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
 
 	return &pwrseq->pwrseq;
-- 
1.9.1

