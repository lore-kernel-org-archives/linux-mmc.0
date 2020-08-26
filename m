Return-Path: <SRS0=hbc/=CE=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A655EC433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Aug 2020 13:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70ED020B1F
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Aug 2020 13:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CW86bqMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgHZNB1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:01:27 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:36830 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbgHZNBW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Aug 2020 09:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1598446882; x=1629982882;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f8YseWpy5OIzvYfLWuUdbGIF6BgijGQN3Ey51pWgf6A=;
  b=CW86bqMCWPCRGl9MENfRZ2vJ3O4qhLK7Y6YEfVf0g7RGTUgAgNF6BRW4
   OINLcVGfbUeSWVpXVAcTn4YQmrqwo0bk+bFNc/7ym17WCS3mV9e4cDqRa
   jyUQtEVfdIuEl6LZ+bEu4IKwxRbr4jOHxaTilYjaSluFSXgOAKH4dovId
   kAxx0Q9ACItfml/KvB6ZdwTlY0nMUa2EUXelIEZdFEYETrCUiLFyjOr3j
   yqSS0qAB3WoL2nam00a1UIgsimHN/mwT4bNgnaknXX0H3BT/0C0uqjYqL
   uR+q3ckZCoDS8rndAkmQeIGEXgDNyaFr3ik59OV/pL57378t1g20ci1Xm
   g==;
IronPort-SDR: OY4Pz5f+cjZ6NWR6TZIvlUoTVRzvzZr6wjNCkza/dH/p2pLTRATMycA9/yHA85Hckl82iNfS3m
 mZgpaY7ZWPVOUOdFZRhn4GoADQ/6uimmffnUtil32bJEaFCULs1HqkUN2inmLuyrNiFDcR+rE9
 jbnC8V6w9zv64sRR7n20dIdQ9PyWPCDWJa71E7v0ZRBHhUkHyNjbG7Af+JiocUL8amPjewKeku
 mjRcbfwo1rt0WPoF7y+suGPLrvqgcbUjDyPQ7Vva3vtA7TVK3QEH7x8mFHEm1wyOfm564NOPvk
 A7k=
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="84799218"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2020 06:01:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 26 Aug 2020 06:00:30 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 26 Aug 2020 06:01:16 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>
Subject: [PATCH mmc-next] dt-bindings: mmc: Fix mmc node name in DT example
Date:   Wed, 26 Aug 2020 15:01:06 +0200
Message-ID: <20200826130106.22889-1-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This changes the "mmc0@600800000" node name to "mmc@600800000" to be
compliant with devicetree naming rules.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 .../devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml b/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
index c9a572863b88..55883290543b 100644
--- a/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
@@ -50,7 +50,7 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/clock/microchip,sparx5.h>
-    sdhci0: mmc0@600800000 {
+    sdhci0: mmc@600800000 {
         compatible = "microchip,dw-sparx5-sdhci";
         reg = <0x00800000 0x1000>;
         pinctrl-0 = <&emmc_pins>;
--
2.27.0
