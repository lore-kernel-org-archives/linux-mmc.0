Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AD0C001E0
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Jul 2023 10:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbjG1K2t (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Jul 2023 06:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236122AbjG1K22 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Jul 2023 06:28:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30D24EC3;
        Fri, 28 Jul 2023 03:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690540057; x=1722076057;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LN8VqrenpBG04I8zNEEaozrOGLdfnb+5V59gS19DhGk=;
  b=BeZktLdCXXX9X7mu2ZXY0bRHzVZYa9Sm1SOPrO2xaQ3y9ellZyf9+RTC
   bO5oL+DPwfaPcpDGN2BBVzi++7zOJqYZ2f0EA3YFrj8h9O3tDlZ15h2Xy
   x3r9IpHBFWee3apzlwOjCrkvSCCCrsKs0rZy8yVq9w81tdQseC12MzljY
   vaeoARy3CrCesf+xKsHtsxEfGLfEwAo6OeSKbIj6VDpzQ5GN77Vbww7bR
   VFQttgWuDyu02Vst1nFyOm7dRZwHHcnDbMGZLYsUgiRTgNs62fNrTUoXI
   KTnJqFUClpbOue1TfCGa0lsFVi8IY+e1lGFxb/TUB2JIKOv9M59n1iqFG
   g==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="238401195"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:26:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:26:35 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:26:31 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <varshini.rajendran@microchip.com>
Subject: [PATCH v3 19/50] dt-bindings: sdhci-of-at91: add microchip,sam9x7-sdhci
Date:   Fri, 28 Jul 2023 15:56:16 +0530
Message-ID: <20230728102616.266235-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add microchip,sam9x7-sdhci to DT bindings documentation.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-atmel.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
index 69edfd4d3922..a9fb0a91245f 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
@@ -5,11 +5,13 @@ Documentation/devicetree/bindings/mmc/mmc.txt and the properties used by the
 sdhci-of-at91 driver.
 
 Required properties:
-- compatible:		Must be "atmel,sama5d2-sdhci" or "microchip,sam9x60-sdhci".
+- compatible:		Must be "atmel,sama5d2-sdhci" or "microchip,sam9x60-sdhci"
+			or "microchip,sam9x7-sdhci", "microchip,sam9x60-sdhci".
 - clocks:		Phandlers to the clocks.
 - clock-names:		Must be "hclock", "multclk", "baseclk" for
 			"atmel,sama5d2-sdhci".
 			Must be "hclock", "multclk" for "microchip,sam9x60-sdhci".
+			Must be "hclock", "multclk" for "microchip,sam9x7-sdhci".
 
 Optional properties:
 - assigned-clocks:	The same with "multclk".
-- 
2.25.1

