Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A828CA0EC3
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Sep 2023 21:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242444AbjIKVUQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242427AbjIKPds (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Sep 2023 11:33:48 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57706F2;
        Mon, 11 Sep 2023 08:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694446424; x=1725982424;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y8/X2toomNzvxoxHi8EdI1y8D24G0beJjKSZXFYUGy4=;
  b=RLYjn7nrW24xPWBjO2unP2zMmOCIGjrMXxsxxQccBsTdXvlAfwexjdeX
   z24RNM2ccvFopKtxE7Dy78z6Q+3apoIUqtmRxNZu0dA+Hhcrg1N2WceKC
   ppkDErjjHzRQkYXz4o4MeSYPSkkORRNJaZq+75n9kkBppfLJJ4g8OfLIv
   4hZhPa495SCbW50MrtUf0MM4e4gg68xeAj+7pv4A0oKMi3rr6IbYVZf5c
   eGDg1yfCN7aJm59vSAM1fqYGMFEgirxsZAN1mxm4zib2RhITKlZyai4Ax
   brfcvkyYpVBG4Ar387UgShFVhP4gbLexhtQyQyiKBOE10TL9CroEa/rJc
   g==;
X-CSE-ConnectionGUID: W9j6xfGaTBmAmasmwd7qhQ==
X-CSE-MsgGUID: HX/BBuhdTgyFZbgETdRxwA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="234543992"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 08:33:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 11 Sep 2023 08:33:43 -0700
Received: from ROU-LL-M51280.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 11 Sep 2023 08:33:41 -0700
From:   Aubin Constans <aubin.constans@microchip.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Hari Prasath Gujulan Elango <hari.prasathge@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Aubin Constans <aubin.constans@microchip.com>
Subject: [PATCH] MAINTAINERS: mmc: take over as maintainer of MCI & SDHCI MICROCHIP DRIVERS
Date:   Mon, 11 Sep 2023 17:32:46 +0200
Message-ID: <20230911153246.137148-1-aubin.constans@microchip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On the one hand Eugen has taken responsibilities outside Microchip,
on the other hand I have some experience with the Microchip SDMMC
SDHCI controller.
Change Eugen as reviewer and take over maintainership of the SDHCI
MICROCHIP DRIVER.
Also, take over maintainership of its predecessor, that is the MCI
MICROCHIP DRIVER.

Cc: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Aubin Constans <aubin.constans@microchip.com>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2833e2da63e0..52beaf4f7fbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14022,7 +14022,7 @@ F:	Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
 F:	drivers/iio/adc/mcp3911.c
 
 MICROCHIP MMC/SD/SDIO MCI DRIVER
-M:	Ludovic Desroches <ludovic.desroches@microchip.com>
+M:	Aubin Constans <aubin.constans@microchip.com>
 S:	Maintained
 F:	drivers/mmc/host/atmel-mci.c
 
@@ -19235,7 +19235,8 @@ F:	Documentation/devicetree/bindings/mmc/sdhci-common.yaml
 F:	drivers/mmc/host/sdhci*
 
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) MICROCHIP DRIVER
-M:	Eugen Hristev <eugen.hristev@microchip.com>
+M:	Aubin Constans <aubin.constans@microchip.com>
+R:	Eugen Hristev <eugen.hristev@collabora.com>
 L:	linux-mmc@vger.kernel.org
 S:	Supported
 F:	drivers/mmc/host/sdhci-of-at91.c
-- 
2.39.2

