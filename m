Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AB4C4320A
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 08:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F5F061B5F
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 08:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbhHPI6X (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 04:58:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:48673 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbhHPI6W (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2021 04:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629104271; x=1660640271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fWsatgcloSsqrB7wvaudTGqBX8SMP/WQ4Wac0C232F0=;
  b=WKsp2yKEJN/p+AFhr+mWiRm/gUifUZKx8OufVJZ7jeltjkAHe899avAU
   ncLU7Wroc0IeIlViGRaz+bNIAcuGg9GQFB47mypIGrWxqvmekOcyHUmq8
   SYMEaVmfuXAGyVefmdEVOsbBTVhUozPI73X6L+bVd7+/5QWQjrEYZb67+
   1RoMoTHFcuOrq+o2hkinb9GUZ5kLL013MRMY3CoUitz6119uXd5pymhKm
   tX7DOqva/fRFLdcjboH8jlLMhQRZviMWHkOBEfp6oFqVCzq0mOot5fXrN
   4HW0qsRFePDpape9sKwvjLZ29Qz3OjDGFgse3cWzjUI61RAYLqV0l7gRU
   g==;
IronPort-SDR: zoDmpNR//NEe4Gw8fOC1oIP0UG2W4XcVt8Wwqcqt16yAe4juCLQmwKgIpcsWXNj5FLF6OqFcge
 4UPMlCTLug7+P2C3ByFrGXrViJ/VSEVPsFX5JtlhzEOiYi39vN2vVMAqtQxv/0PbFSBfPzs4Eu
 U4I5HIriZDkXYvH2TL5mNEhrBQAGbWZlayFFL0rofWqqnXUn3i7PpFmdhNRikiaOHoysXSUVNn
 SO+L3hLuQgmj0jPhfIAs1dVSqDw70QOjCOKQFYaZqfDLvo1CjgmKXiu84a+On1kvzpfDlW2j3O
 pUnP7cs59dkbszqASc3IqZUI
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="125916745"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Aug 2021 01:57:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 16 Aug 2021 01:57:49 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 16 Aug 2021 01:57:46 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 3/4] mmc: pwrseq: add wilc1000_sdio dependency for pwrseq_sd8787
Date:   Mon, 16 Aug 2021 11:55:29 +0300
Message-ID: <20210816085530.1723402-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816085530.1723402-1-claudiu.beznea@microchip.com>
References: <20210816085530.1723402-1-claudiu.beznea@microchip.com>
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

