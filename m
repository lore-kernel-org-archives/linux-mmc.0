Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA6EC4338F
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 08:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E042A61247
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 08:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhHYIW0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Aug 2021 04:22:26 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:5489 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhHYIW0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Aug 2021 04:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629879702; x=1661415702;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=igfSvgjpM/C/zVr0wQV00L4OB0xMED/drnFhbg6ckWk=;
  b=E1F5LYB6x/NTz9Xdt99Hm1wt3SROVOe5mG4qb3zKPi+Irpl26rCOvPdu
   38+WMDrRVBOgRNRj6tap+7fp2oy7/XbJhG4FZULJae5QeFm9wAaJZnjrz
   jSCqSdDu+Lykn5nvvUbfQWW8ATqYOimq1dO+Lmgixwfm5sZo/xspx4I66
   r102pnNAeCk9VqbqDZ13pquvV0iZVaH8U66yXKgDfMb8E6LAqoitccfry
   LWAoXTaIy4J5DqBm28JTKMwZdJ0Sv46LGLo+CiyQc9rFRuczGVzaNdwlY
   CUGhaONn/OIjzhjhihfwLMW2lYkOTMvkOR79TitHAW70YEs7pTrj3/Pn1
   w==;
IronPort-SDR: jT4aWIwQ9QuqQaptXXMxCF7sKsB6G49hf6FB1Huw+BBM/cPlX1nPqG3VCn71AJTVesGfU0caEc
 mkUobKh2ZpQSTj4ljFFQOV4KNmf5duUuEGal6kyrLSROYZhY9lBy3At5Vxw1ZetMUTom0yPoNd
 gYDDHhS0vhDYJ36155ibBspuGUsS6VRjMG4YpqO38Q0W9jLjV+aNvOicfW+m1zIt+bJR9iUUil
 UI01OGCt8++etKng/ZxAqOBFx33578ObPTd3UommAUfSGKge77Vsi2irIcnbnC+Y/NWqJT90Tk
 ZYZl9I/LlNhMpZGtj7NUH0fF
X-IronPort-AV: E=Sophos;i="5.84,349,1620716400"; 
   d="scan'208";a="133549470"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2021 01:21:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 25 Aug 2021 01:21:39 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 25 Aug 2021 01:21:34 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>,
        kernel test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] mmc: pwrseq: sd8787: fix compilation warning
Date:   Wed, 25 Aug 2021 11:19:31 +0300
Message-ID: <20210825081931.598934-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fixed compilation warning "cast from pointer to integer of
different size [-Wpointer-to-int-cast]"

Fixes: b2832b96fcf5 ("mmc: pwrseq: sd8787: add support for wilc1000")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/mmc/core/pwrseq_sd8787.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_sd8787.c b/drivers/mmc/core/pwrseq_sd8787.c
index 264e48067af2..2e120ad83020 100644
--- a/drivers/mmc/core/pwrseq_sd8787.c
+++ b/drivers/mmc/core/pwrseq_sd8787.c
@@ -56,9 +56,12 @@ static const struct mmc_pwrseq_ops mmc_pwrseq_sd8787_ops = {
 	.power_off = mmc_pwrseq_sd8787_power_off,
 };
 
+static const u32 sd8787_delay_ms = 300;
+static const u32 wilc1000_delay_ms = 5;
+
 static const struct of_device_id mmc_pwrseq_sd8787_of_match[] = {
-	{ .compatible = "mmc-pwrseq-sd8787", .data = (void *)300 },
-	{ .compatible = "mmc-pwrseq-wilc1000", .data = (void *)5 },
+	{ .compatible = "mmc-pwrseq-sd8787", .data = &sd8787_delay_ms },
+	{ .compatible = "mmc-pwrseq-wilc1000", .data = &wilc1000_delay_ms },
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, mmc_pwrseq_sd8787_of_match);
@@ -74,7 +77,7 @@ static int mmc_pwrseq_sd8787_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	match = of_match_node(mmc_pwrseq_sd8787_of_match, pdev->dev.of_node);
-	pwrseq->reset_pwrdwn_delay_ms = (u32)match->data;
+	pwrseq->reset_pwrdwn_delay_ms = *(u32 *)match->data;
 
 	pwrseq->pwrdn_gpio = devm_gpiod_get(dev, "powerdown", GPIOD_OUT_LOW);
 	if (IS_ERR(pwrseq->pwrdn_gpio))
-- 
2.25.1

