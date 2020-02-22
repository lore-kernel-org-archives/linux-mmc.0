Return-Path: <SRS0=hQtV=4K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67186C35666
	for <linux-mmc@archiver.kernel.org>; Sat, 22 Feb 2020 14:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3953C2192A
	for <linux-mmc@archiver.kernel.org>; Sat, 22 Feb 2020 14:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="zJUnV+qB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgBVOf0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 22 Feb 2020 09:35:26 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:46166 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgBVOf0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Feb 2020 09:35:26 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 01MEYkvx030545;
        Sat, 22 Feb 2020 23:34:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 01MEYkvx030545
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582382087;
        bh=5R5701ZYweXd3rfKO1OuY5xutb8Z93pleM360HuNZrI=;
        h=From:To:Cc:Subject:Date:From;
        b=zJUnV+qBlhmzCwf/FiFVYh2VD9T/1jkoMKbG6TE0jjLqdw+etoS2G+BpZg16Wf4aZ
         U6CiiXQOtiiUxgAGp189hKd/qY/sE83ORQvW6mgq3L2n9sIwCXaE96nKOJrvBlNo8x
         zWIBFOP5vtC5PwVMj2usEkwGYCSgJwVJlOIdPzevq299wYKyvb81zgRZpJ7ZtRg7cr
         FdVGmklnZtm75JOzxXLADMyO0w0s8or1pCdj0AmGBOJkXJ2ozioU9eANgFDyV7WjHR
         fW4y2TUcBBL1+k7DWsewna6gxPYZGrELlNxtNXzSJe7Gg1mXGvm4i86Hp/qUaZbs+S
         gydVON6OZ39hA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: [PATCH v2] dt-bindings: mmc: Convert Cadence SD/SDIO/eMMC controller to json-schema
Date:   Sat, 22 Feb 2020 23:34:44 +0900
Message-Id: <20200222143444.5135-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Convert the Cadence SD/SDIO/eMMC host controller IP (a.k.a. SD4HC)
binding to DT schema format.

Socionext UniPhier ARM 64-bit SoCs are integrated with this IP.

Cc: Piotr Sroka <piotrs@cadence.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I wanted to keep some precious comments, which apply to multiple
properties.

I do not think 'description:' is a good fit for this.

I was searching for a way to insert a comment line that does not
affect the schema.

The $comment did not work. I just use '#', which is YAML comment.
If there is a better way, please let me know.


Changes in v2:
  - fix schema warning in example

 .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 143 ++++++++++++++++++
 .../devicetree/bindings/mmc/sdhci-cadence.txt |  80 ----------
 2 files changed, 143 insertions(+), 80 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-cadence.txt

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
new file mode 100644
index 000000000000..2f45dd0d04db
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -0,0 +1,143 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/cdns,sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
+
+maintainers:
+  - Masahiro Yamada <yamada.masahiro@socionext.com>
+  - Piotr Sroka <piotrs@cadence.com>
+
+allOf:
+  - $ref: mmc-controller.yaml
+
+properties:
+  compatible:
+    items:
+      - enum:
+         - socionext,uniphier-sd4hc
+      - const: cdns,sd4hc
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
+  # PHY DLL input delays:
+  # They are used to delay the data valid window, and align the window to
+  # sampling clock. The delay starts from 5ns (for delay parameter equal to 0)
+  # and it is increased by 2.5ns in each step.
+
+  cdns,phy-input-delay-sd-highspeed:
+    description: Value of the delay in the input path for SD high-speed timing
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+      - maximum: 0x1f
+
+  cdns,phy-input-delay-legacy:
+    description: Value of the delay in the input path for legacy timing
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+      - maximum: 0x1f
+
+  cdns,phy-input-delay-sd-uhs-sdr12:
+    description: Value of the delay in the input path for SD UHS SDR12 timing
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+      - maximum: 0x1f
+
+  cdns,phy-input-delay-sd-uhs-sdr25:
+    description: Value of the delay in the input path for SD UHS SDR25 timing
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+      - maximum: 0x1f
+
+  cdns,phy-input-delay-sd-uhs-sdr50:
+    description: Value of the delay in the input path for SD UHS SDR50 timing
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+      - maximum: 0x1f
+
+  cdns,phy-input-delay-sd-uhs-ddr50:
+    description: Value of the delay in the input path for SD UHS DDR50 timing
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+      - maximum: 0x1f
+
+  cdns,phy-input-delay-mmc-highspeed:
+    description: Value of the delay in the input path for MMC high-speed timing
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+      - maximum: 0x1f
+
+  cdns,phy-input-delay-mmc-ddr:
+    description: Value of the delay in the input path for eMMC high-speed DDR timing
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+      - maximum: 0x1f
+
+  # PHY DLL clock delays:
+  # Each delay property represents the fraction of the clock period.
+  # The approximate delay value will be
+  # (<delay property value>/128)*sdmclk_clock_period.
+
+  cdns,phy-dll-delay-sdclk:
+    description: |
+      Value of the delay introduced on the sdclk output for all modes except
+      HS200, HS400 and HS400_ES.
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+      - maximum: 0x7f
+
+  cdns,phy-dll-delay-sdclk-hsmmc:
+    description: |
+      Value of the delay introduced on the sdclk output for HS200, HS400 and
+      HS400_ES speed modes.
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+      - maximum: 0x7f
+
+  cdns,phy-dll-delay-strobe:
+    description: |
+      Value of the delay introduced on the dat_strobe input used in
+      HS400 / HS400_ES speed modes.
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+      - maximum: 0x7f
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+examples:
+  - |
+    emmc: mmc@5a000000 {
+        compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
+        reg = <0x5a000000 0x400>;
+        interrupts = <0 78 4>;
+        clocks = <&clk 4>;
+        bus-width = <8>;
+        mmc-ddr-1_8v;
+        mmc-hs200-1_8v;
+        mmc-hs400-1_8v;
+        cdns,phy-dll-delay-sdclk = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt b/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
deleted file mode 100644
index fa423c277853..000000000000
--- a/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
+++ /dev/null
@@ -1,80 +0,0 @@
-* Cadence SD/SDIO/eMMC Host Controller
-
-Required properties:
-- compatible: should be one of the following:
-    "cdns,sd4hc"               - default of the IP
-    "socionext,uniphier-sd4hc" - for Socionext UniPhier SoCs
-- reg: offset and length of the register set for the device.
-- interrupts: a single interrupt specifier.
-- clocks: phandle to the input clock.
-
-Optional properties:
-For eMMC configuration, supported speed modes are not indicated by the SDHCI
-Capabilities Register.  Instead, the following properties should be specified
-if supported.  See mmc.txt for details.
-- mmc-ddr-1_8v
-- mmc-ddr-1_2v
-- mmc-hs200-1_8v
-- mmc-hs200-1_2v
-- mmc-hs400-1_8v
-- mmc-hs400-1_2v
-
-Some PHY delays can be configured by following properties.
-PHY DLL input delays:
-They are used to delay the data valid window, and align the window
-to sampling clock. The delay starts from 5ns (for delay parameter equal to 0)
-and it is increased by 2.5ns in each step.
-- cdns,phy-input-delay-sd-highspeed:
-  Value of the delay in the input path for SD high-speed timing
-  Valid range = [0:0x1F].
-- cdns,phy-input-delay-legacy:
-  Value of the delay in the input path for legacy timing
-  Valid range = [0:0x1F].
-- cdns,phy-input-delay-sd-uhs-sdr12:
-  Value of the delay in the input path for SD UHS SDR12 timing
-  Valid range = [0:0x1F].
-- cdns,phy-input-delay-sd-uhs-sdr25:
-  Value of the delay in the input path for SD UHS SDR25 timing
-  Valid range = [0:0x1F].
-- cdns,phy-input-delay-sd-uhs-sdr50:
-  Value of the delay in the input path for SD UHS SDR50 timing
-  Valid range = [0:0x1F].
-- cdns,phy-input-delay-sd-uhs-ddr50:
-  Value of the delay in the input path for SD UHS DDR50 timing
-  Valid range = [0:0x1F].
-- cdns,phy-input-delay-mmc-highspeed:
-  Value of the delay in the input path for MMC high-speed timing
-  Valid range = [0:0x1F].
-- cdns,phy-input-delay-mmc-ddr:
-  Value of the delay in the input path for eMMC high-speed DDR timing
-  Valid range = [0:0x1F].
-
-PHY DLL clock delays:
-Each delay property represents the fraction of the clock period.
-The approximate delay value will be
-(<delay property value>/128)*sdmclk_clock_period.
-- cdns,phy-dll-delay-sdclk:
-  Value of the delay introduced on the sdclk output
-  for all modes except HS200, HS400 and HS400_ES.
-  Valid range = [0:0x7F].
-- cdns,phy-dll-delay-sdclk-hsmmc:
-  Value of the delay introduced on the sdclk output
-  for HS200, HS400 and HS400_ES speed modes.
-  Valid range = [0:0x7F].
-- cdns,phy-dll-delay-strobe:
-  Value of the delay introduced on the dat_strobe input
-  used in HS400 / HS400_ES speed modes.
-  Valid range = [0:0x7F].
-
-Example:
-	emmc: sdhci@5a000000 {
-		compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
-		reg = <0x5a000000 0x400>;
-		interrupts = <0 78 4>;
-		clocks = <&clk 4>;
-		bus-width = <8>;
-		mmc-ddr-1_8v;
-		mmc-hs200-1_8v;
-		mmc-hs400-1_8v;
-		cdns,phy-dll-delay-sdclk = <0>;
-	};
-- 
2.17.1

