Return-Path: <SRS0=hQtV=4K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C1AC35672
	for <linux-mmc@archiver.kernel.org>; Sat, 22 Feb 2020 11:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69ADA206EF
	for <linux-mmc@archiver.kernel.org>; Sat, 22 Feb 2020 11:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="PNIDnbjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgBVL0c (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 22 Feb 2020 06:26:32 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:23006 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgBVL0b (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Feb 2020 06:26:31 -0500
X-Greylist: delayed 114357 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Feb 2020 06:26:30 EST
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 01MBPiNS007850;
        Sat, 22 Feb 2020 20:25:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 01MBPiNS007850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582370745;
        bh=eXDfPRFxogywQqOMeY/U+G4h/BSruC6jLHkszgzRqkE=;
        h=From:To:Cc:Subject:Date:From;
        b=PNIDnbjhGTxyWhYNsljipr3Yqg6frgIECAzLzYlcG0pdOioG+oCJmo97l9MlMxWXg
         Zhf81tCfdaY5LMXuENpGh8Y2rku/dMVLor/DpuCiKTdkKJtiGIFF+nnfWSgHgxS2BI
         UYuqEchS+8+XsD5d+1G41ZcvJTxDEq3X9hE/z1Aqq54sK7/cO6kTFLxB7r2rPotBl6
         EjqNPjdzx6Ysb1OXz4c1E5weZFdeJscRXDiPq/UATQhU2duek/7yb0fjU9z30BqWNg
         x4RMAiMg/UcstwWA7hRnhC+H/0ShSAZhStD2zrbrz1b2em4265Nn9mYghvggwILbtr
         J9yvZe+oNr9vg==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: Convert UniPhier SD controller to json-schema
Date:   Sat, 22 Feb 2020 20:25:41 +0900
Message-Id: <20200222112541.573-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Convert the UniPhier SD controller binding to DT schema format.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

If there is a better way to describe reset-names,
please let me know.


 .../bindings/mmc/socionext,uniphier-sd.yaml   | 99 +++++++++++++++++++
 .../devicetree/bindings/mmc/uniphier-sd.txt   | 55 -----------
 2 files changed, 99 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/socionext,uniphier-sd.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/uniphier-sd.txt

diff --git a/Documentation/devicetree/bindings/mmc/socionext,uniphier-sd.yaml b/Documentation/devicetree/bindings/mmc/socionext,uniphier-sd.yaml
new file mode 100644
index 000000000000..cdfac9b4411b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/socionext,uniphier-sd.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/socionext,uniphier-sd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: UniPhier SD/SDIO/eMMC controller
+
+maintainers:
+  - Masahiro Yamada <yamada.masahiro@socionext.com>
+
+properties:
+  compatible:
+    description: version 2.91, 3.1, 3.1.1, respectively
+    enum:
+      - socionext,uniphier-sd-v2.91
+      - socionext,uniphier-sd-v3.1
+      - socionext,uniphier-sd-v3.1.1
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  reset-names:
+    description: |
+      There are three reset signals at maximum
+        host:   mandatory for all variants
+        bridge: exist only for version 2.91
+        hw:     optional. exist if eMMC hw reset line is available
+    oneOf:
+      - const: host
+      - items:
+        - const: host
+        - const: bridge
+      - items:
+        - const: host
+        - const: hw
+      - items:
+        - const: host
+        - const: bridge
+        - const: hw
+
+  resets:
+    minItems: 1
+    maxItems: 3
+
+allOf:
+  - $ref: mmc-controller.yaml
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: socionext,uniphier-sd-v2.91
+    then:
+      properties:
+        reset-names:
+          contains:
+            const: bridge
+    else:
+      properties:
+        reset-names:
+          not:
+            contains:
+              const: bridge
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - reset-names
+  - resets
+
+examples:
+  - |
+    sd: mmc@5a400000 {
+        compatible = "socionext,uniphier-sd-v2.91";
+        reg = <0x5a400000 0x200>;
+        interrupts = <0 76 4>;
+        pinctrl-names = "default", "uhs";
+        pinctrl-0 = <&pinctrl_sd>;
+        pinctrl-1 = <&pinctrl_sd_uhs>;
+        clocks = <&mio_clk 0>;
+        reset-names = "host", "bridge";
+        resets = <&mio_rst 0>, <&mio_rst 3>;
+        dma-names = "rx-tx";
+        dmas = <&dmac 4>;
+        bus-width = <4>;
+        cap-sd-highspeed;
+        sd-uhs-sdr12;
+        sd-uhs-sdr25;
+        sd-uhs-sdr50;
+    };
diff --git a/Documentation/devicetree/bindings/mmc/uniphier-sd.txt b/Documentation/devicetree/bindings/mmc/uniphier-sd.txt
deleted file mode 100644
index e1d658755722..000000000000
--- a/Documentation/devicetree/bindings/mmc/uniphier-sd.txt
+++ /dev/null
@@ -1,55 +0,0 @@
-UniPhier SD/eMMC controller
-
-Required properties:
-- compatible: should be one of the following:
-    "socionext,uniphier-sd-v2.91"  - IP version 2.91
-    "socionext,uniphier-sd-v3.1"   - IP version 3.1
-    "socionext,uniphier-sd-v3.1.1" - IP version 3.1.1
-- reg: offset and length of the register set for the device.
-- interrupts: a single interrupt specifier.
-- clocks: a single clock specifier of the controller clock.
-- reset-names: should contain the following:
-    "host"   - mandatory for all versions
-    "bridge" - should exist only for "socionext,uniphier-sd-v2.91"
-    "hw"     - should exist if eMMC hw reset line is available
-- resets: a list of reset specifiers, corresponding to the reset-names
-
-Optional properties:
-- pinctrl-names: if present, should contain the following:
-    "default" - should exist for all instances
-    "uhs"     - should exist for SD instance with UHS support
-- pinctrl-0: pin control state for the default mode
-- pinctrl-1: pin control state for the UHS mode
-- dma-names: should be "rx-tx" if present.
-  This property can exist only for "socionext,uniphier-sd-v2.91".
-- dmas: a single DMA channel specifier
-  This property can exist only for "socionext,uniphier-sd-v2.91".
-- bus-width: see mmc.txt
-- cap-sd-highspeed: see mmc.txt
-- cap-mmc-highspeed: see mmc.txt
-- sd-uhs-sdr12: see mmc.txt
-- sd-uhs-sdr25: see mmc.txt
-- sd-uhs-sdr50: see mmc.txt
-- cap-mmc-hw-reset: should exist if reset-names contains "hw". see mmc.txt
-- non-removable: see mmc.txt
-
-Example:
-
-	sd: sdhc@5a400000 {
-		compatible = "socionext,uniphier-sd-v2.91";
-		reg = <0x5a400000 0x200>;
-		interrupts = <0 76 4>;
-		pinctrl-names = "default", "uhs";
-		pinctrl-0 = <&pinctrl_sd>;
-		pinctrl-1 = <&pinctrl_sd_uhs>;
-		clocks = <&mio_clk 0>;
-		reset-names = "host", "bridge";
-		resets = <&mio_rst 0>, <&mio_rst 3>;
-		dma-names = "rx-tx";
-		dmas = <&dmac 4>;
-		bus-width = <4>;
-		cap-sd-highspeed;
-		sd-uhs-sdr12;
-		sd-uhs-sdr25;
-		sd-uhs-sdr50;
-	};
-- 
2.17.1

