Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF8CC433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Sep 2021 10:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27EB061263
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Sep 2021 10:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhIOKbO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Sep 2021 06:31:14 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:24326 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbhIOKbO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Sep 2021 06:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631701795; x=1663237795;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ou5/IuCCEHLg/7BedlK6vCkNqIXckQk5gqJ5mD6Cm3U=;
  b=ScYacDD9hh/AcnuDLVFLtHmwarxBfD0wzZS9cs7XBt653yHmXzfYPlas
   8yXSDKELDsASlAQKwFYZN4UzQ+dU9NLwknoKSpobxrcwKKIV4kboFuurS
   kpnsLqhdtW68yi6whz2Oam3W8beJ5btvlyGJT+w5sCAcWXd5smXzcsfBZ
   uEVxbgzBIIyAZpKRL6OzlURcj9cu2Xg9ojpkgJs6QNvuvgGpZ7PBGw6ju
   wLj3I/eITXMdKCojtJMsVhmNFutoQjn9hE/py4Ahr+n1oR3RLMLr1K/ev
   nbZv+zA/g30mND7buxBsKdkMW68pyUakTI7T2/NohMSoBgYxJU5qOpqPW
   A==;
IronPort-SDR: 3+W0NDb2MORr77B4UPR5iVG/R/0nFdRIRHwsRkA9CJH/03xPGjoGwb6ix1UNtJPAeCVbOU8/bG
 6EdOdN0gbZFWiXZ68lrtkaSOmNGwkL6JTPCrjdJBILF6YW/zcNgYHLfNVy0YpVgjwN4jQ64uJC
 c6o5dduCWaEKP5HHFXevEI8VEUHfkHbtf36iP2uYJKrEUhZaA7yQqce+OdbtkmCoGY7mZQ+fF1
 oMsTCFu6ugkHrrJiCTVSv1xzbUTDInVF2wFLUow0jASG+JqnACpBYFzdwGA+QNG5MpjSS/Zc8W
 UfkuUltsC1J4gpqCCh0jnHSp
X-IronPort-AV: E=Sophos;i="5.85,295,1624345200"; 
   d="scan'208";a="136616764"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2021 03:29:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 15 Sep 2021 03:29:54 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 15 Sep 2021 03:29:51 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <adrian.hunter@intel.com>, <eugen.hristev@microchip.com>,
        <ulf.hansson@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] mmc: sdhci-of-at91: wait for calibration done before proceed
Date:   Wed, 15 Sep 2021 13:28:38 +0300
Message-ID: <20210915102838.8344-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Datasheet specifies that at the end of calibration the SDMMC_CALCR_EN
bit will be cleared. No commands should be send before calibration is
done.

Fixes: dbdea70f71d67 ("mmc: sdhci-of-at91: fix CALCR register being rewritten")
Fixes: 727d836a375ad ("mmc: sdhci-of-at91: add DT property to enable calibration on full reset")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/mmc/host/sdhci-of-at91.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 5564d7b23e7c..2b28711e039d 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -114,6 +114,8 @@ static void sdhci_at91_reset(struct sdhci_host *host, u8 mask)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	unsigned long timeout = jiffies + msecs_to_jiffies(20);
+	unsigned int tmp;
 
 	sdhci_reset(host, mask);
 
@@ -126,6 +128,14 @@ static void sdhci_at91_reset(struct sdhci_host *host, u8 mask)
 
 		sdhci_writel(host, calcr | SDMMC_CALCR_ALWYSON | SDMMC_CALCR_EN,
 			     SDMMC_CALCR);
+
+		do {
+			tmp = sdhci_readl(host, SDMMC_CALCR);
+		} while (time_before(jiffies, timeout) &&
+			 (tmp & SDMMC_CALCR_EN));
+
+		if (tmp & SDMMC_CALCR_EN)
+			dev_err(mmc_dev(host->mmc), "Failed to calibrate\n");
 	}
 }
 
-- 
2.25.1

