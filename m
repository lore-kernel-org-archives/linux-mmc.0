Return-Path: <SRS0=tDFP=7W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CE8C433E1
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 10:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82E4C207ED
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 10:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="j3putWsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgFIKUq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:20:46 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:36396 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgFIKUn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jun 2020 06:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1591698044; x=1623234044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8cI03AJ4TXO9XRAoZMEf6f6F4l5MdMXymstwuhhwB0U=;
  b=j3putWsdASJOoq8+f3Dq76WxeTen2QTpBqV39HGrNBjjS+w9+tSqfD0F
   qJEbl9nhbYB1OQWlP3ihLhGuRLSzLYvwqVo+px0n5PiIHDctk76J8eNax
   FAbLoUPQ/PWlR92DBA9t2hB4PyBwPKdSZh61XNhAEDm669It33eZZe+Ep
   xMvVkey55U3eO2wlRTYt/Y4g6/whQlX4pa5gyrQHDQ4vwaDB5DClOrCWI
   hm1Q0EfghUHGUg9XEVk/to7dZpPJMXgBtsXO5edKh3tZ374y82cZ4zWea
   jCsNzsDdta3Yko43q7hfDpNC0rOSPBpNQuzOOxQZykDD/tSOfVCBtJ3uZ
   g==;
IronPort-SDR: sMeLP4X/of0urZjLdBM+SgKHZ8Xo67K/iRtPiYb2pOuQgpPXIP/cLMs2TcxcOdJKG8CIkUh0Yd
 voYq9bcJtZ+kuCMEOJ4BCv5LF7gbKiMn8HsjTh6HrurO5KkmJTpWPmL2mgLEXU8jaPcroxe2RH
 FiWScD/mBIPf1oKZvi4G/VcNvVpYcwcTwZ8rlC40WMRbz1LbgMZsWGmN0ufTLENUPd5kjeb8+e
 KxTIMeTXq8j99/UrF6YK34eZHa6p1DKke8C48jazdW13ihc79TKt8iD7G4NXO2jvWf4euxEgpG
 bN8=
X-IronPort-AV: E=Sophos;i="5.73,491,1583218800"; 
   d="scan'208";a="78723030"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2020 03:20:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 9 Jun 2020 03:20:42 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1847.3 via Frontend Transport; Tue, 9 Jun 2020 03:20:40 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: mmc: Add Sparx5 SDHCI controller bindings
Date:   Tue, 9 Jun 2020 12:20:06 +0200
Message-ID: <20200609102008.10530-2-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609102008.10530-1-lars.povlsen@microchip.com>
References: <20200609102008.10530-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The Sparx5 SDHCI controller is based on the Designware controller IP.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 .../mmc/microchip,dw-sparx5-sdhci.yaml        | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml

diff --git a/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml b/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
new file mode 100644
index 0000000000000..a9901c4bc25d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
@@ -0,1 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/microchip,dw-sparx5-sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip Sparx5 Mobile Storage Host Controller Binding
+
+allOf:
+  - $ref: "mmc-controller.yaml"
+
+maintainers:
+  - Lars Povlsen <lars.povlsen@microchip.com>
+
+# Everything else is described in the common file
+properties:
+  compatible:
+    const: microchip,dw-sparx5-sdhci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description:
+      Handle to "core" clock for the sdhci controller.
+
+  clock-names:
+    items:
+      - const: core
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/microchip,sparx5.h>
+    sdhci0: mmc@600800000 {
+        compatible = "microchip,dw-sparx5-sdhci";
+        reg = <0x00800000 0x1000>;
+        pinctrl-0 = <&emmc_pins>;
+        pinctrl-names = "default";
+        clocks = <&clks CLK_ID_AUX1>;
+        clock-names = "core";
+        assigned-clocks = <&clks CLK_ID_AUX1>;
+        assigned-clock-rates = <800000000>;
+        interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+        bus-width = <8>;
+    };
--
Cc: Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Cc: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
