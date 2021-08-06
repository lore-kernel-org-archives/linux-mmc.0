Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E26C432BE
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 11:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 423AF611ED
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 11:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245538AbhHFLdR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Aug 2021 07:33:17 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:1555 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245528AbhHFLdQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Aug 2021 07:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1628249582; x=1659785582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fWsatgcloSsqrB7wvaudTGqBX8SMP/WQ4Wac0C232F0=;
  b=e8hZ4ueFyO6teZum9nhCHDkbCtB6S67QBWybCBvrwsD16sOCsnoNPzy3
   tKbBWywoev7MtYZh4r8+b1TL+/Xd4JoUx62BsOUMC1SAAK95/OAs8nUp/
   u91PqBqJYu5c9j3c1HBMGlDq+LVoKt+HzUS2B/FWfJDymz7dbN67un5zC
   bntEb0+rYM0uPF0CgH5VUYv3+wloZSEskd65GmDAxlZJOrfwBRmxxTjX/
   C7G9k9tQUlSTqmBPG9nlKBDc+vAc+EwdWYqyBF859vdTsWpwneKXiu+ud
   XmcgCuNHhmir7le7pF9p/vBOqdtMlI6EhlXUsPYy0/nAJRdfrwyt3LQd/
   A==;
IronPort-SDR: bLp8kW0I9z1F93DdPPuNjojyxZDjb+egPuLsdA5Ba4GDPvR5RSlo/NawHzsOEH+cTFGaho2RL9
 bLBiIZk+UVKkBzl/wuFZHbmsGKbeANhzaRXg6x2U4ETLKnM+skKspJprOWJxEjhzHSljqtaMy3
 pfGXjmS75yJTdFMFoUTFfJ9/roCnOXT9k378tu7jjhs5edI66f8Pp5OMxUXlTQN83+tYczUH2+
 wpd9vGjXp19w488lItv3tgXxj095UkR67evJHKE2z5wL4rnptCSK/DaRcnINCmeMFUv63Ouc/6
 ZglEM+fddHGkQ8kckxJ16HQ2
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="131292925"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Aug 2021 04:33:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 6 Aug 2021 04:32:59 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 6 Aug 2021 04:32:53 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/4] mmc: pwrseq: add wilc1000_sdio dependency for pwrseq_sd8787
Date:   Fri, 6 Aug 2021 14:30:00 +0300
Message-ID: <20210806113001.821660-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806113001.821660-1-claudiu.beznea@microchip.com>
References: <20210806113001.821660-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

pwseq_sd8787 could also be used with wilc1000_sdio driver. Add
a dependency for this.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/mmc/core/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index ae8b69aee619..6f25c34e4fec 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -15,7 +15,7 @@ config PWRSEQ_EMMC
 
 config PWRSEQ_SD8787
 	tristate "HW reset support for SD8787 BT + Wifi module"
-	depends on OF && (MWIFIEX || BT_MRVL_SDIO || LIBERTAS_SDIO)
+	depends on OF && (MWIFIEX || BT_MRVL_SDIO || LIBERTAS_SDIO || WILC1000_SDIO)
 	help
 	  This selects hardware reset support for the SD8787 BT + Wifi
 	  module. By default this option is set to n.
-- 
2.25.1

