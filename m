Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703E1C4338F
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Aug 2021 09:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F2726113E
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Aug 2021 09:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbhHTJbV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Aug 2021 05:31:21 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:45278 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237007AbhHTJbO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Aug 2021 05:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629451837; x=1660987837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hUNGvSAHMAe2Et6tQj52rv5zSHPnoXZNUtoreKoOsu4=;
  b=JMXx0k5WsRKqxN4ksn2BWLUMOV+5ulpU9g9cRsr1Ucq80Qvj6s5t6i26
   5+oENnEFrEP1dpzxOkKgfXWocU1sVQjKJiOa0JzHEuBTbkKwAjDYx2Pwo
   Z8K4ZPfXnIKbRuq2dWak0LnJgS+5CugCc4A/GXXMvCThbqPvvFxEZUHU1
   6VYzVAeN866uNDVzciexBYA4kIb0i+I6P7OwvvaOS3vrP64YP7itWs8T3
   IjXrNBfvkra2MQTRpGDusRMTzYfMWcUdMpKM0vgtM8OgYnO2X7ebSZMO9
   DfuQI5F8i0iMOwlp4qoNrebqkk3XRfflvC2wHepPJDWSTK6viAiLmQoZr
   A==;
IronPort-SDR: EfhMhASO24UbhZMuUOmS+buAgVdrppmUaF0CYAREAOb7+A1EiyC3sO2A6ppK8uckzJf/fXvoQd
 w0XC4jPUEuYumP3p0llLQtWyzrlBI+SCxwflA7aH9y+E+4UbgRJb9HqTGMw1SAIPt21LieOaPw
 CU0/bvfv/klyb7tUfZoh+5jxYUifDsk3DJSm6wZf9xnw6J660LdyO6SbzDKBZqoX9Bwop/xXMa
 izzvykssVAHHg8Js9abglQJ+ofYPx8JpnGp4z7upOiYGUceIAaAITkzoro4dACUMc/lEQ0gGd+
 d/LsWyZ1UUpVXNCx9kuWe0q4
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="140927386"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2021 02:30:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 20 Aug 2021 02:30:34 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 20 Aug 2021 02:30:29 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 2/4] mmc: pwrseq: sd8787: add support for wilc1000
Date:   Fri, 20 Aug 2021 12:28:01 +0300
Message-ID: <20210820092803.78523-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820092803.78523-1-claudiu.beznea@microchip.com>
References: <20210820092803.78523-1-claudiu.beznea@microchip.com>
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

