From: Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH 2/4] mmc: pwrseq-simple: add support for power down GPIO pins
Date: Thu,  1 Dec 2016 22:17:40 -0800
Message-ID: <1480659462-29536-3-git-send-email-matt@ranostay.consulting>
References: <1480659462-29536-1-git-send-email-matt@ranostay.consulting>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34246 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755727AbcLBGRr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2016 01:17:47 -0500
Received: by mail-pf0-f170.google.com with SMTP id c4so50925939pfb.1
        for <linux-mmc@vger.kernel.org>; Thu, 01 Dec 2016 22:17:46 -0800 (PST)
In-Reply-To: <1480659462-29536-1-git-send-email-matt@ranostay.consulting>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Matt Ranostay <matt@ranostay.consulting>, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>

Some devices have additional pins that control power but need to
asserted separately from reset-gpios using a defined time delay.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
---
 .../devicetree/bindings/mmc/mmc-pwrseq-simple.txt  |  2 ++
 drivers/mmc/core/pwrseq_simple.c                   | 26 +++++++++++++---------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
index 88826f7d1d38..703a714201d8 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
@@ -12,6 +12,8 @@ Optional properties:
 	at initialization and prior we start the power up procedure of the card.
 	They will be de-asserted right after the power has been provided to the
 	card.
+- pwrdn-gpios : contains a list of GPIO specifiers. The pwrdn GPIOs are asserted
+	at initialization and prior we start the power up procedure of the card.
 - clocks : Must contain an entry for the entry in clock-names.
   See ../clocks/clock-bindings.txt for details.
 - clock-names : Must include the following entry:
diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index cb2ba7b11383..adf1f7161fe3 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -30,24 +30,23 @@ struct mmc_pwrseq_simple {
 	u32 post_power_on_delay_ms;
 	struct clk *ext_clk;
 	struct gpio_descs *reset_gpios;
+	struct gpio_descs *pwrdn_gpios;
 };
 
 #define to_pwrseq_simple(p) container_of(p, struct mmc_pwrseq_simple, pwrseq)
 
 static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
+					      struct gpio_descs *gpios,
 					      int value)
 {
-	struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
-
-	if (!IS_ERR(reset_gpios)) {
+	if (!IS_ERR(gpios)) {
 		int i;
-		int values[reset_gpios->ndescs];
+		int values[gpios->ndescs];
 
-		for (i = 0; i < reset_gpios->ndescs; i++)
+		for (i = 0; i < gpios->ndescs; i++)
 			values[i] = value;
 
-		gpiod_set_array_value_cansleep(
-			reset_gpios->ndescs, reset_gpios->desc, values);
+		gpiod_set_array_value_cansleep(gpios->ndescs, gpios->desc, values);
 	}
 }
 
@@ -60,17 +59,19 @@ static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
 		pwrseq->clk_enabled = true;
 	}
 
-	mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
+	mmc_pwrseq_simple_set_gpios_value(pwrseq, pwrseq->reset_gpios, 1);
 
 	if (pwrseq->pre_power_on_delay_ms)
 		msleep(pwrseq->pre_power_on_delay_ms);
+
+	mmc_pwrseq_simple_set_gpios_value(pwrseq, pwrseq->pwrdn_gpios, 1);
 }
 
 static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
 {
 	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
 
-	mmc_pwrseq_simple_set_gpios_value(pwrseq, 0);
+	mmc_pwrseq_simple_set_gpios_value(pwrseq, pwrseq->reset_gpios, 0);
 
 	if (pwrseq->post_power_on_delay_ms)
 		msleep(pwrseq->post_power_on_delay_ms);
@@ -80,12 +81,14 @@ static void mmc_pwrseq_simple_power_off(struct mmc_host *host)
 {
 	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
 
-	mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
+	mmc_pwrseq_simple_set_gpios_value(pwrseq, pwrseq->reset_gpios, 1);
+	mmc_pwrseq_simple_set_gpios_value(pwrseq, pwrseq->pwrdn_gpios, 1);
 
 	if (!IS_ERR(pwrseq->ext_clk) && pwrseq->clk_enabled) {
 		clk_disable_unprepare(pwrseq->ext_clk);
 		pwrseq->clk_enabled = false;
 	}
+
 }
 
 static const struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
@@ -121,6 +124,9 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 		return PTR_ERR(pwrseq->reset_gpios);
 	}
 
+	pwrseq->pwrdn_gpios = devm_gpiod_get_array(dev, "pwrdn",
+							GPIOD_OUT_HIGH);
+
 	device_property_read_u32(dev, "pre-power-on-delay-ms",
 				 &pwrseq->pre_power_on_delay_ms);
 
-- 
2.7.4

