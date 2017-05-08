From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/8] mmc: pwrseq_simple: Parse DTS for the power-off-delay-us property
Date: Mon,  8 May 2017 18:21:11 +0200
Message-ID: <1494260477-25163-3-git-send-email-ulf.hansson@linaro.org>
References: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33742 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbdEHQV1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 May 2017 12:21:27 -0400
Received: by mail-wm0-f48.google.com with SMTP id n198so18349347wmg.0
        for <linux-mmc@vger.kernel.org>; Mon, 08 May 2017 09:21:27 -0700 (PDT)
In-Reply-To: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wei Xu <xuwei5@hisilicon.com>, linux-arm-kernel@lists.infradead.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-mmc@vger.kernel.org

If the optional power-off-delay-us property is found, insert the
corresponding delay after asserting the GPIO during power off. This enables
a graceful shutdown sequence for some devices.

Cc: linux-mmc@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/pwrseq_simple.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 1304160..13ef162 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -27,6 +27,7 @@ struct mmc_pwrseq_simple {
 	struct mmc_pwrseq pwrseq;
 	bool clk_enabled;
 	u32 post_power_on_delay_ms;
+	u32 power_off_delay_us;
 	struct clk *ext_clk;
 	struct gpio_descs *reset_gpios;
 };
@@ -78,6 +79,10 @@ static void mmc_pwrseq_simple_power_off(struct mmc_host *host)
 
 	mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
 
+	if (pwrseq->power_off_delay_us)
+		usleep_range(pwrseq->power_off_delay_us,
+			2 * pwrseq->power_off_delay_us);
+
 	if (!IS_ERR(pwrseq->ext_clk) && pwrseq->clk_enabled) {
 		clk_disable_unprepare(pwrseq->ext_clk);
 		pwrseq->clk_enabled = false;
@@ -119,6 +124,8 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 
 	device_property_read_u32(dev, "post-power-on-delay-ms",
 				 &pwrseq->post_power_on_delay_ms);
+	device_property_read_u32(dev, "power-off-delay-us",
+				 &pwrseq->power_off_delay_us);
 
 	pwrseq->pwrseq.dev = dev;
 	pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
-- 
2.7.4

