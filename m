From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] pwrseq: bind pinctrl pins before using the gpios
Date: Mon, 17 Aug 2015 12:58:07 +0100
Message-ID: <1439812687-18259-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37419 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbbHQL6h (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Aug 2015 07:58:37 -0400
Received: by wibhh20 with SMTP id hh20so78949204wib.0
        for <linux-mmc@vger.kernel.org>; Mon, 17 Aug 2015 04:58:36 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Some of the pin-controllers like the Qualcomms "qcom,pm8921", which
require a pinconf to be setup to use pins as gpios. Using the pins
directly without pinconf setup would result in incorrect output voltage
or load settings. On the other hand pwrseq code does not configure the
pinctrl by default as it does not go thru the driver core.

This patch adds a call to pinctrl_bind_pins() to bind pins which
are going to be used as gpios.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mmc/core/pwrseq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/core/pwrseq.c b/drivers/mmc/core/pwrseq.c
index 4c1d175..6e5d8b3 100644
--- a/drivers/mmc/core/pwrseq.c
+++ b/drivers/mmc/core/pwrseq.c
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/pinctrl/devinfo.h>
 
 #include <linux/mmc/host.h>
 
@@ -65,6 +66,10 @@ int mmc_pwrseq_alloc(struct mmc_host *host)
 		goto err;
 	}
 
+	ret = pinctrl_bind_pins(&pdev->dev);
+	if (ret)
+		goto err;
+
 	match = mmc_pwrseq_find(np);
 	if (IS_ERR(match)) {
 		ret = PTR_ERR(match);
-- 
1.9.1

