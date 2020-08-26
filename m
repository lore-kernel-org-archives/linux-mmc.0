Return-Path: <SRS0=hbc/=CE=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D46C433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Aug 2020 08:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05494208A9
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Aug 2020 08:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zsEhFUdr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgHZIjs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:39:48 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:45576 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgHZIjr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Aug 2020 04:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1598431187; x=1629967187;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7UilEZX6N8UMOqcK1xuBM/B+isb72YwMNC9fKVfrEnA=;
  b=zsEhFUdr9+rOag4hWOj+KIR0ALAsZBd+5nHzq7lhPGWvWEPMrzWoWHIA
   FGvZdpDGb3GpBpvaWE2Qte5M+woMeNxVIlA8EDF6KSC6tzshfv3kPfi3f
   yeWrku+FJm16WDa3AHrkHZ37AiUX19sihoP/BF2x0yilZ4SzyoKZGrcBR
   rHCMQNCKvsFJ2bSZn5D5WrbCnTj1SpnnFNYfERR3OkCh6y0axAlfHjDh7
   FCGbWOubXBq8khsit6NLRDxOhx5yGGAtUm8J/iPikpPmFQcmRKq0pk1Xy
   ea4quKfbMhl0BcJPckhxaf1THD73DF0s5RdQyFyMXTrR03ArP+t4Ti51X
   w==;
IronPort-SDR: /ak6Bdori/ksMhZGMPrXEVlRlQ/ZLY3EK6queoxzRhw8wbAFevdjjGfGOvWV7/JfBgXj3T8Vdm
 BrDj21ifUkPm7wte3Oe9Z4ur0MYBXi5Zu6F/6RYITPAVbmPNbf6sPezF8BEvt3zq8lkAtmSSWp
 XvyWy76sCxvd7lSJQzDwmTMi37ksxqNSAKLJz883Kw5Jr/rEh48ahWZAAoHQJvr8WOPYyqFEbu
 rzqBQUmo3y/rNNAqDEg8oRUMtNDDy4+K/QKzG+fmnUn6lgGY99WIWeMbPOSdm339RhwhUY/BwG
 umI=
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="89395507"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2020 01:39:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 26 Aug 2020 01:39:45 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 26 Aug 2020 01:38:57 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>
Subject: [PATCH] arm64: dts: sparx5: Fix Sparx5 SDHCI node name
Date:   Wed, 26 Aug 2020 10:39:24 +0200
Message-ID: <20200826083924.20116-1-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch corrects the SDHCI node name to conform with the devicetree
specification ("mmc0@600800000" => "mmc@600800000").

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index a79c5bb10ab2..d477fcb57e64 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -152,7 +152,7 @@ timer1: timer@600105000 {
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 		};

-		sdhci0: mmc0@600800000 {
+		sdhci0: mmc@600800000 {
 			compatible = "microchip,dw-sparx5-sdhci";
 			status = "disabled";
 			reg = <0x6 0x00800000 0x1000>;
--
2.27.0
