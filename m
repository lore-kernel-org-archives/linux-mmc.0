Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFB9C77B7A
	for <linux-mmc@archiver.kernel.org>; Sat, 13 May 2023 19:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjEMTYJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 13 May 2023 15:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjEMTYH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 13 May 2023 15:24:07 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793EC2D6B
        for <linux-mmc@vger.kernel.org>; Sat, 13 May 2023 12:24:04 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 582F884702;
        Sat, 13 May 2023 21:24:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1684005842;
        bh=92/KkHrUFPsmlEpyzNI6UHWpMZzl09SAXYVO7Jek9Rw=;
        h=From:To:Cc:Subject:Date:From;
        b=S/wBBOYWezFqni6E01L+VivN1uvoD155JkZbfJogptPHZIKiVtc69FLbWKbJSgJDC
         +4gIi30qhcakCQJf677JGCeMYNYEfitGJF4sWlXa2S60Ghf8L7u9eZiFE5ZzDN7BJ+
         QQldi86ag7zlJk45wV0+4q3Eft1+hR7q70Y+TQ0JyK1uUWEG05LiYmKwkIgHh+qhw2
         0c17U+YOlTTAt3E5IgHkjHsYFXWym4/auPRcLG6Bm0bVi9nbThCe6hHB8Ib/dNgN4y
         RBxbT8I/Bo3ailuu6yI3xwM7I1x/qZLuei9XRdqej1Dubeoiq49syIXYy1iE2rTlY+
         m36BbFbNljgAA==
From:   Marek Vasut <marex@denx.de>
To:     linux-mmc@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: pwrseq: sd8787: Fix WILC CHIP_EN and RESETN toggling order
Date:   Sat, 13 May 2023 21:23:52 +0200
Message-Id: <20230513192352.479627-1-marex@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Chapter "5.3 Power-Up/Down Sequence" of WILC1000 [1] and WILC3000 [2]
states that CHIP_EN must be pulled HIGH first, RESETN second. Fix the
order of these signals in the driver.

Use the mmc_pwrseq_ops as driver data as the delay between signals is
specific to SDIO card type anyway.

[1] https://ww1.microchip.com/downloads/aemDocuments/documents/WSG/ProductDocuments/DataSheets/ATWILC1000-MR110XB-IEEE-802.11-b-g-n-Link-Controller-Module-DS70005326E.pdf
[2] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/IEEE-802.11-b-g-n-Link-Controller-Module-with-Integrated-Bluetooth-5.0-DS70005327B.pdf

Fixes: b2832b96fcf5 ("mmc: pwrseq: sd8787: add support for wilc1000")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Ajay Singh <ajay.kathat@microchip.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/core/pwrseq_sd8787.c | 34 ++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_sd8787.c b/drivers/mmc/core/pwrseq_sd8787.c
index 2e120ad83020f..0c5f5e371e1f8 100644
--- a/drivers/mmc/core/pwrseq_sd8787.c
+++ b/drivers/mmc/core/pwrseq_sd8787.c
@@ -28,7 +28,6 @@ struct mmc_pwrseq_sd8787 {
 	struct mmc_pwrseq pwrseq;
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *pwrdn_gpio;
-	u32 reset_pwrdwn_delay_ms;
 };
 
 #define to_pwrseq_sd8787(p) container_of(p, struct mmc_pwrseq_sd8787, pwrseq)
@@ -39,7 +38,7 @@ static void mmc_pwrseq_sd8787_pre_power_on(struct mmc_host *host)
 
 	gpiod_set_value_cansleep(pwrseq->reset_gpio, 1);
 
-	msleep(pwrseq->reset_pwrdwn_delay_ms);
+	msleep(300);
 	gpiod_set_value_cansleep(pwrseq->pwrdn_gpio, 1);
 }
 
@@ -51,17 +50,37 @@ static void mmc_pwrseq_sd8787_power_off(struct mmc_host *host)
 	gpiod_set_value_cansleep(pwrseq->reset_gpio, 0);
 }
 
+static void mmc_pwrseq_wilc1000_pre_power_on(struct mmc_host *host)
+{
+	struct mmc_pwrseq_sd8787 *pwrseq = to_pwrseq_sd8787(host->pwrseq);
+
+	/* The pwrdn_gpio is really CHIP_EN, reset_gpio is RESETN */
+	gpiod_set_value_cansleep(pwrseq->pwrdn_gpio, 1);
+	msleep(5);
+	gpiod_set_value_cansleep(pwrseq->reset_gpio, 1);
+}
+
+static void mmc_pwrseq_wilc1000_power_off(struct mmc_host *host)
+{
+	struct mmc_pwrseq_sd8787 *pwrseq = to_pwrseq_sd8787(host->pwrseq);
+
+	gpiod_set_value_cansleep(pwrseq->reset_gpio, 0);
+	gpiod_set_value_cansleep(pwrseq->pwrdn_gpio, 0);
+}
+
 static const struct mmc_pwrseq_ops mmc_pwrseq_sd8787_ops = {
 	.pre_power_on = mmc_pwrseq_sd8787_pre_power_on,
 	.power_off = mmc_pwrseq_sd8787_power_off,
 };
 
-static const u32 sd8787_delay_ms = 300;
-static const u32 wilc1000_delay_ms = 5;
+static const struct mmc_pwrseq_ops mmc_pwrseq_wilc1000_ops = {
+	.pre_power_on = mmc_pwrseq_wilc1000_pre_power_on,
+	.power_off = mmc_pwrseq_wilc1000_power_off,
+};
 
 static const struct of_device_id mmc_pwrseq_sd8787_of_match[] = {
-	{ .compatible = "mmc-pwrseq-sd8787", .data = &sd8787_delay_ms },
-	{ .compatible = "mmc-pwrseq-wilc1000", .data = &wilc1000_delay_ms },
+	{ .compatible = "mmc-pwrseq-sd8787", .data = &mmc_pwrseq_sd8787_ops },
+	{ .compatible = "mmc-pwrseq-wilc1000", .data = &mmc_pwrseq_wilc1000_ops },
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, mmc_pwrseq_sd8787_of_match);
@@ -77,7 +96,6 @@ static int mmc_pwrseq_sd8787_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	match = of_match_node(mmc_pwrseq_sd8787_of_match, pdev->dev.of_node);
-	pwrseq->reset_pwrdwn_delay_ms = *(u32 *)match->data;
 
 	pwrseq->pwrdn_gpio = devm_gpiod_get(dev, "powerdown", GPIOD_OUT_LOW);
 	if (IS_ERR(pwrseq->pwrdn_gpio))
@@ -88,7 +106,7 @@ static int mmc_pwrseq_sd8787_probe(struct platform_device *pdev)
 		return PTR_ERR(pwrseq->reset_gpio);
 
 	pwrseq->pwrseq.dev = dev;
-	pwrseq->pwrseq.ops = &mmc_pwrseq_sd8787_ops;
+	pwrseq->pwrseq.ops = match->data;
 	pwrseq->pwrseq.owner = THIS_MODULE;
 	platform_set_drvdata(pdev, pwrseq);
 
-- 
2.39.2

