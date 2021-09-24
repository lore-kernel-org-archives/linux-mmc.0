Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7208C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 08:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91D7761090
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 08:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244748AbhIXIai (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Sep 2021 04:30:38 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:28217 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244714AbhIXIah (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Sep 2021 04:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632472145; x=1664008145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s0Vd+Quyj7mR7KcnmcjP5uqaDrSkpYZoz+nzUK8qaw4=;
  b=oLswH5okABD6Ol8no+WosajnQ17Se0Ylchv4cQgXaveFbVyehdqMt9+a
   g1KQJpXUj5uzsxY8wBS19TI6aAncGPUZmpXV/q39NRkbZB4y/wJc+JWC8
   e9pCOaeyFfQD4ZG4IcTw1+5/1ImMRqJ7y1zfw5kvcr6llpQ1IJMVdCSjG
   EIPGDcEiJMY2sTFufcqz0nv82UdRRcGMgfGQcJC1XFfhe9HKCZBWf78T0
   c9DWvxxiYI+orbGOj4awAfrGOfUNYWOhrL6Pg58DjXj+Hh7/YyXtDbxwO
   k2t+Q7DLvgJx1Xp3XZ9UBLY4G+HIkpQVS/qCaH8jcNN93T9qDYjiijaK3
   Q==;
IronPort-SDR: gEBTB9oGGglLPajqdS1Cz6HW+yCpwWV/gYj9g4GbIq4Sm2fNo8FxJmxkPl+h5UYAggwL6oRfSr
 t7T7fpdHNkN0l2XIne0f60bes+xfB7IghCeOVMvaLK95hFB5+HfofTu4BKgjBhQQ3DPOBCZzic
 xOBuM++agreU1EjptmfjLSdoEYvejtI2m6BZR+yXyva94UEe7EVMLUPZRhWhs3Mu61HDAtzP8X
 7MPdi4Pxm5VIGUcdzO6QjauS+TJfC/TWJCMfGxsi+426sCdR8WPlTPr1mJ0cyqG81bK8iJkILm
 LCjfdX4AXLOHgbmAar5e2e8r
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="130489832"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2021 01:29:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 24 Sep 2021 01:29:03 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 24 Sep 2021 01:29:01 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 1/2] mmc: sdhci-of-at91: wait for calibration done before proceed
Date:   Fri, 24 Sep 2021 11:28:50 +0300
Message-ID: <20210924082851.2132068-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924082851.2132068-1-claudiu.beznea@microchip.com>
References: <20210924082851.2132068-1-claudiu.beznea@microchip.com>
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

Hi Nicolas,

I haven't added your tag from previous version as I changed the
implementation to use read_poll_timeout().

Thank you,
Claudiu Beznea

 drivers/mmc/host/sdhci-of-at91.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 5564d7b23e7c..134ba01d3063 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/slot-gpio.h>
@@ -114,6 +115,7 @@ static void sdhci_at91_reset(struct sdhci_host *host, u8 mask)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	unsigned int tmp;
 
 	sdhci_reset(host, mask);
 
@@ -126,6 +128,10 @@ static void sdhci_at91_reset(struct sdhci_host *host, u8 mask)
 
 		sdhci_writel(host, calcr | SDMMC_CALCR_ALWYSON | SDMMC_CALCR_EN,
 			     SDMMC_CALCR);
+
+		if (read_poll_timeout(sdhci_readl, tmp, !(tmp & SDMMC_CALCR_EN),
+				      10, 20000, false, host, SDMMC_CALCR))
+			dev_err(mmc_dev(host->mmc), "Failed to calibrate\n");
 	}
 }
 
-- 
2.25.1

