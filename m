Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C488C4320A
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 08:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB1F61B44
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 08:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbhHPI6S (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 04:58:18 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:48673 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbhHPI6R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2021 04:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629104266; x=1660640266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hUNGvSAHMAe2Et6tQj52rv5zSHPnoXZNUtoreKoOsu4=;
  b=a2SIomSxyHg+D0kg5PF+kdS0BW5M5a1lozGO9MKKeBbFePcU2F6zci5z
   7/lyS8BPXz+11zwHTs28Ig3hBDWTTd+lsmezWZgelO5612/hVbuYEQaQM
   pCRiUNh4SiWpV00a3c4YdApPr9L2fAHOi5gZOl0P10M/fdnkyq3jvu2LZ
   Zq9UgFvl+7Ld2FeHThw8wqkpCMcRxo6qyjlSucNdB6tkYs0V2e+IyuaxM
   goGT7LaZG/s7cRl+xvWYMvj95PXNn2GCmo5cpS8VT+qKxSwxb+Ky4/vsc
   2X+ANHEHsQ+RXNf+CH2U9Hg6SVkOx9BOGbDfXs145cBwyXqu955HvOxhe
   w==;
IronPort-SDR: UtmEfJVICDtJIxpcP+p1JO8ykrsg5+R1fOdQi3OHOAg/6+Yo75Kit5PTmcUwIsDDPsji+Axaj9
 Z/gK+f4hT1+iDoF3COWCeZ4Nlkz/qDnElbkw6tXz2s8FeWjjS5iD1Wz2xOFBUw+FlLYSTb7KQN
 9naFRapcnDbpTlcX4kJBDtAHBeAfir1b/hw/k/l6R0ckE6wtLAYHQvoPKh6WxNQq+18nc0Brnu
 Iy/HkQ/Apsl+hX0135RPUYv1bCBjEXplO72wnsWJRrjCIJXyPCmKSTZKe7kLzM/YUdtlT8gCHt
 teQl+gYND+R+2xhFeWqdWQ0S
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="125916720"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Aug 2021 01:57:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 16 Aug 2021 01:57:45 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 16 Aug 2021 01:57:41 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 2/4] mmc: pwrseq: sd8787: add support for wilc1000
Date:   Mon, 16 Aug 2021 11:55:28 +0300
Message-ID: <20210816085530.1723402-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816085530.1723402-1-claudiu.beznea@microchip.com>
References: <20210816085530.1723402-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add new compatible for wilc1000 devices and specify the delay in .data
member of struct of_device_id. WILC1000, WILC3000 devices needs a minimum
of 5ms delay b/w reset and power lines.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/mmc/core/pwrseq_sd8787.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_sd8787.c b/drivers/mmc/core/pwrseq_sd8787.c
index 68a826f1c0a1..264e48067af2 100644
--- a/drivers/mmc/core/pwrseq_sd8787.c
+++ b/drivers/mmc/core/pwrseq_sd8787.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -27,6 +28,7 @@ struct mmc_pwrseq_sd8787 {
 	struct mmc_pwrseq pwrseq;
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *pwrdn_gpio;
+	u32 reset_pwrdwn_delay_ms;
 };
 
 #define to_pwrseq_sd8787(p) container_of(p, struct mmc_pwrseq_sd8787, pwrseq)
@@ -37,7 +39,7 @@ static void mmc_pwrseq_sd8787_pre_power_on(struct mmc_host *host)
 
 	gpiod_set_value_cansleep(pwrseq->reset_gpio, 1);
 
-	msleep(300);
+	msleep(pwrseq->reset_pwrdwn_delay_ms);
 	gpiod_set_value_cansleep(pwrseq->pwrdn_gpio, 1);
 }
 
@@ -55,7 +57,8 @@ static const struct mmc_pwrseq_ops mmc_pwrseq_sd8787_ops = {
 };
 
 static const struct of_device_id mmc_pwrseq_sd8787_of_match[] = {
-	{ .compatible = "mmc-pwrseq-sd8787",},
+	{ .compatible = "mmc-pwrseq-sd8787", .data = (void *)300 },
+	{ .compatible = "mmc-pwrseq-wilc1000", .data = (void *)5 },
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, mmc_pwrseq_sd8787_of_match);
@@ -64,11 +67,15 @@ static int mmc_pwrseq_sd8787_probe(struct platform_device *pdev)
 {
 	struct mmc_pwrseq_sd8787 *pwrseq;
 	struct device *dev = &pdev->dev;
+	const struct of_device_id *match;
 
 	pwrseq = devm_kzalloc(dev, sizeof(*pwrseq), GFP_KERNEL);
 	if (!pwrseq)
 		return -ENOMEM;
 
+	match = of_match_node(mmc_pwrseq_sd8787_of_match, pdev->dev.of_node);
+	pwrseq->reset_pwrdwn_delay_ms = (u32)match->data;
+
 	pwrseq->pwrdn_gpio = devm_gpiod_get(dev, "powerdown", GPIOD_OUT_LOW);
 	if (IS_ERR(pwrseq->pwrdn_gpio))
 		return PTR_ERR(pwrseq->pwrdn_gpio);
-- 
2.25.1

