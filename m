Return-Path: <SRS0=InOK=75=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084CEC433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Jun 2020 14:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB20620739
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Jun 2020 14:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Gh9RczqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbgFPOAo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:00:44 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:1290 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbgFPOAm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jun 2020 10:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592316042; x=1623852042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZwjUqHNGtzEBM75RIQXsqSv3DYyG/znHnZV28mZTKO0=;
  b=Gh9RczqW46YtK4uuFKxvZOJ+6aYfiFOdQIMvozc2bB01VskWRFDLeQLw
   ANROT1f+laJepD8Psv3XDulbkKk/OtOXd01Eej2yUXJTSswUltQJOte4p
   z3IOw+MmSsX3Se5u6sAfTTML+ZDu+ji3goKKocK5wNkPuZ0Fx/O8GBfgs
   9eLqRb3PSPuM6OgnR4V1yENvIZdZ/dKs0u2mkUxeuN2BpINGIymUwi83A
   y3Nc4GVlt1se1BMHqd+7jl1Rzbp6Nt3ptiax9XoHd64E6qlYhN8yx0zdn
   huqQ3flioW7kVTLwZh7koDW91NsvDgnruL3dSvR26wMbBZkRYH2SAYi6J
   g==;
IronPort-SDR: kHOYrxDh/iti501DLLgb1RUnDtWNU3/XOP6KmtTeF4gIOFb6SFm+Nm+Ij2FR4qNKVT84DodAnb
 EhxPalSGMDTdOreFj/VIfDPFjwNqcf3fWocPUVmpU8jTc7lsqjsGNtPkC2jUnli7tJhHgoBeD8
 vysf8Dm7tp83I81NujLoD9JUdvSb4ZtrC/RJpqHdMNTEnfcZLtGyRqJbl6khw+WDyfo0HDmN/G
 +NYWef8TmevOQwZCwP9ZmgV0DKe1/JlRcpPwtxtk7JhJr+HWAN/vfxH9WkytTrZKPUS+WROZZH
 psQ=
X-IronPort-AV: E=Sophos;i="5.73,518,1583218800"; 
   d="scan'208";a="78647033"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jun 2020 07:00:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 16 Jun 2020 07:00:35 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 16 Jun 2020 07:00:29 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
List-Id: <soc.lore.kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 1/3] dt-bindings: mmc: Add Sparx5 SDHCI controller bindings
Date:   Tue, 16 Jun 2020 16:00:25 +0200
Message-ID: <20200616140027.4949-2-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616140027.4949-1-lars.povlsen@microchip.com>
References: <20200616140027.4949-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The Sparx5 SDHCI controller is based on the Designware controller IP.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 .../mmc/microchip,dw-sparx5-sdhci.yaml        | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml

diff --git a/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml b/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
new file mode 100644
index 0000000000000..55883290543b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
@@ -0,0 +1,65 @@
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
+  microchip,clock-delay:
+    description: Delay clock to card to meet setup time requirements.
+      Each step increase by 1.25ns.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 1
+    maximum: 15
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
+        microchip,clock-delay = <10>;
+    };
-- 
2.27.0

