Return-Path: <SRS0=GgYk=DA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4B3C4727E
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Sep 2020 10:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB8C23119
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Sep 2020 10:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GjukPfCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIWKw1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Sep 2020 06:52:27 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48520 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWKw1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Sep 2020 06:52:27 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NAqHMt128206;
        Wed, 23 Sep 2020 05:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600858337;
        bh=3vyIuumUL1jIfrP9UBuFaizXOZ/b9hpb30ojRFDP9hY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GjukPfCKs+rZeJ1Yr1RqNrBhwxwHdngPjOT58zocvtVFFFNWTmNgeKjYhCQ6rvpEK
         YuAx5DUSQ4etSwOWveqlOogNONVqiq9EPY/f7XqG6jzQGTlhW24uEpl6RIu6W+w20J
         8xEJq2x5GiftkENPG00W6qyyo5lVrkWwjQsIP+oo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08NAqHqc005502
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 05:52:17 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 05:52:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 05:52:17 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NAq7qi059762;
        Wed, 23 Sep 2020 05:52:13 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <adrian.hunter@intel.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>, <kishon@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH 1/6] dt-bindings: mmc: sdhci-am654: Convert sdhci-am654 controller documentation to json schema
Date:   Wed, 23 Sep 2020 16:22:01 +0530
Message-ID: <20200923105206.7988-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923105206.7988-1-faiz_abbas@ti.com>
References: <20200923105206.7988-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Convert sdhci-am654 documentation to yaml format. The new file
sdhci-am654.yaml will inherit from mmc-controller.yaml.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 .../devicetree/bindings/mmc/sdhci-am654.txt   |  65 -------
 .../devicetree/bindings/mmc/sdhci-am654.yaml  | 175 ++++++++++++++++++
 2 files changed, 175 insertions(+), 65 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-am654.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-am654.yaml

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.txt b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
deleted file mode 100644
index b49cbfdd679f..000000000000
--- a/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
+++ /dev/null
@@ -1,65 +0,0 @@
-Device Tree Bindings for the SDHCI Controllers present on TI's AM654 SOCs
-
-The bindings follow the mmc[1], clock[2] and interrupt[3] bindings.
-Only deviations are documented here.
-
-  [1] Documentation/devicetree/bindings/mmc/mmc.txt
-  [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
-  [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-
-Required Properties:
-	- compatible: should be one of:
-			"ti,am654-sdhci-5.1": SDHCI on AM654 device.
-			"ti,j721e-sdhci-8bit": 8 bit SDHCI on J721E device.
-			"ti,j721e-sdhci-4bit": 4 bit SDHCI on J721E device.
-			"ti,j7200-sdhci-8bit": 8 bit SDHCI on J7200 device.
-			"ti,j7200-sdhci-4bit": 4 bit SDHCI on J7200 device.
-	- reg: Must be two entries.
-		- The first should be the sdhci register space
-		- The second should the subsystem/phy register space
-	- clocks: Handles to the clock inputs.
-	- clock-names: Tuple including "clk_xin" and "clk_ahb"
-	- interrupts: Interrupt specifiers
-	Output tap delay for each speed mode:
-	- ti,otap-del-sel-legacy
-	- ti,otap-del-sel-mmc-hs
-	- ti,otap-del-sel-sd-hs
-	- ti,otap-del-sel-sdr12
-	- ti,otap-del-sel-sdr25
-	- ti,otap-del-sel-sdr50
-	- ti,otap-del-sel-sdr104
-	- ti,otap-del-sel-ddr50
-	- ti,otap-del-sel-ddr52
-	- ti,otap-del-sel-hs200
-	- ti,otap-del-sel-hs400
-	  These bindings must be provided otherwise the driver will disable the
-	  corresponding speed mode (i.e. all nodes must provide at least -legacy)
-
-Optional Properties (Required for ti,am654-sdhci-5.1,
-				  ti,j721e-sdhci-8bit,
-				  ti,j7200-sdhci-8bit):
-	- ti,trm-icp: DLL trim select
-	- ti,driver-strength-ohm: driver strength in ohms.
-				  Valid values are 33, 40, 50, 66 and 100 ohms.
-Optional Properties:
-	- ti,strobe-sel: strobe select delay for HS400 speed mode. Default value: 0x0.
-	- ti,clkbuf-sel: Clock Delay Buffer Select
-
-Example:
-
-	sdhci0: sdhci@4f80000 {
-		compatible = "ti,am654-sdhci-5.1";
-		reg = <0x0 0x4f80000 0x0 0x260>, <0x0 0x4f90000 0x0 0x134>;
-		power-domains = <&k3_pds 47>;
-		clocks = <&k3_clks 47 0>, <&k3_clks 47 1>;
-		clock-names = "clk_ahb", "clk_xin";
-		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
-		sdhci-caps-mask = <0x80000007 0x0>;
-		mmc-ddr-1_8v;
-		ti,otap-del-sel-legacy = <0x0>;
-		ti,otap-del-sel-mmc-hs = <0x0>;
-		ti,otap-del-sel-ddr52 = <0x5>;
-		ti,otap-del-sel-hs200 = <0x5>;
-		ti,otap-del-sel-hs400 = <0x0>;
-		ti,trm-icp = <0x8>;
-	};
diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
new file mode 100644
index 000000000000..c222e057eca9
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
@@ -0,0 +1,175 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/mmc/sdhci-am654.yaml#"
+$schema : "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: TI AM654 MMC Controller
+
+maintainers:
+  - Ulf Hansson <ulf.hansson@linaro.org>
+
+allOf:
+  - $ref: mmc-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ti,am654-sdhci-5.1
+      - ti,j721e-sdhci-8bit
+      - ti,j721e-sdhci-4bit
+      - ti,j7200-sdhci-8bit
+      - ti,j721e-sdhci-4bit
+
+  reg:
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+    description: Handles to input clocks
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      - const: clk_ahb
+      - const: clk_xin
+
+  # PHY output tap delays:
+  # Used to delay the data valid window and align it to the sampling clock.
+  # Binding needs to be provided for each supported speed mode otherwise the
+  # corresponding mode will be disabled.
+
+  ti,otap-del-sel-legacy:
+    description: Output tap delay for SD/MMC legacy timing
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 0xf
+
+  ti,otap-del-sel-mmc-hs:
+    description: Output tap delay for MMC high speed timing
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 0xf
+
+  ti,otap-del-sel-sd-hs:
+    description: Output tap delay for SD high speed timing
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 0xf
+
+  ti,otap-del-sel-sdr12:
+    description: Output tap delay for SD UHS SDR12 timing
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 0xf
+
+  ti,otap-del-sel-sdr25:
+    description: Output tap delay for SD UHS SDR25 timing
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 0xf
+
+  ti,otap-del-sel-sdr50:
+    description: Output tap delay for SD UHS SDR50 timing
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 0xf
+
+  ti,otap-del-sel-sdr104:
+    description: Output tap delay for SD UHS SDR104 timing
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 0xf
+
+  ti,otap-del-sel-ddr50:
+    description: Output tap delay for SD UHS DDR50 timing
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 0xf
+
+  ti,otap-del-sel-ddr52:
+    description: Output tap delay for eMMC DDR52 timing
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 0xf
+
+  ti,otap-del-sel-hs200:
+    description: Output tap delay for eMMC HS200 timing
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 0xf
+
+  ti,otap-del-sel-hs400:
+    description: Output tap delay for eMMC HS400 timing
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 0xf
+
+  ti,trm-icp:
+    description: DLL trim select
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 0xf
+
+  ti,driver-strength-ohm:
+    description: DLL drive strength in ohms
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    oneOf:
+      - enum:
+        - 33
+        - 40
+        - 50
+        - 66
+        - 100
+
+  ti,strobe-sel:
+    description: strobe select delay for HS400 speed mode.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  ti,clkbuf-sel:
+    description: Clock Delay Buffer Select
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - ti,otap-del-sel-legacy
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mmc0: mmc@4f80000 {
+            compatible = "ti,am654-sdhci-5.1";
+            reg = <0x0 0x4f80000 0x0 0x260>, <0x0 0x4f90000 0x0 0x134>;
+            power-domains = <&k3_pds 47>;
+            clocks = <&k3_clks 47 0>, <&k3_clks 47 1>;
+            clock-names = "clk_ahb", "clk_xin";
+            interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+            sdhci-caps-mask = <0x80000007 0x0>;
+            mmc-ddr-1_8v;
+            ti,otap-del-sel-legacy = <0x0>;
+            ti,otap-del-sel-mmc-hs = <0x0>;
+            ti,otap-del-sel-ddr52 = <0x5>;
+            ti,otap-del-sel-hs200 = <0x5>;
+            ti,otap-del-sel-hs400 = <0x0>;
+            ti,trm-icp = <0x8>;
+        };
+    };
-- 
2.17.1

