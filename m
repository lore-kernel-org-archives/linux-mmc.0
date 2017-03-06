From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH v2 2/4] mmc: pwrseq-simple: Add optional op. for post_ios_power_on callback
Date: Mon,  6 Mar 2017 15:17:14 +0100
Message-ID: <20170306141716.19120-3-romain.perier@collabora.com>
References: <20170306141716.19120-1-romain.perier@collabora.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57603 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932194AbdCFORo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Mar 2017 09:17:44 -0500
In-Reply-To: <20170306141716.19120-1-romain.perier@collabora.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>, Romain Perier <romain.perier@collabora.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>

Some devices require to do their entire power sequence after that the
power supply of the MMC has been powered on. This can be done by
only implementing the optional post_ios_power_on() callback that rely on
pre_power_on/post_power_on functions, other functions being NULL. Then
we introduce a new DT property "post_ios_power_on", when this property
is set the driver will use its post_ios_power_on operations, otherwise
it fallbacks to the default operations with pre_power_on/post_power_on.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---

Changes in v2:
 - Added missing power_off function in mmc_pwrseq_post_ios_ops

 drivers/mmc/core/pwrseq_simple.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 1304160..e27019f 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -84,12 +84,23 @@ static void mmc_pwrseq_simple_power_off(struct mmc_host *host)
 	}
 }
 
+static void mmc_pwrseq_simple_post_ios_power_on(struct mmc_host *host)
+{
+	mmc_pwrseq_simple_pre_power_on(host);
+	mmc_pwrseq_simple_post_power_on(host);
+}
+
 static const struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
 	.pre_power_on = mmc_pwrseq_simple_pre_power_on,
 	.post_power_on = mmc_pwrseq_simple_post_power_on,
 	.power_off = mmc_pwrseq_simple_power_off,
 };
 
+static const struct mmc_pwrseq_ops mmc_pwrseq_post_ios_ops = {
+	.post_ios_power_on = mmc_pwrseq_simple_post_ios_power_on,
+	.power_off = mmc_pwrseq_simple_power_off,
+};
+
 static const struct of_device_id mmc_pwrseq_simple_of_match[] = {
 	{ .compatible = "mmc-pwrseq-simple",},
 	{/* sentinel */},
@@ -121,7 +132,10 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 				 &pwrseq->post_power_on_delay_ms);
 
 	pwrseq->pwrseq.dev = dev;
-	pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
+	if (device_property_read_bool(dev, "post-ios-power-on"))
+		pwrseq->pwrseq.ops = &mmc_pwrseq_post_ios_ops;
+	else
+		pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
 	pwrseq->pwrseq.owner = THIS_MODULE;
 	platform_set_drvdata(pdev, pwrseq);
 
-- 
2.9.3

