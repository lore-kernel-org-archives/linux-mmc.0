Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DC1C4338F
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 11:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D09960FE7
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 11:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbhHFLdG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Aug 2021 07:33:06 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:1540 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238025AbhHFLdF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Aug 2021 07:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1628249571; x=1659785571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EID46DOm+2UZGwugv+D7K8O0cradNPo86JFfmDOuibE=;
  b=GSSc4hrTK0Lshr3QGYP3eL0MO7Yw6FyvaO5PC+3ejIDv3md0jmr3rDrz
   3F4Ibkzk28IXymxP2kCwbHIG3slfI7GSabhrPyuxehfBa4oh8SjjNzxNy
   ZWTX5BYw/A8NPiUpFDnsR9KLI6g6Vw5oSZ2pfWK85c/OqTsvX7+rQVZb3
   0jfRStkMipah2a2XaIUtThwetoUTdSIZ1/6YRpvwWy6kqKC6n77awderv
   Vg7pDEAa1Dvh6j8o2NGFcyd/n223yNNHd45nepg6t99edhz9EhTO9bGUV
   LDxE6feXdzHoKSD7OnZjUMY4BBVbZVFChooDAXw5SRMHLLqBC8dFloBi9
   w==;
IronPort-SDR: v+2qe6BEIeCvs6RLsU8fNwCSTymjsQqoyOzMT82Xr739l/aIrhkU97HipgqxsB8I9krCW06jSP
 VE1AT4XAK/nEAk550I/qR38CoKYtbifpLSQoP12ujfVtbdsLF56xvYxdSO3vlMLFW1RU3NoHIb
 a0w9NkS5IekCyVsOaXgTnAh3kdvewFN3YDu0oZz0baybEGXcp4n2rZi8lWGpf8S0vdCoaGPvFc
 7NLnh0sv/A6EV6Lplt77aszOwjdtdsYNGk7BxCpEq/60mVTzsgGthe/8ctfPEgjb7LhCRMvual
 Av8UUQCON2q5cqjeoVIICIyX
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="131292912"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Aug 2021 04:32:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 6 Aug 2021 04:32:49 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 6 Aug 2021 04:32:31 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/4] mmc: pwrseq: sd8787: add support for specifying the delay b/w power and reset
Date:   Fri, 6 Aug 2021 14:29:59 +0300
Message-ID: <20210806113001.821660-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806113001.821660-1-claudiu.beznea@microchip.com>
References: <20210806113001.821660-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add support to be able to specify the delay to be introduced b/w
power and reset lines on power up sequence. With this, the driver
could also be used by other WiFi chips (e.g. WILC1000/WILC3000
devices that need a delay of 5ms b/w power and reset line for
a proper powering up sequence).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/mmc/core/pwrseq_sd8787.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/pwrseq_sd8787.c b/drivers/mmc/core/pwrseq_sd8787.c
index 68a826f1c0a1..a554eefdf1b1 100644
--- a/drivers/mmc/core/pwrseq_sd8787.c
+++ b/drivers/mmc/core/pwrseq_sd8787.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/property.h>
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
 
@@ -64,6 +66,7 @@ static int mmc_pwrseq_sd8787_probe(struct platform_device *pdev)
 {
 	struct mmc_pwrseq_sd8787 *pwrseq;
 	struct device *dev = &pdev->dev;
+	int ret;
 
 	pwrseq = devm_kzalloc(dev, sizeof(*pwrseq), GFP_KERNEL);
 	if (!pwrseq)
@@ -77,6 +80,12 @@ static int mmc_pwrseq_sd8787_probe(struct platform_device *pdev)
 	if (IS_ERR(pwrseq->reset_gpio))
 		return PTR_ERR(pwrseq->reset_gpio);
 
+	ret = device_property_read_u32(dev, "reset-power-delay-ms",
+				       &pwrseq->reset_pwrdwn_delay_ms);
+	/* Keep compatibility with old devices. */
+	if (ret)
+		pwrseq->reset_pwrdwn_delay_ms = 300;
+
 	pwrseq->pwrseq.dev = dev;
 	pwrseq->pwrseq.ops = &mmc_pwrseq_sd8787_ops;
 	pwrseq->pwrseq.owner = THIS_MODULE;
-- 
2.25.1

